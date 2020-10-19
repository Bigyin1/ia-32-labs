#include <stdlib.h>
#include <stdint.h>

extern void rep_movsg(void *restrict dst, const void *restrict src, size_t n);

void *my_memcpy(void *restrict dst, const void *restrict src, size_t n) {

    void *s_dst = dst;
//    (void)n;
//    (void)src;
    for (size_t i = 0; i < n / sizeof(uint64_t); ++i)
    {
        *(uint64_t*)dst = *(uint64_t*)src;
        dst = (uint64_t*)dst + 1;
        src = (uint64_t*)src + 1;
    }
//    asm("movq %rdx, %rcx");
//    asm("shrq $3, %rcx");
//    asm("rep movsq");
   // rep_movsg(dst, src, n);

    for (size_t i = 0; i < n % sizeof(uint64_t); ++i) {
        *(char *) dst = *(char *) src;
        dst = (char *) dst + 1;
        src = (char *) src + 1;
    }

    return s_dst;
}
