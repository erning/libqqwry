CC=gcc
CFLAGS=-I.
AR=ar
LIBS=

all:qqwry_query 

qqwry.o: qqwry.c qqwry.h
	$(CC) -c -o $@ $< $(CFLAGS)

libqqwry.a: qqwry.o
	ar rcs $@ $<

qqwry_query: qqwry_query.c libqqwry.a
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS) -L. -lqqwry

.PHONY: clean

clean:
	rm -f *.o *.a
