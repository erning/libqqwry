CC=gcc
CFLAGS=-O -Wall -Wpointer-arith -Wno-unused-parameter -Wunused-function -Wunused-variable -Wunused-value -Werror
INCS=-I.
AR=ar
LIBS=

all:qqwry_query 

qqwry.o: qqwry.c qqwry.h
	$(CC) -c -o $@ $< $(CFLAGS) $(INCS)

libqqwry.a: qqwry.o
	ar rcs $@ $<

qqwry_query: qqwry_query.c libqqwry.a
	$(CC) -o $@ $^ $(CFLAGS) $(INCS) $(LIBS) -L. -lqqwry

.PHONY: clean

clean:
	rm -f *.o *.a
