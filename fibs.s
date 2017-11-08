# ====================================================================================
	.file	"fib.c"
	.text
	.globl	fib
	.type	fib, @function
fib: 							# fib function
.firstIf:
	pushq	%rbp				# stack set up
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$24, %rsp			# substracting 24 from the stack pointer, making room for stack

								# first 'if' statement 
	movl	%edi, -20(%rbp) 	# placing what is in edi -20 below base pointer, (int n)
	cmpl	$0, -20(%rbp)		# comparing the integer number 0 to what is -20 below the base pointer
	jne		.secondIf			# if it is not equl to next if 

	movl	$0, %eax			# but if it is equal then continue, move 0 into eax
	jmp		.returnOp			# jump to return operation

.secondIf:							
	cmpl	$1, -20(%rbp)		# comparing the integer number 1 to what is -20 below the base pointer
	jne		.elseReturn			# if it is not equal jump to the fib operation
	movl	$1, %eax			# but if it is equal, move 1 into eax
	jmp		.returnOp			# jump to return operation

.elseReturn:
								# start of first fib call

	movl	-20(%rbp), %eax		# put what was -20 below base pointer into eax, put n in eax
	subl	$1, %eax			# substract 1 from eax, (n-1)
	movl	%eax, %edi			# mov eax into edi, store anwser into edi, new n for recursive call to fib
	call	fib					# recursive call, fib(n - 1) or fib(edi)
	movl	%eax, %ebx 			# mov eax into ebx, answer from (n-1)

								# start of second fib call 

	movl	-20(%rbp), %eax		# put what was -20 below base pointer into eax, put n in eax
	subl	$2, %eax			# substract 1 from eax, (n-1)
	movl	%eax, %edi			# mov eax into edi, store anwser into edi, new n for recursive call to fib
	call	fib					# recursive call, fib(n - 2)

								# start of add 
	addl	%ebx, %eax			# adding both fib function calls 

.returnOp:
	addq	$24, %rsp			# placing stack pointer where it was
	popq	%rbx
	popq	%rbp
	ret

# =====================================================================================

.prompt:
	.string	"Please enter the number of the fib sequence:"
.inputInt:
	.string	"%d"
.outputInt:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.mainFunction:
	pushq	%rbp				# stack set up
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	%edi, -20(%rbp)		# mov edi -20 below base pointer
	movl	$.prompt, %edi		# mov the string prompt into edi as argument 
	movl	$0, %eax			
	call	printf				# call prinf, prompts user
	leaq	-20(%rbp), %rax		# load effective address of what is in -20 below base pointer into rax

	movq	%rax, %rsi			# mov rax into rsi as argument 
	movl	$.inputInt, %edi	# scanf for user input
	movl	$0, %eax			
	call	scanf				# call scanf, waits for input from user

	movl	-20(%rbp), %eax		# mov what is -20 below base pointer into eax 
	movl	%eax, %edi			# mov what is in eax into edi as argument to fib function
	call	fib					# call fib function, 

	movl	%eax, -4(%rbp)		# mov what value in eax into -4 below base pointer
	movl	-4(%rbp), %eax		# mov address of -4 base pointer into eax
	movl	%eax, %esi			# mov eax into esi as second argument to printf
	movl	$.outputInt, %edi	# placing string into edi as first argument to printf
	movl	$0, %eax
	call	printf				# call printf

	movl	$0, %eax			# start of return 0
	leave
	ret