CC=gcc
NASM=nasm
NASMFLAGS+=-felf64

all: string_correct

string_correct: main.o process_string.o
	$(CC) main.o process_string.o

process_string.o: process_string.nasm
	$(NASM) $(NASMFLAGS) process_string.nasm

main.o: main.c
	$(CC) -c main.c

clean:
	rm -rf *.o 
