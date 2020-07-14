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
	.file	"test.c"
	.text
	.align	2
	.global	test_basic
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	test_basic, %function
test_basic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	.syntax divided
@ 6 "test.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	bl	foobar
	pop	{r4, lr}
	bx	lr
	.size	test_basic, .-test_basic
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Started alarm returned value %i, othervalues %llu\000"
	.align	2
.LC1:
	.ascii	"Start alarm failed\000"
	.text
	.align	2
	.global	test_intricate_optimal
	.syntax unified
	.arm
	.fpu softvfp
	.type	test_intricate_optimal, %function
test_intricate_optimal:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r2, r0
	mov	r3, r1
	mov	r0, #5
	mov	r1, #1
	push	{r4, lr}
	.syntax divided
@ 6 "test.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	cmp	r0, #0
	beq	.L5
	ldr	r0, .L8
	bl	printf
	pop	{r4, lr}
	bx	lr
.L5:
	ldr	r0, .L8+4
	bl	printf
	pop	{r4, lr}
	bx	lr
.L9:
	.align	2
.L8:
	.word	.LC0
	.word	.LC1
	.size	test_intricate_optimal, .-test_intricate_optimal
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"othervalues %llu Started alarm had return code %i, "
	.ascii	"value %i\000"
	.text
	.align	2
	.global	test_intricate_nonoptimal
	.syntax unified
	.arm
	.fpu softvfp
	.type	test_intricate_nonoptimal, %function
test_intricate_nonoptimal:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	mov	r2, r0
	sub	sp, sp, #12
	mov	r3, r1
	mov	r0, #5
	mov	r1, #1
	.syntax divided
@ 6 "test.h" 1
	svc 2
@ 0 "" 2
	.arm
	.syntax unified
	mov	ip, r1
	str	r2, [sp, #4]
	mov	r1, r0
	mov	r2, ip
	str	r3, [sp]
	ldr	r0, .L12
	bl	printf
	add	sp, sp, #12
	@ sp needed
	ldr	lr, [sp], #4
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LC2
	.size	test_intricate_nonoptimal, .-test_intricate_nonoptimal
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 9-2019-q4-major) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]"
