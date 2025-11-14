.global _main
.align 2
.text

_main:
    mov     w0, #12
    add     w0, w0, #7
    bl      _int_to_string

_print_value:
    mov     x0, #1
    mov     x2, x19
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
    mov     x19, #0
    mov     x2, #10
    sub     sp, sp, #64

 _convert_loop:
    udiv    w4, w0, w2
    msub    w5, w4, w2, w0
    add     w5, w5, #'0'
    strb    w5, [sp, x19]
    add     x19, x19, #1
    mov     w0, w4
    cbnz    w0, _convert_loop

    mov     x4, #0
    sub     x18, x19, #1

 _copy:
    ldrb    w5, [sp, x18]
    strb    w5, [x1, x4]
    add     x4, x4, #1
    sub     x18, x18, #1
    cmp     x4, x19
    b.lt    _copy

    add     sp, sp, #64
    ret

 newline:
    .ascii  "\n"

