#include "test2.h"

/* A basic test including all `command`-wrapper funtions.
 *
 * The goal is to see whether gcc can deduce that the pointers passed
 * in as `ret2` and `ret3` respectively can be optimized to register
 * accesses, and whether gcc avoids register shuffling by falling back
 * to registers not used in the system call.
 *
 * We expect this function to have 3 `svc 2` instructions inlined, and
 * only use two additional registers to hold `res2` and `res3`. It
 * should not access memory.
 */
int main(void) {
    int retval;
    int res2, res3;

    int64_t cmd2 = command2(0xCAFE, 0xDEAD, 0xDECA, 0xFBAD);
    retval = (cmd2 >> 32) & cmd2;

    int64_t cmd3 = command3(0xCAFE, 0xDEAD, 0xDECA, 0xFBAD, &res2);
    retval ^= res2 & (cmd3 >> 32) & cmd3;

    int64_t cmd4 = command4(0xCAFE, 0xDEAD, 0xDECA, 0xFBAD, &res2, &res3);
    retval ^= res2 & res3 & (cmd4 >> 32) & cmd4;

    return retval;
}
