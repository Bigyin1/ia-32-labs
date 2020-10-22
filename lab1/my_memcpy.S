.intel_syntax

.globl	my_memcpy
my_memcpy:
    push rbx
    mov rax, rdi

.pow_128:
    mov [rsp-8], rdx
    and qword ptr [rsp-8], -128
    jz .pow_16 // power of 16

    sub rdx, [rsp-8]
    mov rcx, qword ptr [rsp-8]
    shr rcx, 7

.loop_128:
    vmovups ymm0, [rsi]
    vmovups ymm1, [rsi+32]
    vmovups ymm2, [rsi+64]
    vmovups ymm3, [rsi+96]
    vmovups [rdi], ymm0
    vmovups [rdi+32], ymm1
    vmovups [rdi+64], ymm2
    vmovups [rdi+96], ymm3

    add rsi, 128
    add rdi, 128
    sub rcx, 1
    jnz .loop_128

.pow_16:
    mov [rsp-8], rdx
    and qword ptr [rsp-8], -16
    jz .pow_4 // power of 16

    sub rdx, [rsp-8]
    mov rcx, qword ptr [rsp-8]
    shr rcx, 4

.loop_16:
    vmovups xmm0, [rsi]
    vmovups [rdi], xmm0

    add rsi, 16
    add rdi, 16
    sub rcx, 1
    jnz .loop_16


.pow_4:
    mov [rsp-8], rdx
    and qword ptr [rsp-8], -4
    jz .pow_1

    sub rdx, [rsp-8]
    mov rcx, qword ptr [rsp-8]
    shr rcx, 2
.loop_4:
    mov ebx, [rsi]
    mov [rdi], ebx

    add rsi, 4
    add rdi, 4
    sub rcx, 1
    jnz .loop_4

.pow_1:
    cmp rdx, 0
    je .end
.loop_1:
    mov bl, [rsi]
    mov [rdi], bl

    add rsi, 1
    add rdi, 1
    sub rdx, 1
    jnz .loop_1


.end:
    pop rbx
    ret
