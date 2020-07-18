	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"test2.c"
	.text
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	ldr	r0, .L4
	ldr	r1, .L4+4
	ldr	r2, .L4+8
	ldr	r3, .L4+12
	.syntax divided
@ 53 "test2.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	mov	lr, r1
	ldr	r2, .L4+8
	and	lr, lr, r0
	ldr	r1, .L4+4
	ldr	r0, .L4
	ldr	r3, .L4+12
	.syntax divided
@ 76 "test2.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	and	r2, r2, r0
	and	ip, r2, r1
	ldr	r0, .L4
	ldr	r1, .L4+4
	ldr	r2, .L4+8
	ldr	r3, .L4+12
	.syntax divided
@ 30 "test2.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	and	r2, r2, r3
	and	r2, r2, r0
	eor	ip, ip, lr
	and	r2, r2, r1
	eor	r0, r2, ip
	ldr	lr, [sp], #4
	bx	lr
.L5:
	.align	2
.L4:
	.word	51966
	.word	57005
	.word	57034
	.word	64429
	.size	main, .-main
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 9-2019-q4-major) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
