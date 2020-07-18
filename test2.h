#include <stdint.h>

/* command system call with 4 return values
 *
 * The first two return values are jointly returned as an int64_t,
 * whereas the third and fourth get written to pointers supplied as
 * arguments.
 *
 * By forcing the compiler to inline this function, the pointer writes
 * will be optimized to register accesses in the calling
 * function. This can work as long as the target variables are defined
 * directly in the calling function, or another inlinable
 * function. Defining another non-inlined wrapper around this function
 * will cause it to write to memory.
 *
 * Unfortunately the caller has to allocate memory on the stack (may
 * be optimized out) even if the additional return values are not
 * required. For these reasons, the `command3` and `command2` wrappers
 * are provided.
 *
 * Alternatively, this function could check for NULL-pointers, which
 * requires additional optimizations.
 */
__attribute__((always_inline))
inline int64_t command4(uint32_t driver, uint32_t command, int data, int arg2, int* ret2, int* ret3) {
  register uint32_t r0 asm ("r0") = driver;
  register uint32_t r1 asm ("r1") = command;
  register uint32_t r2 asm ("r2") = data;
  register uint32_t r3 asm ("r3") = arg2;
  asm volatile (
    "svc 2"
    : "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
    : "r" (r0), "r" (r1), "r" (r2), "r" (r3)
    : "memory"
    );

  *ret2 = r2;
  *ret3 = r3;

  return (int64_t) ((uint64_t) r1 << 32) | r0;
}

/* command system call with 2 return values
 *
 * The return values are jointly returned as an int64_t.
 */
__attribute__((always_inline))
inline int64_t command2(uint32_t driver, uint32_t command, int data, int arg2) {
  register uint32_t r0 asm ("r0") = driver;
  register uint32_t r1 asm ("r1") = command;
  register uint32_t r2 asm ("r2") = data;
  register uint32_t r3 asm ("r3") = arg2;
  asm volatile (
    "svc 2"
    : "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
    : "r" (r0), "r" (r1), "r" (r2), "r" (r3)
    : "memory"
    );

  return (int64_t) ((uint64_t) r1 << 32) | r0;
}

/* command system call with 2 return values
 *
 * The first two return values are jointly returned as an int64_t,
 * whereas the third gets written to a pointer supplied as an
 * argument.
 */
__attribute__((always_inline))
inline int64_t command3(uint32_t driver, uint32_t command, int data, int arg2, int* ret2) {
  register uint32_t r0 asm ("r0") = driver;
  register uint32_t r1 asm ("r1") = command;

  register uint32_t r2 asm ("r2") = data;
  register uint32_t r3 asm ("r3") = arg2;
  asm volatile (
    "svc 2"
    : "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
    : "r" (r0), "r" (r1), "r" (r2), "r" (r3)
    : "memory"
    );

  *ret2 = r2;

  return (int64_t) ((uint64_t) r1 << 32) | r0;
}
