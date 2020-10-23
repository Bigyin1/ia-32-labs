#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdio.h>

#define TEST_ITERS 1000

void tester(size_t sz) {
    void *src = malloc(sz);
    void *dst = malloc(sz);
    if (!src || !dst) exit(1);

    printf("testing on 0x%zx bytes\n", sz);
    clock_t mean = clock();
    for (size_t i = 0; i < TEST_ITERS; ++i) {
        memcpy(dst, src, sz);
    }
    printf("\tmemcpy:\t\t%f clocks\n", (double)(clock() - mean) / TEST_ITERS);
    free(src);
    free(dst);
}


int main() {


    size_t tests[4] = {16, 700, 1 << 14, 1 << 22};

    for (size_t i = 0; i < 4; i++) {
        tester(tests[i]);
    }

    return 0;
}

