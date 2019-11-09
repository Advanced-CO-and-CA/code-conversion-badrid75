/******************************************************************************
* file: PA5_PART1_Ascii_to_hex.s
* author: Badrinath
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
  This is the starter code for assignment 2
  */

  @ BSS section
      .bss

  @ DATA SECTION
.data
A_DIGIT:  .word 0x43
H_DIGIT:  .word 0x0

@ TEXT section
      .text

.globl _main


_main:


	mov r0, #0x0
	mov r1, #0x0
	mov r2, #0x0
	mov r3, #0x0
	mov r4, #0x0
	mov r5, #0x0
	mov r6, #0x0 
	mov r7, #0x0 
        mov r8, #0x0

	//
	// ASCII      Hex
	//    0       0x30
	//    9       0x39

	//  7 special char (hex 0x3A to 0x40
	//    A        	0x41 
	//


	ldr r0, =A_DIGIT
	ldr r1, = H_DIGIT
	ldr r2, [r0]


	#check if the ASCII value is <= 0x39. If so, directly substract 30
        # ie if 0x30, then hex = 30-30, 1 = 31-30..
        # range 0x3A to 0x40 - skip (those are for special char)
	# for range 0x41 to 0x46, substract 37


	cmp r2, #0x39
	blt  SUB30

	#check if is in the special character range,
	cmp r2, #0x40
	blt END
	sub r2, r2, #7

SUB30:
	sub r2, r2, #0x30
	str r2, [r1]
END:
	
	b .
.end
