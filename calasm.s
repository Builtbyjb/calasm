.global _main
.align 2
.text

_main:
    cmp     x0, #4 // Check is the argc is equal to 4
    b.ne   _invalid_argument

    ldr     x2, [x1, #8] // First command line argument
    ldr     x3, [x1, #16] // Second command line argument
    ldr     x4, [x1, #24] // third command line argument

    ldr     w0, [x2]
    ldr     w1, [x4]

    cmp     x3, #'+'
    b.eq    _add

    cmp     x3, #'*'
    b.eq    _mul

    cmp     x3, #'-'
    b.eq    _sub

    cmp     x3, #'/'
    b.eq    _div

_add:
    add     w0, w0, w1
    b       _int_to_string

_sub:
    sub     w0, w0, w1
    b       _print_value

_div:
    cmp     w1, #0
    b.eq    _invalid_argument
    udiv     w0, w0, w1
    b       _int_to_string

_mul:
    mul     w0, w0, w1
    b       _int_to_string

_invalid_argument:
    adr     x1, error_msg
    mov     x19, #50

_print_value:
    mov     x0, #1
    mov     x2, x19 // Output length
    mov     x16, #4
    svc     #0x0

_print_newline:
    mov     x0, #1
    adr     x1, newline
    mov     x2, #1
    mov     x16, #4
    svc     #0x0

_exit:
    mov     x0, #0
    mov     x16, #1
    svc     #0x0

 _int_to_string:
    mov     x19, #0 // character count
    mov     w2, #10 // divisor
    sub     sp, sp, #64 // Allocate memory on the stack

 _convert_loop:
    udiv    w4, w0, w2
    msub    w5, w4, w2, w0 // Get reminder
    add     w5, w5, #'0' // Convert int to char
    strb    w5, [sp, x19]
    add     x19, x19, #1
    mov     w0, w4
    cbnz    w0, _convert_loop

    mov     x4, #0
    sub     x18, x19, #1

 _copy:
    ldrb    w5, [sp, x18] // Loads a character from the stack at index x18
    strb    w5, [x1, x4]
    add     x4, x4, #1
    sub     x18, x18, #1
    cmp     x4, x19
    b.lt    _copy

    add     sp, sp, #64
    ret

 newline:
    .ascii  "\n"

error_msg:
    .ascii "Invalid Arguments: Example usage <progam> 8 + 7"
