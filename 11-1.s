# sumNine2.s
# Sums nine integer arguments and returns the total.
# Bob Plantz - 13 June 2009

# Stack frame
# arguments already in stack frame
.equ seven,16
.equ eight,24
.equ nine,32
# local variables
.equ total,-4
.equ localSize,-16
# Read only data
.section .rodata
doneMsg:
.string "sumNine done"
# Code
.text
.globl sumNine
.type sumNine, @function
sumNine:
pushq %rbp # save caller’s base pointer
movq %rsp, %rbp # set our base pointer
addq $localSize, %rsp # for local variables

addl %esi, %edi # add two to one
addl %ecx, %edi # plus three
addl %edx, %edi # plus four
addl %r8d, %edi # plus five
addl %r9d, %edi # plus six
addl seven(%rbp), %edi # plus seven
addl eight(%rbp), %edi # plus eight
addl nine(%rbp), %edi # plus nine
movl %edi, total(%rbp) # save total

movl $doneMsg, %edi
call puts

movl total(%rbp), %eax # return total;
movq %rbp, %rsp # delete local vars.
popq %rbp # restore caller’s base pointer
ret
