/******************************************************************************
* file: bcd_to_hex_cs18m527.s
* author: Badrinath
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

  @ BSS section
      .bss

  @ DATA SECTION
.data
INPUT: .word 92529679
OUTPUT: .word 0xdeadbeef

@ TEXT section
      .text

.globl _main


_main:
	// Clear the registers

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


	// Load the input
	ldr r0, =INPUT
	ldr r1, [r0]

	mov r2, #1
	#mov r3, #10 
	mov r3, #0x10 

	//---------------------------------------------------------------------------------
	// Algorithim:- 
	// Take each nibble, multiply with its decimal place value
	// decimal place value and add 
	// ... nibble3*0x10^3 + nibble2*0x0^2 + nibble1*0x10^1 + nibble0*0x10^0
	//---------------------------------------------------------------------------------
nibble_loop:

	movs r7, r1
	beq  num_done
	and  r4, r1, #0x0F
	
	//------------------------------------------------- 
	// r4 contains the nibble
	// multipily with r3 which contains the decimal 
	// place value
	//-------------------------------------------------

	mul r5, r4, r2
	add r6, r6, r5

	mul r2, r2, r3
	// Increment the index so that next 
 	// Get the next nibble
	mov r1, r1, LSR#4
	b nibble_loop

num_done:
	# r6 should contain the hex required
	ldr r0, = OUTPUT
	str r6, [r0] 
	b .

.end	
