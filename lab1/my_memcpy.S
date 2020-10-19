.intel_syntax

.globl	my_memcpy
my_memcpy:
    mov rax, rdi



.start_0:
    cmp rdx, 256
    mov rcx, rdx
    jg .start
    rep movsb
    jmp .end


.start:
    mov [rsp-8], rdx
    and qword ptr [rsp-8], 64 - 1
    jz .sz_64 // power of 64

    sub rdx, [rsp-8]
    mov rcx, qword ptr [rsp-8]
    rep movsb

.sz_64:
    shr rdx, 6
    cmp rdx, 0
    jz .end
.loop_64:
    prefetchnta 32[rsi]
    prefetchnta 64[rsi]


    vmovups ymm0, [rsi]
    vmovups [rdi], ymm0
    vmovups ymm0, 32[rsi]
    vmovups 32[rdi], ymm0

    add rsi, 64
    add rdi, 64
    dec rdx
    jnz .loop_64

.end:
    #add rsp, 8
    ret

