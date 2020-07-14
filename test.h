static inline void command(int *rr0, int *rr1, int *rr2, int *rr3) {
  register int r0 asm ("r0") = *rr0;
  register int r1 asm ("r1") = *rr1;
  register int r2 asm ("r2") = *rr2;
  register int r3 asm ("r3") = *rr3;
  asm volatile (
    "svc 2"
    : "=r"(r0), "=r"(r1), "=r"(r2), "=r"(r3)
    : "r" (r0), "r" (r1), "r" (r2), "r" (r3)
    : "memory"
    );
  *rr0 = r0;
  *rr1 = r1;
  *rr2 = r2;
  *rr3 = r3;
}
