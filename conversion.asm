;************************************************************************************
; program:	 	conversion.asm														
; programmer: 	Eric Blumenstock
; date created: 4/19/2013
; date last modified: 4/26
; class: 		CSCI2160
; purpose:  	To create methods to convert from strings to integers, vice versa,
;				and other utility-based methods.
;************************************************************************************

	.486
	.model flat
	.stack 100h
	ExitProcess		PROTO near32 stdcall, dExitCode:DWORD
	hexToChar PROTO stdcall, chr:byte ; used in hexToString
	extern getchar:near32
	extern getcharecho:near32
	extern putchar:near32
	
	.code
	
	; Method Name:      ascint
	; Method Purpose:   convert from ascii to integer
	;
	; Date created:         4/19/2013
	; Date last modified:   4/27/2013
	;
	; Parameters:
	;	lpStringToConvert:dword		string to convert to an int
	ascint proc stdcall uses ebx ecx edx esi, lpStringToConvert:dword
		local numIsNeg:byte
		
		mov ebx, lpStringToConvert
		
		mov eax, 0   
		mov numIsNeg, al ; zero out local
		mov ecx, 20h ; holds a space " "
		mov esi, 0	 ; for indexing
		mov edx, 2Bh ; "+"
		
		.if ( byte ptr [ebx] == al ) ; is first byte 0?
			or eax, 0	; clear overflow flag
			stc 		;set carry flag
			jmp done	; and if the first byte is 0 we're done
		
		.elseif( byte ptr [ebx] == cl ) ; is first byte a space?
			.while ( byte ptr [ebx+esi] == cl)
				add esi, 1	; next byte
			.endw
		.endif
		
		mov eax, 2Dh ; "-"
		
		.if ( byte ptr [ebx+esi] == al ) ; is byte a "-"?
			mov eax, 1
			add numIsNeg, al ; boolean for number is negative
			add esi, 1 ; next byte
		
		.elseif ( byte ptr [ebx+esi] == dl ) ; is byte a "+"?
			add esi, 1 ; next byte			
			
		.endif
		
		mov eax, 0 ; clear out counter
		
		.while ( byte ptr [ebx+esi] != 0 ) ; while not the null char
		
			.if ( byte ptr [ebx+esi] == 30h ) ; if byte is 0
				imul eax, 10
				
			.elseif ( byte ptr [ebx+esi] == 31h ) ; if byte is 1
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 1
				
			.elseif ( byte ptr [ebx+esi] == 32h ) ; if byte is 2
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 2
				
			.elseif ( byte ptr [ebx+esi] == 33h ) ; if byte is 3
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 3
				
			.elseif ( byte ptr [ebx+esi] == 34h ) ; if byte is 4
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 4
				
			.elseif ( byte ptr [ebx+esi] == 35h ) ; if byte is 5
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 5
				
			.elseif ( byte ptr [ebx+esi] == 36h ) ; if byte is 6
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 6
				
			.elseif ( byte ptr [ebx+esi] == 37h ) ; if byte is 7
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 7
				
			.elseif ( byte ptr [ebx+esi] == 38h ) ; if byte is 8
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 8
				
			.elseif ( byte ptr [ebx+esi] == 39h ) ; if byte is 9
				imul eax, 10
				.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
					; .if ( numIsNeg == 0)
						mov eax, 0
						jmp done
					; .endif
				.endif
				add eax, 9
								
			.else	; else its an invalid character
				stc ; set carry flag
				mov eax, 0
				jmp done
				
			.endif
			
					;This block is for NEGATIVE NUMBERS
			; .if ( numIsNeg == 1 ) ; if numNeg is true
				; neg eax ; make eax negative
				; .if ( eax == -2147483648 )
					; mov edx, -1 ; set sign flag with OR so it doesn't clear it
					; or edx, 0 ; clear OF flag, since it may of been set before negative
				; .endif
				; mov edx, 0
				; mov numIsNeg, dl
			; .endif	
			
						
			.if ( OVERFLOW? ) ;&& numIsNeg == 0) ;if overflow set return 0
				; .if ( numIsNeg == 0)
				.if (eax != 80000000h ) 
					mov eax, 0
					jmp done
				.endif
				.if (numIsNeg == 0)
					mov eax, 0
					jmp done
				.endif
				;.endif
			.endif
			
			add esi, 1
		.endw
				;This block is for NEGATIVE NUMBERS
				
				; mov edx, 2Dh
				; .if ([ebx+0] == dl || [ebx+1] == dl)
					; .if ( eax == -2147483648 )
						; mov edx, -1 ; set sign flag with OR so it doesn't clear it
						; or edx, 0 ; clear OF flag, since it may of been set before negative						
					; .endif
				; .endif
							
		.if ( numIsNeg == 1 ) ; if numNeg is true
			neg eax ; make eax negative
			.if ( eax == -2147483648 )
				mov edx, -1 ; set sign flag with OR so it doesn't clear it
				or edx, 0 ; clear OF flag, since it may of been set before negative
										
			.endif
		.endif		
		; .if ( eax < -3333333333 ) ; for the case of the neg number being ridiculously large
			; mov edi, 2147483647
			; add edi, 2 ; sets OF flag
		; .endif
				;END BLOCK FOR NEG NUBMERS
		
		.if ( OVERFLOW? ) ;if overflow set return 0
				mov eax, 0
				jmp done
		.endif
		clc ; clear carry unless it was a specific case
	done:
		.if ( OVERFLOW? )
			clc ; clear carry if there is an overflow
		.endif
		ret
	ascint endp
	

	
	; Method Name:      intasc
	; Method Purpose:   convert from integer to ascii
	;
	; Date created:         4/19/2013
	; Date last modified:   4/27/2013
	;
	; Parameters:
	;	lpStringToStore:dword		string to store integer in
	;	val:dword					value to convert to ascii
	intasc proc stdcall uses eax ebx ecx edx esi edi, lpStringToStore:dword, val:dword
		local number:sdword, reverse[32]:byte, valS:sdword
		
		mov esi, 0 ; clear out indexer
		mov ebx, lpStringToStore ; register addressing
		mov edi, 0 ; clear out indexer
		
		;if val is postive
		mov eax, 10
		mov number, eax
		
		mov eax, val
		mov valS, eax
		
		.if ( valS < 0 )
			; mov eax, -10
			; mov number, eax
			mov byte ptr [ebx], 2Dh ; put a '-' in first location
			; add esi, 1 ; increment esi
			add edi, 1
		.endif
		
		mov eax, val ; quotient in eax
		.if ( valS < 0 )
			neg eax
		.endif
		lea ebx, reverse
		mov esi, 0 ; zero indexer again
		
		.while ( eax != 0 )
		mov edx, 0 ; remainder in edx
		idiv number ; 'number' will always be 10 or -10
		
		.if (edx == 0 )
			mov byte ptr [ebx+esi], 30h			
		
		.elseif (edx == 1 || edx == -1 )
			mov byte ptr [ebx+esi], 31h	
			
		.elseif (edx == 2 || edx == -2  )
			mov byte ptr [ebx+esi], 32h	
		
		.elseif (edx == 3 || edx == -3 )
			mov byte ptr [ebx+esi], 33h	
			
		.elseif (edx == 4 || edx == -4 )
			mov byte ptr [ebx+esi], 34h	
			
		.elseif (edx == 5 || edx == -5 )
			mov byte ptr [ebx+esi], 35h	
			
		.elseif (edx == 6 || edx == -6 )
			mov byte ptr [ebx+esi], 36h	
			
		.elseif (edx == 7 || edx == -7 )
			mov byte ptr [ebx+esi], 37h	
				
		.elseif (edx == 8 || edx == -8 )
			mov byte ptr [ebx+esi], 38h	
		
		.elseif (edx == 9 || edx == -9 )
			mov byte ptr [ebx+esi], 39h	
		
		.endif
		
		add esi, 1 ; increment indexer
		.endw

		mov ecx, lpStringToStore
		
		.if (eax == 0 && esi == 0) ; if val was 0 then put a zero in
			mov byte ptr [ecx+edi], 30h
			add edi, 1
		.endif
		
		.while (esi > 0) ; this while statement fixes the string being in reverse
		sub esi, 1
		mov al, byte ptr [ebx+esi]
		mov byte ptr [ecx+edi], al
		add edi, 1
		.endw
		
		mov byte ptr [ecx+edi], 0 ; null terminate string
		
		ret
	intasc endp
		
	
	; Method Name:      inputString
	; Method Purpose:   accepts string input
	;
	; Date created:         4/19/2013
	; Date last modified:   4/27/2013
	;
	; Parameters:
	;	lpStringToStore:dword		string to store input into
	;	num:dword					number of characters
	inputString proc stdcall uses eax ebx ecx edx esi edi, lpStringToStore:dword, num:dword
		local number:dword, aByte:dword
		
		mov ecx, 0
		mov ebx, lpStringToStore
		mov edx, 0
		mov edi, 0
		mov esi, num
		sub esi, 1
		
		.while ( aByte != 0Dh) ; enter key ;ecx != edi ||
			call getchar
			add ecx, 1 ; since we added a char note ecx obsolete use edi
			.if ( al == 08h ) ; if a backspace
				sub ecx, 2 ; go back the "added" char and one more
				.if ( ecx == -1 )
					mov ecx, 0 ; we don't want ecx to be less than 0
				.endif
			.endif
			
			; .if ( edi < esi )
				; .if ( al != 08h && al != 0Dh)
					; mov byte ptr [ebx+ecx-1], al ; -1 for first ecx addition
				; .endif
				
				; .if ( al == 08h )
					; mov byte ptr [ebx+ecx], dl ; zero out that spot then since we backspaced
				; .endif
			; .endif
			
			; .if ( ecx == 0 && al == 08h && edi > 0 )
				; cbw
				; cwde
				; mov aByte, eax
				; push aByte
				; call putchar
				; add esp, 4
			; .endif

			.if ( edi >= esi && al != 08h && al != 0Dh)
				; do nothing, at end of # of chars
			.elseif ( al != 08h);|| ( edi == 0 && al != 08h)) ; this if puts out the char that was entered
				cbw
				cwde
				mov aByte, eax
				push aByte
				call putchar
				add esp, 4
				
				.if ( al != 08h && al != 0Dh)
					mov byte ptr [ebx+edi], al ; -1 for first ecx addition
				.endif
				
				add edi, 1		
			
			.elseif ( al == 08h && edi > 0);&& ecx != 0) ; this if is for a backspace go back "space" then back
				cbw
				cwde
				mov aByte, eax
				push aByte
				call putchar
				add esp, 4
				mov eax, 20h ; a space in eax
				push eax
				call putchar
				add esp, 4
				push aByte
				call putchar
				add esp, 4
				
				sub edi, 1
				
				.if ( aByte == 08h )
					mov byte ptr [ebx+edi], dl ; zero out that spot then since we backspaced
				.endif
			
			.endif
			
		.endw
		
		mov eax, 0
		mov byte ptr [ebx+edi-1], al
		
		; mov edi, num
		; sub edi, 1 ; we want to go one less than length of string because string starts at 0
		
		; mov eax, 0
		; mov byte ptr [ebx+edi], al
		
		ret
	inputString endp
	
	
	; Method Name:      hexToChar
	; Method Purpose:   convert from hex to a character
	;
	; Date created:         4/19/2013
	; Date last modified:   4/27/2013
	;
	; Parameters:
	;	chr:byte		byte to be converted to string of chars
	hexToChar proc stdcall uses ebx ecx edi, chr:byte
		
		mov ecx, 0
		mov eax, 0
		; mov ebx, 0
		; mov bl, chr
		
		; ror ebx, 4   ; roll to the right 4 bits so that high byte number is in ebx
		
		; .while ( ecx != 16 ) ; go through all possible cases 0-15
			; .if ( bl == cl ) ; if high byte is = to a # between 0 and 15 then put in ah
				; mov ah, bl
			; .endif
			
			; inc ecx
		; .endw
			
		mov ebx, 0 ; the following 4 lines prepare the byte for checking and replacing
		mov bl, chr ; next two lines separates the bytes by using ROL and ROR
		rol ebx, 4 ; roll left 4 bits so that high byte is in high byte register
		ror bl, 4 ; ; and low byte is in low byte register
		; mov ecx, 0 
		
		; .while ( ecx != 16 ) ; go through all possible cases 0-15
			; .if ( bl == cl ) ; if low byte (in the high byte register) is = to a # between 0 and 15
				; mov al, bl	; then put in low byte AL
			; .endif
			
			; inc ecx
		; .endw
		
		.if ( bl == 0 ); check and replace byte with Ascii
			mov bl, 30h
			
		.elseif ( bl == 1 )
			mov bl, 31h
		
		.elseif ( bl == 2 )
			mov bl, 32h
			
		.elseif ( bl == 3 )
			mov bl, 33h
		
		.elseif ( bl == 4 )
			mov bl, 34h
			
		.elseif ( bl == 5 )
			mov bl, 35h
		
		.elseif ( bl == 6 )
			mov bl, 36h
		
		.elseif ( bl == 7 )
			mov bl, 37h
		
		.elseif ( bl == 8 )
			mov bl, 38h
			
		.elseif ( bl == 9 )
			mov bl, 39h
			
		.elseif ( bl == 10 )
			mov bl, 41h
			
		.elseif ( bl == 11 )
			mov bl, 42h
			
		.elseif ( bl == 12 )
			mov bl, 43h
			
		.elseif ( bl == 13 )
			mov bl, 44h
			
		.elseif ( bl == 14 )
			mov bl, 45h
			
		.elseif ( bl == 15 )
			mov bl, 46h
			
		.endif
		
		
		
		.if ( bh == 0 ) ; check and replace byte with Ascii
			mov bh, 30h
			
		.elseif ( bh == 1 )
			mov bh, 31h
		
		.elseif ( bh == 2 )
			mov bh, 32h
			
		.elseif ( bh == 3 )
			mov bh, 33h
		
		.elseif ( bh == 4 )
			mov bh, 34h
			
		.elseif ( bh == 5 )
			mov bh, 35h
		
		.elseif ( bh == 6 )
			mov bh, 36h
		
		.elseif ( bh == 7 )
			mov bh, 37h
		
		.elseif ( bh == 8 )
			mov bh, 38h
			
		.elseif ( bh == 9 )
			mov bh, 39h
			
		.elseif ( bh == 10 )
			mov bh, 41h
			
		.elseif ( bh == 11 )
			mov bh, 42h
			
		.elseif ( bh == 12 )
			mov bh, 43h
			
		.elseif ( bh == 13 )
			mov bh, 44h
			
		.elseif ( bh == 14 )
			mov bh, 45h
			
		.elseif ( bh == 15 )
			mov bh, 46h
			
		.endif
				
		mov eax, 0
		mov ax, bx
		
		ret
	hexToChar endp
	
	
	; Method Name:      hexToString
	; Method Purpose:   convert hex to string of chars
	;
	; Date created:         4/19/2013
	; Date last modified:   4/27/2013
	;
	; Parameters:
	;	lpStringToStoreChars:dword		address of string to store hex characters
	;	lpStringOfHexBytes:dword		address of string to convert
	;	num:dword						number of bytes to convert if 0 convert above parameter itself
	hexToString proc stdcall uses eax ebx ecx edx esi edi, lpStringToStoreChars:dword, lpStringOfHexBytes:dword, num:dword
		local byteToSend:byte, number:dword
		
		mov ebx, lpStringOfHexBytes
		mov ecx, lpStringToStoreChars
		
		.if ( num == 0 ) ; then convert the dword in "lpStringOfHexBytes"
									
			mov byteToSend, bl
			INVOKE hexToChar, byteToSend ; first byte is in two bytes in AX
			mov [ecx+7], al
			mov [ecx+6], ah
		
			mov byteToSend, bh
			INVOKE hexToChar, byteToSend ; first byte is in two bytes in AX
			mov [ecx+5], al
			mov [ecx+4], ah
			
			ror ebx, 16 ; now high part of ebx is in bx
			
			mov byteToSend, bl
			INVOKE hexToChar, byteToSend ; first byte is in two bytes in AX
			mov [ecx+3], al
			mov [ecx+2], ah
		
			mov byteToSend, bh
			INVOKE hexToChar, byteToSend ; first byte is in two bytes in AX
			mov [ecx+1], al
			mov [ecx], ah
		
			mov eax, 0
			mov [ecx+8], eax ; null terminate string
		
		.elseif ( num != 0 )
		; string will be twice as long as 'num' + null
			
			mov eax, num
			mov edi, 2
			imul edi 
			mov edi, eax ; edi holds num * 2
			mov esi, 0
			; sub edi, 1 ; subtract right off since we'll do '[0]' too
			mov edx, 0
			mov number, edi ; number holds num * 2
			mov ecx, 0
			mov edi, lpStringToStoreChars
			
			.while ( number > edx ) ; while we still have more numbers to convert	
				;note that there will be two bytes for every 1 byte of hex digits 
				; ex 1A = 31h + 41h
				mov cl, byte ptr [ebx+esi] ; move a byte from hex string to cl
				add esi, 1 ; for next byte
				mov byteToSend, cl ; send to dword storage
				INVOKE hexToChar, byteToSend ; invoke method
				mov [edi+edx], ah ; move high order byte into string storage first
				add edx, 1 ; for next byte in string
				mov [edi+edx], al ; low order byte into string next
				add edx, 1; for next byte in string
			.endw
		
			mov eax, 0
			mov [edi+edx], eax ; null terminate
				
		.endif
						
		ret
	hexToString endp
	
	END
	