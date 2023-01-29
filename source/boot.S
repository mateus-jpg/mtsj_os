.section ".text.boot"	// pezzo di nome da inserire nel linker

.global _start		// qua parte 

_start:
	// parte che controlla che l'ID del processore è 0 (main core), altrimenti attenti 
	mrs 	x1, mpidr_el1		//  inserisce nel registro r1 il valore del 
	and 	x1, x1, #3		//  logical and inserisce il valore in x1 = x1 and 3 [ob11] 
	cbz 	x1, 2f			//  controlla se il valore di x1 è 0 se si vai a 2

1:	//non siamo nel main core attendi
	wfe
	b	1b

2:	//siamo nel main core
	
	//impostiamo lo stack per farlo partire sotto il nostro codice 
	ldr		x1, =_start
	mov 	sp, x1
	
	// puliamo la sezione bss 
	ldr	x1, =__bss_start	// inizi del'indirizzo
	ldr	w2, =__bss_size
3: 
	cbz	w2, 4f			// esci  dal loop se zero 
	str	xzr, [x1], #8
	sub	w2, w2, #1
	cbnz	w2, 3b

4:	// vai nel runtime main in C
	bl	main
	// se il codice c ritorna manda in alt il main core  
	b	1b
