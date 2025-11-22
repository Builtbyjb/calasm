# Exit a program
_exit:
    mov     x0, #0
    mov     x16, #1
    svc     #0x0
