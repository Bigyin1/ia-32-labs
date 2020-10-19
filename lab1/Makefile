CC = clang
CFLAGS = -Wall -pedantic -march=native -funroll-loops
# LDFLAGS = -fsanitize=address

SRC_MY := my_memcpy.S test_my_memcpy.c
SRC_LIB := test_memcpy.c

test_my_memcpy_64: $(SRC_MY)
	$(CC) $(CFLAGS) -O2 -m64 -S my_memcpy.c -o S/my_memcpy.S
	$(CC) $(CFLAGS) -O2 -m64 -g -o exec/$@ $^

test_my_memcpy_32: $(SRC_MY)
	$(CC) $(CFLAGS) -O2 -m32 -o exec/$@ $^

test_memcpy_64: $(SRC_LIB)
	$(CC) $(CFLAGS) -m64 -o exec/$@ $^
	objdump -j .text -d exec/$@ > exec/$@.d

test_memcpy_32: $(SRC_LIB)
	$(CC) $(CFLAGS) -m32 -o exec/$@ $^

#clean:
#	@rm -rf $(OBJ) $(EXEC)