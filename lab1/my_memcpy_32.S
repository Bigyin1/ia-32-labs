.intel_syntax

.globl	my_memcpy
my_memcpy:
    mov edi, [esp + 4]
    mov esi, [esp + 8]
    mov edx, [esp + 12]

    push ebx
    mov eax, edi

    cmp edx, 128
    jl .pow_16

.dest_align_32:
    mov ecx, edi
    and ecx, 32 - 1
    jz .pow_128

    xor ecx, 32 - 1
    add ecx, 1
    sub edx, ecx

.aloop_1:
    mov bl, [esi]
    mov [edi], bl

    add esi, 1
    add edi, 1
    sub ecx, 1
    jnz .aloop_1


.pow_128:
    mov ecx, edx
    and ecx, -128
    jz .pow_16 // power of 16

    sub edx, ecx
    shr ecx, 7

.loop_128:
    vmovups ymm0, [esi]
    vmovups ymm1, [esi+32]
    vmovups ymm2, [esi+64]
    vmovups ymm3, [esi+96]
    vmovaps [edi], ymm0
    vmovaps [edi+32], ymm1
    vmovaps [edi+64], ymm2
    vmovaps [edi+96], ymm3

    add esi, 128
    add edi, 128
    sub ecx, 1
    jnz .loop_128

.pow_16:
    mov ecx, edx
    and ecx, -16
    jz .pow_4 // power of 16

    sub edx, ecx
    shr ecx, 4

.loop_16:
    vmovups xmm0, [esi]
    vmovups [edi], xmm0

    add esi, 16
    add edi, 16
    sub ecx, 1
    jnz .loop_16


.pow_4:
    mov ecx, edx
    and ecx, -4
    jz .pow_1

    sub edx, ecx
    shr ecx, 2
.loop_4:
    mov ebx, [esi]
    mov [edi], ebx

    add esi, 4
    add edi, 4
    sub ecx, 1
    jnz .loop_4

.pow_1:
    cmp edx, 0
    je .end
.loop_1:
    mov bl, [esi]
    mov [edi], bl

    add esi, 1
    add edi, 1
    sub edx, 1
    jnz .loop_1


.end:
    pop ebx
    ret
