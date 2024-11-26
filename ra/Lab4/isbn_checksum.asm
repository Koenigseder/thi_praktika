section .data
  total_running: dd 0
  total_digits: dd 0
  total_dashes: dd 0

section .text
	global calc_isbn_checksum

calc_isbn_checksum:
	push ebp
	mov ebp, esp

	; Address of currently processed ISBN
	mov ebx, [esp + 8]

	; ECX stores the current mulitplication weight
	mov ecx, 3

	; Clean EAX
	mov eax, 0

	; Iterate over the ISBN number
	iterate_isbn:
	  ; AL stores the currently processed char / digit
		mov al, [ebx]

		; Check for string termination
		cmp al, 0
		je iterate_isbn_exit

		; Check for '-'
		cmp al, '-'
		je handle_dash

		; Remove bias from ASCII ('0' has ASCII code 48)
		sub al, 48

		; Check for "Not a number"
		cmp al, 0
		jl handle_nan

		cmp al, 9
		jg handle_nan

		; NOTE - At this point we have the real ISBN digit stored in AL

		xor ecx, 2 ; Alternate between 1 and 3

		; Calculate next element for `total_running` and add it
		mul ecx

		add dword [total_running], eax

		add ebx, 1 ; Next char in ISBN

		add dword [total_digits], 1 ; Increment `total_digits` by 1

		jmp iterate_isbn

	iterate_isbn_exit:
	  ; Check for correct amount of dashes (3)
  	cmp dword [total_dashes], 3
  	jne handle_wrong_amount_of_dashes

    ; Check for correct amount of digits (12)
  	cmp dword [total_digits], 12
  	jne handle_wrong_amount_of_digits

    ; Calculate final checksum

    ; Calculate remainder
  	mov ax, [total_running]
    mov dl, 10

    div dl

    ; Check if AH is already 0 -> Nothing more to do
    cmp ah, 0
    je checksum_already_zero

    ; Calculate final checksum
    mov ebx, 10
    movzx edx, ah

    sub ebx, edx ; EBX = EBX - EDX

    mov eax, ebx ; Return final result

    jmp calc_isbn_checksum_exit

  checksum_already_zero:
    mov eax, 0

  ; Exit this procedure
	calc_isbn_checksum_exit:
  	leave
  	ret

	; Handle '-'
	handle_dash:
		add dword [total_dashes], 1
		add ebx, 1 ; Next char in ISBN

		jmp iterate_isbn

	; Error: Not a number
	handle_nan:
		mov eax, -1
		jmp calc_isbn_checksum_exit

	; Error: Wrong amount of dashes
	handle_wrong_amount_of_dashes:
		mov eax, -1
		jmp calc_isbn_checksum_exit

	; Error: Wrong amount of digits
	handle_wrong_amount_of_digits:
		mov eax, -1
		jmp calc_isbn_checksum_exit
