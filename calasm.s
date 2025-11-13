
.global _main
.align 2
.text

_main:
    mov W0, #5
    add W0, W0, #4


    // Convert all the values in the W0 register to strings 
    add W0, W0, #'0'

    strb W0, [sp, #-1]!


    // Print out a value stored on the stack 
    mov X0, #1
    mov X1, sp
    mov X2, #1
    mov X16, #4
    svc #0x80

_print_newline:
    mov X0, #1
    adr X1, newline
    mov X2, #1
    mov X16, #4
    svc #0x80

_exit:
    mov X0, #0
    mov X16, #1
    svc #0x80

 newline: 
    .ascii "\n"

