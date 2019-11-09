/******************************************************************************
* file: PA5_PART2_ASCII_to_binary.s
* author: Badrinath
* Guide: Prof. Madhumutyam IITM, PACE
***********************************************************************/

@ BSS section
      .bss

@ DATA SECTION
	.data
NUM_entries:	.word   2
start1:		.asciz "11010010"
start2:		.asciz "1101710"

.align 1
OUTPUT :	.byte 0x0, 0x0, 0x0, 0x0
.align 1
ERROR :	        .byte 0x00,0x00,0x00,0x00


@ TEXT section
		.text
.globl _main

_main:

	// Loop for the length, note it is already given that the 
	mov r0,  #0x0
	mov r1,  #0x0
	mov r2,  #0x0
	mov r3,  #0x0
	mov r4,  #0x0
	mov r5,  #0x0
	mov r6,  #0x0 
	mov r7,  #0x0 
        mov r8,  #0x0
        mov r9,  #0x0
	mov r10, #0x0


	//
	// Core algorithum:
	// if  number is 0-9 substract "0" or ox30 (decimal 48)
	// If the number is a - f then substract another 0x11 
	// i.e., (decimal 7 ie, 'A'-0
	//

	mov r10, #2 // Num words

	// Read a byte till NULL
	ldr r0,  = start1
	ldr  r1, = OUTPUT
	ldr  r2, = ERROR 


numset_loop:
	
	#bit counter
	mov r6, #0
	#shift 
	mov r7, #31

	# Error code
	mov r4, #0

	#store for num formed
	mov  r5, #0

	cmp r10, #0
	beq all_done

	// Load a byte, convert to digit
	// and store in the register

num_loop:	
	ldrb r3, [r0], #1

	// check for NULL character
	cmp r3, #0 
	beq num_done

	#subract "0"
	sub r3, #'0'
	cmp r3, #1

	// Some digit is not 0 or 1 but higher
	// Error code is set and converted output is 0
	movgt r4, #0xFF
	movgt r5, #0
	bgt num_done

	lsl  r3, r3, r7
	orr r5,r5,r3
	// shift counter, decrement by 1 for next bit
	sub r7, r7, #1
	b num_loop

num_done:
	mov r5, r5, LSR #24
	strb r5, [r1], #1
	strb r4, [r2], #1

	sub r10, r10, #1
	b  numset_loop
all_done:
	// Self loop to inspect any registers
	b .

.end
