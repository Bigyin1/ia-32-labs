.intel_syntax

.globl	my_memcpy
my_memcpy:
    push rbx
    mov rax, rdi

    cmp rdx, 128
    jl .mul_16

# align destination pointer to 32 boundary
.dest_align_32:
    mov rcx, rdi
    and rcx, 32 - 1
    jz .mul_128

    xor rcx, 32 - 1
    add rcx, 1
    sub rdx, rcx

.aloop:
    mov bl, [rsi]
    mov [rdi], bl

    add rsi, 1
    add rdi, 1
    sub rcx, 1
    jnz .aloop


.mul_128:
    mov rcx, rdx
    and rcx, -128
    jz .mul_16

    sub rdx, rcx
    shr rcx, 7

    cmp rcx, 1 << 18 # use non-temporal stores, when size >= 32MiB
    jl .loop_128_light

.loop_128_heavy:
    vmovups ymm0, [rsi]
    vmovups ymm1, [rsi+32]
    vmovups ymm2, [rsi+64]
    vmovups ymm3, [rsi+96]

    vmovntdq [rdi], ymm0
    vmovntdq [rdi+32], ymm1
    vmovntdq [rdi+64], ymm2
    vmovntdq [rdi+96], ymm3


    add rsi, 128
    add rdi, 128
    sub rcx, 1
    jnz .loop_128_heavy

    jmp .mul_16

.loop_128_light:
    vmovups ymm0, [rsi]
    vmovups ymm1, [rsi+32]
    vmovups ymm2, [rsi+64]
    vmovups ymm3, [rsi+96]

    vmovaps [rdi], ymm0
    vmovaps [rdi+32], ymm1
    vmovaps [rdi+64], ymm2
    vmovaps [rdi+96], ymm3


    add rsi, 128
    add rdi, 128
    sub rcx, 1
    jnz .loop_128_light

.mul_16:
    mov rcx, rdx
    and rcx, -16
    jz .mul_4

    sub rdx, rcx
    shr rcx, 4

.loop_16:
    vmovups xmm0, [rsi]
    vmovups [rdi], xmm0

    add rsi, 16
    add rdi, 16
    sub rcx, 1
    jnz .loop_16

.mul_4:
    mov rcx, rdx
    and rcx, -4
    jz .mul_1

    sub rdx, rcx
    shr rcx, 2
.loop_4:
    mov ebx, [rsi]
    mov [rdi], ebx

    add rsi, 4
    add rdi, 4
    sub rcx, 1
    jnz .loop_4

.mul_1:
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
