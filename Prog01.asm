TITLE Simple Math     (Prog01.asm)

; Author: Christine Bruton
; Last Modified: 6/30/2019
; OSU email address: brutonc@oregonstate.edu
; Course number/section: CS 271 400 Su
; Assignment Number: 1               Due Date: 7/7/2019
; Description: 
; 1.) Displays the programmer's name and program title on the output screen. 
; 2.) Displays instructions for the user. 
; 3.) Prompts the user to enter two numbers. 
; 4.) Calculates the sum, difference, product, (integer) quotient and remainder of the numbers.
; 5.) Displays a terminating message.

INCLUDE Irvine32.inc

.data
userName	BYTE	33 DUP(0)	;string to be entered by use
firstNum	DWORD	?			;first integer to be entered by user
secondNum	DWORD	?			;second integer to be entered by user
sum			DWORD	0			;variable to hold the sum
difference	DWORD	0			;variable to hold the difference
product		DWORD	0			;variable to hold the product
quotient	DWORD	0			;variable to hold the quotient
remainder	DWORD	0			;variable to hold the remainder
choiceInt	DWORD	?			;variable to hold the user's choice to continue or not
intro_1		BYTE	"Welcome to 'Simple Math' a program by Christine Bruton.", 0
intro_2		BYTE	"Enter 2 numbers, and the program will display the difference, poduct, quotient, and remainder.", 0
prompt_1	BYTE	"Enter the first number: ", 0
prompt_2	BYTE	"Enter the second number: ", 0
prompt_3	BYTE	"Press '1' to Continue or '2' to Quit", 0
EC1			BYTE	"**EC 1: Repeat until the user chooses to quit.", 0
EC2			BYTE	"**EC 2: Program validates that second number is less than the first.", 0
badInput	BYTE	"The first number must be greater than the second- start over please!", 0
plusSign	BYTE	" + ", 0	
minusSign	BYTE	" - ", 0
multSign	BYTE	" x ", 0
divSign		BYTE	" / ", 0
remWord		BYTE	" remainder ", 0
equalSign	BYTE	" = ", 0
goodBye		BYTE	"That's it, Good-bye! ", 0
.code
main PROC

prog:							;main program sequence
;Introduction
;Introduce programmer
	call	CrLf
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf
;Explain how to use program
	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf
;Get the data
;Get the first number
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov		firstNum, eax
;Get second number
	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov		secondNum, eax
; compare and move to invalid statement if firstNum < secondNum
	mov		ebx, secondNum
	cmp		ebx, firstNum
	jg		invalid
;calculate the required values
;calculate the sum
	mov		eax, firstNum
	add		eax, secondNum
	mov		sum, eax
;calculate the difference
	mov		eax, firstNum
	sub		eax, secondNum
	mov		difference, eax
;calculate the product
	mov		eax, firstNum
	imul	eax, secondNum
	mov		product, eax
;calculate the quotient and remainder
	mov		edx, 0
	mov		eax, secondNum
	mov		eax, firstNum
	mov		ebx, secondNum
	div		ebx
	mov		quotient, eax
	mov		remainder, edx
;calculate the required values
;display sum
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET plusSign
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	CrLf
;display difference
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET minusSign
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, difference
	call	WriteDec
	call	CrLf
;display product
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET multSign
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, product
	call	WriteDec
	call	CrLf
;display quotient
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET divSign
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equalSign
	call	WriteString
	mov		eax, quotient
	call	WriteDec
	mov		edx, OFFSET remWord
	call	WriteString
	mov		eax, remainder
	call	WriteDec
	call	CrLf
	jmp		quitChoice
quitChoice:						; Ask if user wants to quit
	mov		edx, OFFSET EC1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET prompt_3
	call	WriteString
	call	CrLf
	call	ReadInt				;get the continue choice from the user
	mov		choiceInt, eax			
	mov		ebx, 1
	cmp		ebx, choiceInt
	je		prog
	jmp		gBye
invalid:						;tell the user what they have to do to complete the program
	call	CrLf
	mov		edx, OFFSET	EC2
	call	WriteString
	mov		edx, OFFSET badInput
	call	CrLf
	call	WriteString
	call	CrLf
	jmp		prog
;;Say "Good-bye"
gBye:							
	call	CrLf
	mov		edx, OFFSET goodBye
	call	WriteString
	call	CrLf
	exit						; exit to operating system
main ENDP

END main
