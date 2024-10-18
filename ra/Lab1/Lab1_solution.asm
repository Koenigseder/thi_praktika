;---------------------------------------------------------------
; Lab1_solution.asm
;
; Author: KMK
;
;
; This program first calculates a product of two integers and outputs it as HEX,
; and after on calculates the dot product of two vectors x & y.
;
;
; Expected output:
; 2a
; 1
; ---------------------------------------------------------------

extern printf ; Using the C function for output - the object file needs to be linked with a C library

section .data
  decformat: db `%d\n`, 0 ; Define the decimal format for use with C's `printf` function
  hexformat: db `%x\n`, 0 ; ... and the HEX format

  a: dd 21
  b: dd 2

  x:         dd 17, 11, 4 ; Vector x
  y:         dd 4, -9, 8  ; Vector y

section .text ; Code segment starts here
  global main

; Main function
main:
  ; Start per convention
  push ebp
  mov ebp, esp

  ; ------------------------------------
  ; FIRST EXERCISE
  ; ------------------------------------

  mov eax, [a] ; Assign value of `a` to EAX
  mov ebx, [b] ; Assign value of `b` to EBX

  imul eax, ebx ; Multiply values of EAX and EBX and store result in EAX

  push eax       ; Push to stack
  push hexformat ; Push to stack

  call printf ; Call C's `printf` function

  add esp, 8 ; Move pointer (Remove from stack)

  mov eax, 0 ; Return 0 by convention
  mov ebx, 0

  ; ------------------------------------
  ; SECOND EXERCISE
  ; ------------------------------------

  ; Define ECX (Needed for loop)
  mov ecx, 3 ; 3 loop iterations

; Calculate the dot product of two vectors
calc_dot_prod:
  mov edx, [x + (ecx - 1) * 4]  ; Load element from vector x and save it to EDX
  imul edx, [y + (ecx - 1) * 4] ; Multiply element from vector y with value of EDX and save it to EDX
  add eax, edx                  ; Add the result of EDX to EAX

  loop calc_dot_prod ; Jump back (loop)

  ; Print the result
  push eax       ; Push to stack
  push decformat ; Push to stack

  call printf ; Call C's `printf` function

  add esp, 8 ; Move pointer (Remove from stack)

  mov eax, 0 ; Return 0 by convention
  mov edx, 0

  ; Exit the program per convention
  leave
  ret
