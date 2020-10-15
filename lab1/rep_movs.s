
.global rep_movs
rep_movs:
    movq %rdx, %rcx
    shrq $3, %rcx
    rep movsq
    ret
