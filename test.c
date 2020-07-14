#include "test.h"

extern void foobar(int r0, int r1, int r2, int r3);

/* A very basic test.
 * 
 * This is the best case scenario where the arguments are already
 * pre-initialized in the right reginster and the results are passed
 * as-is to another function in the same order.
 *
 * We expect to see just an `svc` and branch to foobar in the compiled
 * assembly, aside from the normal C function prologue and epilogue.
 */
void test_basic(int r0, int r1, int r2, int r3) {
    command(&r0, &r1, &r2, &r3);
    foobar(r0, r1, r2, r3);
}

#include <stdio.h>
/* Actually doing something with the values.
 * 
 * This test now has arguments initialized in the wrong place, so it'll need
 * to move registers around before the system call. It also does some
 * post-processing on the results. However, the post-processing (cleverly!)
 * preserves register location.
 *
 * We expect to see some register shuffling but no register spills onto the stack.
 */
void test_intricate_optimal(unsigned int now, unsigned int dt) {
    int driver = 5;
    int cmd = 1;
    command(&driver, &cmd, (int*)&now, (int*)&dt);
    if (driver != 0) {
        printf("Started alarm returned value %i, othervalues %llu", cmd, ((unsigned long long) dt) << 32 | (unsigned long long)now);
    } else {
        printf("Start alarm failed");
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
void test_intricate_nonoptimal(unsigned int now, unsigned int dt) {
    int driver = 5;
    int cmd = 1;
    command(&driver, &cmd, (int*)&now, (int*)&dt);
    printf("othervalues %llu Started alarm had return code %i, value %i", driver, cmd, ((unsigned long long) now) << 32 | (unsigned long long)dt);
}
