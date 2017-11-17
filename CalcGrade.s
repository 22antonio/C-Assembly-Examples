.userPrompt:
	.string	"Enter percent number to display letter grade: "
.userInput:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.mainBody:
	pushq	%rbp					# setting up the stack
	movq	%rsp, %rbp
	subq	$16, %rsp				# subtract some arbitrary number to create space for stack

	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$.userPrompt, %edi
	call	puts					# call puts as there is only one argurment and so no need to use prinf

	leaq	-12(%rbp), %rax
	movq	%rax, %rsi
	movl	$.userInput, %edi
	movl	$0, %eax
	call	scanf					# call scanf for user input

	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	CalcGrade				# call CalcGrade function

	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je		.endFunction
.endFunction:
	leave
	ret
# ------------------------------------------------------------------
.printGrade:
	.string	"%c \n"
.printIfInvalid:
	.string	"not a valid value! \n"
	.text
	.globl	CalcGrade
	.type	CalcGrade, @function 
CalcGrade:
.ifGradeA:							# all ifs are identical with differences in grade letters
	pushq	%rbp					# set up stack
	movq	%rsp, %rbp
	subq	$32, %rsp				# subtract some arbitrary number to create space for the stack 
	
	movl	%edi, -20(%rbp)			# store the vaule that is inside edi, as it will be clobbered later
	cmpl	$100, -20(%rbp)			# compare that number to 100 
	jg		.ifGradeB				# jump to ifGradeB if compare fails
	cmpl	$89, -20(%rbp)			# compare that number to 89, make sure it is not a B
	jle		.ifGradeB				# jump to ifGradeB if compare fails
	movb	$65, %al				# pass the ASCII value of capital 'A' into al
	movl	%eax, %esi				# mov from al into esi was not supported so I had to use %eax and it worked with %eax
	movl	$.printGrade, %edi		# pass printGrade into edi as an argument
	movl	$0, %eax
	call	printf					# call printf

	jmp		.endIf					# jump to the end of the if statement if criteria are met

.ifGradeB:
	cmpl	$89, -20(%rbp)
	jg		.ifGradeC				# jump to ifGradeC if compare fails
	cmpl	$79, -20(%rbp)
	jle		.ifGradeC				# jump to ifGradeC if compare fails
	movb	$66, %al				# pass the ASCII value of capital 'B' into al
	movl	%eax, %esi
	movl	$.printGrade, %edi
	movl	$0, %eax
	call	printf

	jmp		.endIf
.ifGradeC:
	cmpl	$79, -20(%rbp)
	jg		.ifGradeD				# jump to ifGradeD if compare fails
	cmpl	$69, -20(%rbp)
	jle		.ifGradeD				# jump to ifGradeD if compare fails
	movb	$67, %al				# pass the ASCII value of capital 'C' into al
	movl	%eax, %esi
	movl	$.printGrade, %edi
	movl	$0, %eax
	call	printf

	jmp		.endIf
.ifGradeD:
	cmpl	$69, -20(%rbp)
	jg		.ifGradeF				# jump to ifGradeF if compare fails
	cmpl	$59, -20(%rbp)
	jle		.ifGradeF				# jump to ifGradeF if compare fails
	movb	$68, %al				# pass the ASCII value of capital 'D' into al
	movl	%eax, %esi
	movl	$.printGrade, %edi
	movl	$0, %eax
	call	printf

	jmp		.endIf
.ifGradeF:
	cmpl	$59, -20(%rbp)			# only compare value to 59 because anything lower than a 59 is an F
	jg		.elseInvalid			# jump to elseInvalid if compare fails
	movb	$70, %al				# pass the ASCII value of capital 'F' into al
	movl	%eax, %esi
	movl	$.printGrade, %edi
	movl	$0, %eax
	call	printf

	jmp		.endCalcGrade
.elseInvalid:
	movl	$.printIfInvalid, %edi	# there is only one argument to print so use puts instead of printf
	call	puts					# call puts 
	jmp		.endCalcGrade
.endIf:
.endCalcGrade:
	leave
	ret
