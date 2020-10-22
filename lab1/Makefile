CC = clang
CFLAGS = -Wall -pedantic -march=native -funroll-loops
# LDFLAGS = -fsanitize=address

SRC_MY_64 := my_memcpy.S test_my_memcpy.c
SRC_MY_32 := my_memcpy_32.S test_my_memcpy.c
SRC_LIB := test_memcpy.c

test_my_memcpy_64: $(SRC_MY_64)
	$(CC) $(CFLAGS) -m64 -g -o exec/$@ $^

test_my_memcpy_32: $(SRC_MY_32)
	$(CC) $(CFLAGS) -m32 -g -o exec/$@ $^

test_memcpy_64: $(SRC_LIB)
	$(CC) $(CFLAGS) -m64 -o exec/$@ $^
	objdump -j .text -d exec/$@ > exec/$@.d

test_memcpy_32: $(SRC_LIB)
	$(CC) $(CFLAGS) -m32 -o exec/$@ $^

#clean:
#	@rm -rf $(OBJ) $(EXEC)