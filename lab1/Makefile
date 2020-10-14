CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -march=native -funroll-loops -O2 -fsanitize=address
# LDFLAGS = -fsanitize=address
LDFLAGS = -fsanitize=address

SRC := memcpy.c test_memcpy.c
OBJ = $(SRC:.c=.o)
EXEC = mem_test

all : $(EXEC)
$(EXEC): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $(OBJ)

.o:.c
	$(CC) $(CFLAGS) -c $<

clean:
	@rm -rf $(OBJ) $(EXEC)