#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>
#include "my_memcpy.h"

#define TEST_ITERS 100

void tester(size_t sz) {
    void *src_my = malloc(sz);
    void *dst_my = malloc(sz);
    void *src_lib = malloc(sz);
    void *dst_lib = malloc(sz);
    if (!src_my || !src_lib || !dst_lib || !dst_my) exit(1);

    printf("testing on 0x%zx bytes\n", sz);
    clock_t mean = clock();
    for (size_t i = 0; i < TEST_ITERS; ++i) {
        my_memcpy(dst_my, src_my, sz);
    }
    printf("\tmy memcpy:\t\t%.10f clocks\n", (double)(clock() - mean) / TEST_ITERS);

    mean = clock();
    for (size_t i = 0; i < TEST_ITERS; ++i) {
        memcpy(dst_lib, src_lib, sz);
    }
    printf("\tlibc memcpy:\t%.10f clocks\n", (double)(clock() - mean) / TEST_ITERS);
    printf("test done\n");
    free(src_lib);
    free(src_my);
    free(dst_my);
    free(dst_lib);
}

int main() {

    size_t tests[4] = {1 << 24};

    for (size_t i = 0; i < 1; i++) {
        tester(tests[i]);
    }

//    void *src = malloc(tests[3]);
//    void *dst_my = malloc(tests[3]);
//
//    my_memcpy(dst_my)

    return 0;
}
