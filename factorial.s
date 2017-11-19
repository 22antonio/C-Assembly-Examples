	.file	"factorial.c"
	.text
	.globl	fact
	.type	fact, @function
fact:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jg		.L2
	movl	$1, %eax
	jmp		.L3
.L2:
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	fact
	imull	-4(%rbp), %eax
.L3:
	leave
	ret
# ---------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------
.LFE0:
	.size	fact, .-fact
	.section	.rodata
.LC0:
	.string	"Please enter an integer value: "
.LC1:
	.string	"%d"
.LC2:
	.string	"Your factorial of %d is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf

	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	scanf

	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	fact

	movl	%eax, -12(%rbp)
	movl	-16(%rbp), %eax
	movl	-12(%rbp), %edx
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf

	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L6

.L6:
	leave
	ret
