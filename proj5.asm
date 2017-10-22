	
	.486
	.model flat
	.stack 100h
	ExitProcess PROTO stdcall, dwExitCode:dword
	intasc32 PROTO stdcall, lpStringToHoldAnswer:dword, dVal:dword
	putstring PROTO stdcall, lpStringToPrint:dword
	getstring	proto stdcall, lpSTringToHold:dword, dNumChars:dword
	ascint PROTO stdcall, lpStringToConvert:dword
	intasc PROTO stdcall, lpStringToStore:dword, val:dword
	hexToChar PROTO stdcall, chr:byte
	hexToString PROTO stdcall, lpStringToStoreChars:dword, lpStringOfHexBytes:dword, num:dword
	inputString PROTO stdcall, lpStringToStore:dword, num:dword
	
	.data
	strIn			byte	15 dup (?) ; Note number and strIn have values that validate
										;the methods actually work
	testNum			dword	-1 ; separates number and strIn more noticably in debugger
	number			dword	?						
	
	;Unimportant data
	num				dword	15
	CRLF			byte	10,13,0
	strPrompt 		byte	"Enter something to be redisplayed, 14 chars max: ",0
	strPromptTwo	byte	"Enter a number to convert to ascii and back!: ",0
	strPromptThree	byte	"Number after ascint and intasc: ",0
	strPromptFour	byte	"HexToChar Method: ",0
	strRedisplay	byte	"Redisplayed: ",0
	strHexOne		byte	"HexToString with a 0 for last parameter: ",0
	strHexTwo		byte	"HexToString with a dword for last parameter: ",0
	;end unimportant data
	
	aByte			byte	4Ch
	bunchBytes		dword	6A5B4C3Dh
	strHex			byte	1Ah,2Bh,3Ch,4Dh,5Eh,6Fh,70h,81h,92h,0Ah,99h
	
	
	.code
_start:	
	mov eax, 0
	
	; This is inputString
	INVOKE putstring, ADDR strPrompt
	INVOKE inputString, ADDR strIn, num
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR strRedisplay
	INVOKE putstring, ADDR strIn
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	; end inputString
	
	;This is ascint in conjunction with inputString
	INVOKE putstring, ADDR strPromptTwo
	INVOKE inputstring, ADDR strIn, num ; inputString
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	INVOKE ascint, ADDR strIn			;ascint
	mov number, eax						
	; # in eax reg and 'number'
		
	; The following is intasc then displayed
	INVOKE putstring, ADDR strPromptThree
	INVOKE intasc, ADDR strIn, number
	INVOKE putstring, ADDR strIn ; display
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	;end block
	
	mov edx, 0 ; zero out number
	mov number, edx
	
	;Hex to char method
	INVOKE hexToChar, aByte
	cwde
	mov number, eax ; first two bytes have ascii chars
	mov [strIn], al
	mov [strIn+1], ah
	mov [strIn+2], dl ; null terminate
	INVOKE putstring, ADDR strPromptFour
	INVOKE putstring, ADDR strIn ; display
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	;end hexToChar
	
	;Hex to string with 0 as last param
	INVOKE hexToString, ADDR strIn, bunchBytes, 0
	INVOKE putstring, ADDR strHexOne
	INVOKE putstring, ADDR strIn
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	;end block
	
	;hex to string with a dword for last param
	INVOKE hexToString, ADDR strIn, ADDR strHex, 7
	INVOKE putstring, ADDR strHexTwo
	INVOKE putstring, ADDR strIn
	INVOKE putstring, ADDR CRLF
	INVOKE putstring, ADDR CRLF
	;end block
		
	INVOKE	ExitProcess, 0
	PUBLIC	_start
	END
	