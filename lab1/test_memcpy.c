#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include "my_memcpy.h"

#define TEST_ITERS 100

void tester(size_t sz) {
    void *src = malloc(sz); 
    void *dst_my = malloc(sz);
    void *dst_lib = malloc(sz);
    if (!src || !dst_lib || !dst_my) exit(1);

    printf("testing on 0x%zx bytes\n", sz);
    clock_t mean = 0;
    for (size_t i = 0; i < TEST_ITERS; ++i)
    {
        clock_t t;
        t = clock();
        my_memcpy(dst_my, src, sz);
        mean += clock() - t;
    }
    mean /= TEST_ITERS;
    printf("\tmy memcpy: %f seconds\n", (double)mean/CLOCKS_PER_SEC);

    mean = 0;
    for (size_t i = 0; i < TEST_ITERS; ++i)
    {
        clock_t t;
        t = clock();
        memcpy(dst_my, src, sz);
        mean += clock() - t;
    }
    mean /= TEST_ITERS;
    printf("\tlibc memcpy: %f seconds\n", (double)mean/CLOCKS_PER_SEC);
    printf("test done\n");
    free(src);
    free(dst_my);
    free(dst_lib);
}

int main() {

    size_t tests[4] = {16, 700, 1 << 14, 1 << 24};

    for (size_t i = 0; i < sizeof(tests); i++)
    {
        tester(tests[i]);
    }
    
    return 0;
}
