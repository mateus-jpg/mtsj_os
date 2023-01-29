.section .init
.global _start
_start:
	ldr r0,=0x20200000	; indirizzo del GPIO controller
	
	mov r1,#1		; inserisce 1 nel registro r1
	lsl r1,#18		; shift left di 18 bit il valore nel registro 1
				; r1 = 0x1 << 18 = 0b1000000000000000000
	str r1,[r0,#4]		; store del valore r1 all'indirizzo r0 contenutp in r0 + 4
				; -- indica il pin GPIO  16
				; -perchè r0 +4 ? [fa riferimento al manuale del processore] 
				; ci sono 24 bytes del controller GPIO 
				; i primi 4 sono per selezionare i primi 10 
				; i secondi 4 per selezionare gli altri 10 e così vioa 
	 
