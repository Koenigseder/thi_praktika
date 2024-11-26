# Lab 4

This program calculates ISBN-13 checksums. E.g.

```sh
./Lab4.out 978-3-8458-3851
```

Build binary:
```sh
nasm -f elf32 -g Lab4.asm && nasm -f elf32 -g isbn_checksum.asm && gcc Lab4.o isbn_checksum.o -o Lab4.out
```
