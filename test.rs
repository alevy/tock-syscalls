#![feature(asm)]
#![no_std]

fn command(mut r0: usize, mut r1: usize, mut r2: usize, mut r3: usize) -> (usize, usize, usize, usize) {
    unsafe {
        asm!(
            "svc 1",
            inout("r0") r0, // syscall number
            inout("r1") r1, // fd (stdout)
            inout("r2") r2,
            inout("r3") r3,
        );
    }
    return (r0, r1, r2, r3);
}

extern {
    fn foobar(r0: usize, r1: usize, r2: usize, r3: usize);
    fn print0(r0: *const u8);
    fn print2(r0: *const u8, arg1: usize, arg2: u64);
    fn print3(r0: *const u8, arg1: usize, arg2: usize, arg3: u64);
}

/* A very basic test.
 * 
 * This is the best case scenario where the arguments are already
 * pre-initialized in the right reginster and the results are passed
 * as-is to another function in the same order.
 *
 * We expect to see just an `svc` and branch to foobar in the compiled
 * assembly, aside from the normal C function prologue and epilogue.
 */
pub fn test_basic(r0: usize, r1: usize, r2: usize, r3: usize) {
    let (res0, res1, res2, res3) = command(r0, r1, r2, r3);
    unsafe {
        foobar(res0, res1, res2, res3);
    }
}

/* Actually doing something with the values.
 * 
 * This test now has arguments initialized in the wrong place, so it'll need
 * to move registers around before the system call. It also does some
 * post-processing on the results. However, the post-processing (cleverly!)
 * preserves register location.
 *
 * We expect to see some register shuffling but no register spills onto the stack.
 */
pub fn test_intricate_optimal(now: usize, dt: usize) {
    let driver = 5;
    let cmd = 1;
    let (res, val, now, dt) = command(driver, cmd, now, dt);
    if res != 0 {
        unsafe {
            print2("Started alarm returned value {}, othervalues {}".as_ptr(), val, (dt as u64) << 32 | (now as u64));
        }
    } else {
        unsafe {
            print0("Start alarm failed".as_ptr());
        }
    }
}

/* Abandoining contrivances.
 * 
 * This test is non-optimal in the both arguments and result processing does
 * not preserve register location for any of the variables.
 *
 * We expect to see some register shuffling including register spills, at least
 * to pass the 5th word to `printf` (which is 1-more than the number of registers
 * reserved for arguments in Thumb).
 */
pub fn test_intricate_nonoptimal() {
    let driver = 5;
    let cmd = 1;
    let (res, val, now, dt) = command(driver, cmd, 0, 0);
    unsafe {
        print3("othervalues %llu Started alarm had return code %i, value %i".as_ptr(), res, val, (now as u64) << 32 | (dt as u64));
    }
}
