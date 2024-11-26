extern printf
extern calc_isbn_checksum

section .data
  format_output: db `This ISBN code's checksum is: %d\n`, 0
  format_not_enough_args: db `Syntax: isbnsum <isbn>\n`, 0
  format_wrong_format: db `Wrong format!\n`, 0

section .text
  global main

main:
  ; Start per convention
	push ebp
	mov ebp, esp

	; Load argc
	mov eax, [ebp + 8]

	; Check if an argument was passed -> 2 == one arg
	cmp eax, 2
	jne handle_wrong_args_amount ; Wrong amount of args -> Output error

	mov eax, [ebp + 12] ; Load argv into EAX
	mov eax, [eax + 4] ; Get passed argument

	; Pass argument to `calc_isbn_checksum` and call it
	push eax
	call calc_isbn_checksum

	; Check result of EAX - -1: Error
	cmp eax, -1
	je handle_wrong_format

	add esp, 4 ; Remove EAX from stack

	; Pass arguments to `printf` and call it
	push eax
	push format_output
	call printf

	add esp, 8 ; Remove EAX and `format_output` from stack

	mov eax, 0 ; Return 0

	main_exit:
	  leave
		ret

; Error: Wrong amount of args
handle_wrong_args_amount:
	push format_not_enough_args
	call printf

	add esp, 4 ; Remove `format_not_enough_args` from stack

	mov eax, -1 ; Return -1
	jmp main_exit

; Error: Wrong format
handle_wrong_format:
	push format_wrong_format
	call printf

	add esp, 4 ; Remove `format_wrong_format` from stack

	mov eax, -1 ; Return -1
	jmp main_exit
