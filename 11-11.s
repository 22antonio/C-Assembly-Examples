# nineInts2.s
# Demonstrate how integral arguments are passed in 64-bit mode.
# Bob Plantz - 13 June 2009

# Stack frame
# passing arguments on stack (rsp)
# need 3x8 = 24 -> 32 bytes
.equ seventh,0
.equ eighth,8
.equ ninth,16
# local vars (rbp)
# need 10x4 = 40 -> 48 bytes
.equ i,-4
.equ h,-8
.equ g,-12
.equ f,-16
.equ e,-20
.equ d,-24
.equ c,-28
.equ b,-32
.equ a,-36
.equ total,-40
.equ localSize,-80
# Read only data
.section .rodata
format:
.string "The sum is %i\n"
# Code
.text
.globl main
.type main, @function
main:
pushq %rbp # save caller’s base pointer
movq %rsp, %rbp # establish ours
addq $localSize, %rsp # space for local variables
# + argument passing
movl $1, a(%rbp) # initialize local variables
movl $2, b(%rbp) # etc...
movl $3, c(%rbp)
movl $4, d(%rbp)
movl $5, e(%rbp)
movl $6, f(%rbp)
movl $7, g(%rbp)
movl $8, h(%rbp)
movl $9, i(%rbp)

movl f(%rbp), %edx # load f
movl e(%rbp), %ecx # ....
movl d(%rbp), %esi
movl c(%rbp), %edi
movl b(%rbp), %r10d
movl a(%rbp), %r11d # load a

movl i(%rbp), %eax # load i
movl %eax, ninth(%rsp) # 9th argument
movl h(%rbp), %eax # load h
movl %eax, eighth(%rsp) # 8th argument
movl g(%rbp), %eax # load g
movl %eax, seventh(%rsp) # 7th argument
movl %edx, %r9d # f is 6th
movl %ecx, %r8d # e is 5th
movl %esi, %ecx # d is 4th
movl %edi, %edx # c is 3rd
movl %r10d, %esi # b is 2nd
movl %r11d, %edi # a is 1st
call sumNine
movl %eax, total(%rbp) # total = nineInts(...)

movl total(%rbp), %esi
movl $format, %edi
movl $0, %eax
call printf

movl $0, %eax # return 0;
movq %rbp, %rsp # delete locals
popq %rbp # restore caller’s base pointer
ret 