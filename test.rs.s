	.text
	.syntax unified
	.eabi_attribute	67, "2.09"
	.eabi_attribute	6, 13
	.eabi_attribute	7, 77
	.eabi_attribute	8, 0
	.eabi_attribute	9, 2
	.eabi_attribute	34, 1
	.eabi_attribute	17, 1
	.eabi_attribute	20, 1
	.eabi_attribute	21, 0
	.eabi_attribute	23, 3
	.eabi_attribute	24, 1
	.eabi_attribute	25, 1
	.eabi_attribute	38, 1
	.eabi_attribute	14, 0
	.file	"test.3a1fbbbh-cgu.0"
	.section	.text._ZN4test10test_basic17h00820f33199f9178E,"ax",%progbits
	.globl	_ZN4test10test_basic17h00820f33199f9178E
	.p2align	1
	.type	_ZN4test10test_basic17h00820f33199f9178E,%function
	.code	16
	.thumb_func
_ZN4test10test_basic17h00820f33199f9178E:
	.fnstart
	.save	{r7, lr}
	push	{r7, lr}
	.setfp	r7, sp
	mov	r7, sp
	@APP
	svc	#1
	@NO_APP
	pop.w	{r7, lr}
	b	foobar
.Lfunc_end0:
	.size	_ZN4test10test_basic17h00820f33199f9178E, .Lfunc_end0-_ZN4test10test_basic17h00820f33199f9178E
	.cantunwind
	.fnend

	.section	.text._ZN4test22test_intricate_optimal17h901d4207cbf097c0E,"ax",%progbits
	.globl	_ZN4test22test_intricate_optimal17h901d4207cbf097c0E
	.p2align	1
	.type	_ZN4test22test_intricate_optimal17h901d4207cbf097c0E,%function
	.code	16
	.thumb_func
_ZN4test22test_intricate_optimal17h901d4207cbf097c0E:
	.fnstart
	.save	{r7, lr}
	push	{r7, lr}
	.setfp	r7, sp
	mov	r7, sp
	mov	r3, r1
	mov	r2, r0
	movs	r1, #1
	movs	r0, #5
	@APP
	svc	#1
	@NO_APP
	cbz	r0, .LBB1_2
	movw	r0, :lower16:.L__unnamed_1
	movt	r0, :upper16:.L__unnamed_1
	pop.w	{r7, lr}
	b	print2
.LBB1_2:
	movw	r0, :lower16:.L__unnamed_2
	movt	r0, :upper16:.L__unnamed_2
	pop.w	{r7, lr}
	b	print0
.Lfunc_end1:
	.size	_ZN4test22test_intricate_optimal17h901d4207cbf097c0E, .Lfunc_end1-_ZN4test22test_intricate_optimal17h901d4207cbf097c0E
	.cantunwind
	.fnend

	.section	.text._ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E,"ax",%progbits
	.globl	_ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E
	.p2align	1
	.type	_ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E,%function
	.code	16
	.thumb_func
_ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E:
	.fnstart
	.save	{r7, lr}
	push	{r7, lr}
	.setfp	r7, sp
	mov	r7, sp
	.pad	#8
	sub	sp, #8
	movs	r0, #5
	movs	r2, #0
	movs	r3, #0
	movs	r1, #1
	@APP
	svc	#1
	@NO_APP
	mov	r12, r0
	mov	lr, r1
	movw	r0, :lower16:.L__unnamed_3
	strd	r3, r2, [sp]
	movt	r0, :upper16:.L__unnamed_3
	mov	r1, r12
	mov	r2, lr
	bl	print3
	add	sp, #8
	pop	{r7, pc}
.Lfunc_end2:
	.size	_ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E, .Lfunc_end2-_ZN4test25test_intricate_nonoptimal17h0f4d4dab0e4d2e56E
	.cantunwind
	.fnend

	.type	.L__unnamed_1,%object
	.section	.rodata..L__unnamed_1,"a",%progbits
.L__unnamed_1:
	.ascii	"Started alarm returned value {}, othervalues {}"
	.size	.L__unnamed_1, 47

	.type	.L__unnamed_2,%object
	.section	.rodata..L__unnamed_2,"a",%progbits
.L__unnamed_2:
	.ascii	"Start alarm failed"
	.size	.L__unnamed_2, 18

	.type	.L__unnamed_3,%object
	.section	.rodata..L__unnamed_3,"a",%progbits
.L__unnamed_3:
	.ascii	"othervalues %llu Started alarm had return code %i, value %i"
	.size	.L__unnamed_3, 59

	.section	".note.GNU-stack","",%progbits
	.eabi_attribute	30, 2
