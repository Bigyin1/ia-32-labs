
.global _rep_movs
_rep_movs:
    movq %rdx, %rcx
    shrq $3, %rcx
    rep movsq
    ret
