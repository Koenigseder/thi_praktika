;---------------------------------------------------------------
; Lab2_solution.asm
;
; Author: Kevin Koenigseder, Raphael Bauer
;
;
; This program calculates the n first Fibonacci numbers.
;
;
; Expected output:
; Output first n Fibonacci numbers (Starting with 0)
; ---------------------------------------------------------------

extern printf ; Using the C function for output - the object file needs to be linked with a C library

section .data
  decformat: db `%u\n`, 0 ; Define the (unsigned) decimal format for use with C's `printf` function 

  n: dd 20 ; How many loop iterations

section .text ; Code segment starts here
  global main

; Main function
main:
  ; Start per convention
  push ebp
  mov ebp, esp

  ; Set inital values
  mov eax, 0
  mov ebx, 1

  ; Define ECX (Needed for loop)
  mov ecx, [n]

; Calculate the dot product of two vectors
calc_fibonacci:
  ; NOTE: Since `printf` modifies e.g. EAX, ECX, EDX, we need to cache our values in some way -> We use the Stack for that

  ; Push our used registers to the stack, with the decformat (EAX must be the last one in order to be output by `printf`)
  push ecx
  push ebx
  push eax
  push decformat

  call printf ; Output current Fibonacci number

  add esp, 4 ; Remove `decformat` from Stack

  ; Directly swap values of EAX and EBX by popping the values from the Stack in reversed order
  pop ebx ; Store old value of EAX into EBX
  pop eax ; Store old value of EBX into EAX

  pop ecx ; Restore ECX

  add eax, ebx ; Calculate next Fibonacci number

  loop calc_fibonacci

  mov eax, 0 ; return 0

  ; Exit the program per convention
  leave
  ret

