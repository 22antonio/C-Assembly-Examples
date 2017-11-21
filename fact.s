	# Name: Antonio Medel
	# Assignment: Programming Assignment 7 - fact.s
	# Date: Nov. 20, 2017
	
	.text
	.globl	fact
	.type	fact, @function
fact:
	pushq	%rbp										# set up stack
	movq	%rsp, %rbp
	subq	$16, %rsp
	
	movl	%edi, -4(%rbp)								# if n is less then or equal to 0, return 1
	cmpl	$0, -4(%rbp)
	jg		computeFact									# else jump to computeFact
	movl	$1, %eax
	jmp		endFact										

computeFact:											# else compute n * fact(n-1)
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	fact

	imull	-4(%rbp), %eax
endFact:
	leave
	ret
# ---------------------------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------------------------------------------
prompt:
	.string	"Please enter an integer value: "
userInput:
	.string	"%d"
result:
	.string	"Your factorial of %d is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp										# set up stack
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%fs:40, %rax								# create variables and prompt user with puts since there is only one argument
	movq	%rax, -8(%rbp)								
	xorl	%eax, %eax
	movl	$prompt, %edi
	movl	$0, %eax
	call	puts

	leaq	-16(%rbp), %rsi								# take the userInput with scanf
	movl	$userInput, %edi
	movl	$0, %eax
	call	scanf

	movl	-16(%rbp), %edi								# call fact to compute the factorial of the userInput
	call	fact

	movl	%eax, -12(%rbp)								# put the userInput and result into esi and edi as arguments to printf
	movl	-16(%rbp), %eax
	movl	-12(%rbp), %edx
	movl	%eax, %esi
	movl	$result, %edi
	movl	$0, %eax
	call	printf

	movl	$0, %eax									# end stack, return 0
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	leave
	ret
