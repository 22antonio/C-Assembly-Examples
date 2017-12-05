; lab9.asm
; COMP B13
; author: Antonio Medel
; my solution was to create a while loop to prompt the user until the counter reaches 10

section .rodata
	prompt1    db "Please enter a number: ",0   ; 0 is null character
	prompt2    db "Enter another number: ",0
	format_str db "The sum is: %ld.",10,0  ; 10 is LF 
	num_format db "%ld",0

section .text
	global main              ; main and _start are both valid entry points
	extern printf, scanf     ; these will be linked in from glibc 

main:
	; prologue
	push    rbp          ; save base pointer to the stack
	mov     rbp, rsp     ; base pointer = stack pointer 
	sub     rsp, 80      ; make room for integers on the stack
	pushfq               ; push register flags onto the stack

	mov rax, [rbp - 8]
	xor eax, eax

	mov eax, 0			; place int 0 into eax
	mov [rbp - 16], eax ; the counter
	mov [rbp - 12], eax ; the sum of the numbers
	mov [rbp - 20], eax ; user input
	mov rbx, [rbp - 16]	; move the integer in counter into rbx
	jmp endWhile

while:
	; prompt for first integer 
	mov    rdi, dword prompt1    ; double word is 4 bytes; a word is 2 bytes
	mov rax, 0              	 ; rax is return value register - zero it out
	call   printf                ; call the C function from glibc 

	lea    rsi, [rbp - 20]       ; load effective address - this instruction
	mov    rdi, dword num_format ; load rdi with address to format string
	mov rax, 0              	 ; zero out return value register
	call   scanf                 ; call C function
                                 ; scanf reads the input as an integer

	mov	rax, [rbp - 20]			 ; moving user input into sum 
	add [rbp - 12], rax			 ; add to sum
	add rbx, 1					 ; incrementing counter

endWhile:
	cmp rbx, 9					 ; comparing counter to int 9
	jle while

	mov rsi, [rbp - 12]
	mov rdi, dword format_str
	mov rax, 0           		; rax is return value register - zero it out
	call printf           		; call the C function from glibc 
	je exit

exit:
      ; epilogue
      popfq
      add     rsp, 80       	; set back the stack level
      leave
      ret