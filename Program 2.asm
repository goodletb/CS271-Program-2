TITLE calculate Fibonacci numbers     (Program02.asm)

; Author: Brad Goodlett
; Course/project IDDate: Program 2
; Description: Calculates Fibonacci Numbers between 1 and 46

INCLUDE Irvine32.inc


	;constants
	maxValue				dword		46


.data
	spaces					byte		"     ", 0
	intro_1					byte		"Hi, My name is Brad Goodlett", 0
	intro_2					byte		"This program is called calculate Fibonacci numbers, and calculates",
										"the Nth Fibonacci number up to 46", 0
	intro_3					byte		"Please enter your name: ", 0
	intro_4					byte		"Hello, ", 0
	intro_4_2 				byte		"! please insert a number between 1 and 46: ", 0
	tooBig					byte		"The number you entered is too big, please enter a number smaller than 46",0
	userName				byte		21 DUP(0)
	validateInput			byte		"Calculating Fibonacci numbers up to N = ", 0
	partingMessage 			byte		"Goodbye, ", 0
	partingMessage2			byte		"!", 0
	theNumber				dword		?

.code
main PROC

	;introduce myself and the program
	mov edx, offset intro_1
	call writeString
	call CrLf
	mov edx, offset intro_2
	call writeString
	call CrLf

	;has the user enter their name, stores it in the userName variable and greets them by name
	mov edx, offset intro_3			;"Please enter your name: "
	call writeString
	mov edx, offset userName
	mov ecx, 20					;take a name with 20 character max
	call readString
	call CrLf
	mov edx, offset intro_4			;"Hello, "
	call writeString
	mov edx, offset userName			;prints userName
	call writeString
	mov edx, offset intro_4_2		;"! please insert a number between 1 and 46: "
	call writeString

	;gets the user's input (already asked for it with intro_4_2)
	OVER_MAX:
	call readInt
	mov theNumber, eax
	
	mov eax, theNumber
	cmp eax, maxValue ;check the input value to make sure it's not larger than 46
	jle UNDER_MAX
	mov edx, offset tooBig
	call writeString
	call crlf
	jmp OVER_MAX
	
	
	UNDER_MAX: ;jump here if the input is <= 46
	
	;calculate the fibonacci number theNumber times with a counted loop
	mov ecx, theNumber		;loop counter
	mov esi, 1			;previousNumber
	mov edi, 1			;currentNumber
	mov ebx, 0			;numbers per line
	mov edx, offset spaces	;spaces between numbers
	   ;eax				;adder
	sub ecx, 1			;remove 1 from theNumber to make the loop work properly
	START_LOOP:

	mov eax, edi			;move currentNumber to eax
	add eax, esi			;add eax and previousNumber
	mov esi, edi			;move currentNumber to previousNumber
	mov edi, eax			;move eax to currentNumber

	;check to see if there are 5 numbers in the line and go to a new line if there are else go to ELSE:
	inc ebx
	cmp ebx, 5
	jle ELSE_loop			;skip taking 5 from numbers per line and printing new line
	sub ebx, 5
	call CrLf
	ELSE_loop:
	;print the number and padding
	call writeDec			;currentNumber is still in eax
	call writeString		;padding is the only string being used here

	;return to the beginning of the loop and decrement loop counter
	loop START_LOOP

	;goodbye message
	call CrLf
	mov edx, offset partingMessage
	call writeString
	mov edx, offset userName
	call writeString
	mov edx, offset partingMessage2
	call writeString
	call CrLf

	exit; exit to operating system
main ENDP

	;<insert additional procedures here>

END main
