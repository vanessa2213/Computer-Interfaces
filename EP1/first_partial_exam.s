###############################################################################
# First partial exam
# Interrupts & exceptions
# 08/Sep/2020
# Name: Perla Vanessa Jaime Gaytán
# Student ID: A00344428
###############################################################################

###############################################################################
# .eqv declaration
###############################################################################
eqv: # Your eqv declatarions go here (if needed)
	.eqv SYSCALL_PRINT_STRING  4
	.eqv SYSCALL_PRINT_HEXA    34
	.eqv SYSCALL_PRINT_CHAR    11
	
	.eqv RECEIVER_CONTROL_REG  0xffff0000
	.eqv MASK_ENABLE_INTERRUPT 0x00000002	
	.eqv INVALID_ADDRESS	    0x10010001
	.eqv MASK4EXCPCODE	    0x0000007c
	.eqv MASK4BIT8INTE	    0x00000100
	.eqv NUM		    0x7FFFFFFF
	.eqv NUM2	            9
	
	.eqv CAP_A		    0X00000041
	.eqv CAP_B		    0X00000042
	.eqv CAP_C		    0X00000043
	.eqv CAP_D		    0X00000044
	.eqv CAP_E		    0X00000045
	.eqv CAP_F		    0X00000046
	.eqv CAP_G		    0X00000047
	.eqv CAP_H		    0X00000048
	.eqv CAP_I		    0X00000049
	.eqv CAP_J		    0X0000004A
	.eqv CAP_K		    0X0000004B
	.eqv CAP_L		    0X0000004C
	.eqv CAP_M		    0X0000004D
	.eqv CAP_N		    0X0000004E
	.eqv CAP_Ñ		    0X000000D1
	.eqv CAP_O		    0X0000004F
	.eqv CAP_P		    0X00000050
	.eqv CAP_Q		    0X00000051
	.eqv CAP_R		    0X00000052
	.eqv CAP_S		    0X00000053
	.eqv CAP_T		    0X00000054
	.eqv CAP_U		    0X00000055
	.eqv CAP_V		    0X00000056
	.eqv CAP_W		    0X00000057
	.eqv CAP_X		    0X00000058
	.eqv CAP_Y		    0X00000059
	.eqv CAP_Z		    0X0000005A
	
	.eqv LOW_A		    0X00000061
	.eqv LOW_B		    0X00000062
	.eqv LOW_C		    0X00000063
	.eqv LOW_D		    0X00000064
	.eqv LOW_E		    0X00000065
	.eqv LOW_F		    0X00000066
	.eqv LOW_G		    0x00000067
	.eqv LOW_H		    0X00000068
	.eqv LOW_I		    0X00000069
	.eqv LOW_J		    0X0000006A
	.eqv LOW_K		    0X0000006B
	.eqv LOW_L		    0X0000006C
	.eqv LOW_M		    0X0000006D
	.eqv LOW_N		    0X0000006E
	.eqv LOW_Ñ		    0X000000F1
	.eqv LOW_O		    0X0000006F
	.eqv LOW_P		    0X00000070
	.eqv LOW_Q		    0X00000071
	.eqv LOW_R		    0X00000072
	.eqv LOW_S		    0X00000073
	.eqv LOW_T		    0X00000074
	.eqv LOW_U		    0X00000075
	.eqv LOW_V		    0X00000076
	.eqv LOW_W		    0X00000077
	.eqv LOW_X		    0X00000078
	.eqv LOW_Y		    0X00000079
	.eqv LOW_Z		    0X0000007A
##############################################################################
# Macros declaration
###############################################################################

macros: # Your macro declarations go here (if needed)
	
	.macro print_string (%string)
	 .ktext
	  la   $a0, %string         			    # load sttring to print
      	  li   $v0, SYSCALL_PRINT_STRING         	    # specify Print String service
      	  syscall
	 .end_macro
	 .macro printstring (%string)
	 .text
	  la   $a0, %string         			    # load sttring to print
      	  li   $v0, SYSCALL_PRINT_STRING         	    # specify Print String service
      	  syscall
	 .end_macro
	 .macro print_add ()
	 .ktext
	   mfc0 $a0, $14				   #move address in epc to print it 
      	   li   $v0, SYSCALL_PRINT_HEXA  	           #specify print hexa service
      	   syscall
	 .end_macro
	 .macro print_vadd ()
	 .ktext
	   mfc0 $a0, $8				   	   #move address in vaddr to print it 
      	   li   $v0, SYSCALL_PRINT_HEXA  	           #specify print hexa service
      	   syscall
	 .end_macro
	 .macro skip_add ()
	 .ktext
	   mfc0 $t1, $14				   #move from epc to register t1 
      	   addi $t1,$t1,4			           #skip the address by adding 4 in order to jump the address
      	   mtc0 $t1, $14				   #move to epc the next address to return 
      	   eret						   #return to address in epc
	 .end_macro
	 
	 .macro print_char (%char)
	 .ktext
	  la   $a0, %char         			    # load sttring to print
      	  li   $v0, SYSCALL_PRINT_CHAR        	    # specify Print String service
      	  syscall
      	  eret
	 .end_macro
	 
	 .macro print_anychar(%anychar)
	 .ktext
	    move $a0, %anychar
	    li    $v0, SYSCALL_PRINT_CHAR			
	    syscall 
      	    eret
	 .end_macro
 
.data
P1S:  .asciiz  "\n------->START OF PROBLEM 1\n"          
P1F:  .asciiz  "\n------->FINISH OF PROBLEM 1\n"	 
P2S:  .asciiz  "\n------->START OF PROBLEM 2\n"          
P2F:  .asciiz  "\n------->FINISH OF PROBLEM 2\n"	
P3S:  .asciiz  "\n------->START OF PROBLEM 3\n"          
P3F:  .asciiz  "\n------->FINISH OF PROBLEM 3\n"	
P4S:  .asciiz  "\n------->START OF PROBLEM 4\n"  
###############################################################################
# Text segment - User code
###############################################################################
    # DO NOT DELETE THE FOLLOWING LINE
		.text
###############################################################################
# Main program
# Execute each of the 4 exam problems
# When debugging your code, it may be useful to comment/uncomment problem calls
###############################################################################
main:
		jal problem1			#DONE
		jal problem2			#DONE
		jal problem3			#DONE
		jal problem4			#DONE
		# Finish execution - may not be used after correctly solving problem 4
		jal end_exam

###############################################################################
# Problem1: Resolve a breakpoint exception
###############################################################################
problem1:
    # TODO: Write your code for handling a breakpoint exception   DONE
		#       No need to modify this subroutine
    #       Your exception handler MUST be placed in the ktext segment
    # Cause a breakpoint exception
    		printstring (P1S)
		break
		printstring (P1F)
		# Return to main program
		jr $ra

###############################################################################
# Problem2: Generate and solve an overflow exception
###############################################################################
problem2:
    # TODO: Write your code below
		printstring (P2S)
		li $t1, NUM			#load number that could create an overflow
		add $t1,$t1,$t1			#add $t1+$t1 and save it there just to create an of
		printstring (P2F)
    # Return to main program
		jr $ra

###############################################################################
# Problem3: Generate and solve a bad address exception on load and store
# instructions
###############################################################################
problem3:
    # TODO: Write your code below
		printstring (P3S)
		li $t5, INVALID_ADDRESS 		#load one invalid address into reg to use it later
		lw $t2, 0($t5)			#trying to read from the invalid address
		li $t3, NUM2			#load one random number just to use it for store
		sw $t3, 0($t5)			#trying to store in the invalid address
		# Return to main program
		printstring (P3F)
		jr $ra

###############################################################################
# Problem4: Keyboard interrupts
###############################################################################
problem4:
    # TODO: Write your code below
				
    # Return to main program
    		printstring (P4S)
    		li 	$t1, MASK_ENABLE_INTERRUPT 		#set bit 1 to 1 to use it in the receiver control reg
    		li	$t2, RECEIVER_CONTROL_REG 		#load which address is going to write on it
    		sw      $t1,($t2)				#write bit 1 to 1 in order to enable interrupts
		infinite_loop:
			addi $t3,$t3,1
			j infinite_loop
		# NOTE: The following instruction shouldn't execute after this problem is
		#       correctly solved. Instead, this program should enter into an
		#       infinite loop
		jr $ra

###############################################################################
# END EXAM
# NOTE: This subroutine shouldn't excecute when program 4 is called (assumming
#       problem 4 is correctly completed)
###############################################################################
end_exam:
		li $v0, 10
		syscall

###############################################################################
# KERNEL DATA SEGMENT
###############################################################################
	.kdata
# Add code used in kernel data segment (if needed)
bp: 	.asciiz  "\n------->Breakpoint exception generated by instruction located at address "	
skip: 	.asciiz "\n------->Skipping offending instruction.\n"
of: 	.asciiz  "\n------->Overflow exception generated by instruction located at address "	
bal:    .asciiz  "\n------->Bad address on load exception. Trying to read address "	
bas:    .asciiz  "\n------->Bad address on store exception. Trying to write address "	
###############################################################################
# KERNEL DATA SEGMENT
# All interrupt/exception handlers should be placed in Kernel segment
###############################################################################
# NOTE: DO NOT MODIFY THE FOLLOWING LINE
	.ktext 0x80000180

kernel_segment: # This label isn't used in the code, it's just for debugging
		# TODO: Detect exception/interrupt source
		#       Place your exception/interrupt handler routines below
		#       It is recommended to use one handler per exception/interrupt source
		mfc0 $k0, $13			#get the value from cause register
		
		andi $k1, $k0, MASK4EXCPCODE		#mask it all but the exception code (bis 2-6) to zero
		
		srl  $k1, $k1, 2		#shift two bits to the right to get the exception code
		#Problem 4: Interrupt
		beqz $k1, interrupt
		#Problem 3: address error
		beq  $k1, 4, addL_handler		#if the exception is equal to 4 is a address load exception
		beq  $k1, 5, addS_handler		#if the exception is equal to 5 is a address store exception
		#Problem 1: Break point
		beq  $k1, 9, bp_handler		#if the exception is equal to 9 is a break point exception
		#Problem 2: Overflow
		beq  $k1, 12, of_handler 	#if the exception is equal to 9 is a overflow exception
		jr $ra
addr:	print_add()
	print_string (skip)
      	skip_add() 
vaddr: print_vadd()
       print_string (skip)
       skip_add() 
      			
bp_handler:	print_string(bp)
      	 	j addr 
of_handler:	print_string(of)
	   	j addr    

addL_handler:	print_string(bal)
		j vaddr
      		
addS_handler:	print_string(bas)
	  	j vaddr 
 
interrupt:
	  #$k0 = value of cause 
	  andi $k1, $k0, MASK4BIT8INTE	#mask all bits but 8 (interrupt pending)to zeros
	  srl  $k1, $k1, 8		#shift 8 bits to the right to get the pending interrupt
	  beq  $k1, 1, kb_inte_handler	#branch if the interrupt is due the keyboard
	  
kb_inte_handler:
		lw    $k1, 4($t2) 		#get which key was pressed address ffff0004 ($t2 + 4)
		#getting which key was pressed in order to print the right char
		#lower case letters 
		beq  $k1, LOW_A, printa
		beq  $k1, LOW_B, printb
		beq  $k1, LOW_C, printc
		beq  $k1, LOW_D, printd
		beq  $k1, LOW_E, printe
		beq  $k1, LOW_F, printf
		beq  $k1, LOW_G, printg
		beq  $k1, LOW_H, printh
		beq  $k1, LOW_I, printi
		beq  $k1, LOW_J, printj
		beq  $k1, LOW_K, printk
		beq  $k1, LOW_L, printl
		beq  $k1, LOW_M, printm
		beq  $k1, LOW_N, printn
		beq  $k1, LOW_Ñ, printñ
		beq  $k1, LOW_O, printo
		beq  $k1, LOW_P, printp
		beq  $k1, LOW_Q, printq
		beq  $k1, LOW_R, printr
		beq  $k1, LOW_S, prints
		beq  $k1, LOW_T, printt
		beq  $k1, LOW_U, printu
		beq  $k1, LOW_V, printv
		beq  $k1, LOW_W, printw
		beq  $k1, LOW_X, printx
		beq  $k1, LOW_Y, printy
		beq  $k1, LOW_Z, printz
		#upper case letters
		beq  $k1, CAP_A, printA
		beq  $k1, CAP_B, printB
		beq  $k1, CAP_C, printC
		beq  $k1, CAP_D, printD
		beq  $k1, CAP_E, printE
		beq  $k1, CAP_F, printF
		beq  $k1, CAP_G, printG
		beq  $k1, CAP_H, printH
		beq  $k1, CAP_I, printI
		beq  $k1, CAP_J, printJ
		beq  $k1, CAP_K, printK
		beq  $k1, CAP_L, printL
		beq  $k1, CAP_M, printM
		beq  $k1, CAP_N, printN
		beq  $k1, CAP_Ñ, printÑ
		beq  $k1, CAP_O, printO
		beq  $k1, CAP_P, printP
		beq  $k1, CAP_Q, printQ
		beq  $k1, CAP_R, printR
		beq  $k1, CAP_S, printS
		beq  $k1, CAP_T, printT
		beq  $k1, CAP_U, printU
		beq  $k1, CAP_V, printV
		beq  $k1, CAP_W, printW
		beq  $k1, CAP_X, printX
		beq  $k1, CAP_Y, printY
		beq  $k1, CAP_Z, printZ
		#any other char pressed 
		print_anychar($k1)
		eret
printa: print_char(CAP_A)
printb: print_char(CAP_B)
printc: print_char(CAP_C)
printd: print_char(CAP_D)	
printe: print_char(CAP_E)	
printf: print_char(CAP_F)
printg: print_char(CAP_G)
printh: print_char(CAP_H)	
printi: print_char(CAP_I)
printj: print_char(CAP_J)
printk: print_char(CAP_K)
printl: print_char(CAP_L)
printm: print_char(CAP_M)
printn: print_char(CAP_N)
printñ: print_char(CAP_Ñ)
printo: print_char(CAP_O)
printp: print_char(CAP_P)
printq: print_char(CAP_Q)
printr: print_char(CAP_R)
prints: print_char(CAP_S)
printt: print_char(CAP_T)
printu: print_char(CAP_U)
printv: print_char(CAP_V)
printw: print_char(CAP_W)	
printx: print_char(CAP_X)	
printy: print_char(CAP_Y)
printz: print_char(CAP_Z)

printA: print_char(LOW_A) 
printB: print_char(LOW_B) 
printC: print_char(LOW_C) 
printD: print_char(LOW_D) 
printE: print_char(LOW_E) 
printF: print_char(LOW_F) 
printG: print_char(LOW_G) 
printH: print_char(LOW_H) 
printI: print_char(LOW_I) 
printJ: print_char(LOW_J) 
printK: print_char(LOW_K) 
printL: print_char(LOW_L) 
printM: print_char(LOW_M) 
printN: print_char(LOW_N) 
printÑ: print_char(LOW_Ñ) 
printO: print_char(LOW_O) 
printP: print_char(LOW_P) 
printQ: print_char(LOW_Q) 
printR: print_char(LOW_R) 
printS: print_char(LOW_S) 
printT: print_char(LOW_T) 
printU: print_char(LOW_U) 
printV: print_char(LOW_V) 
printW: print_char(LOW_W) 
printX: print_char(LOW_X) 
printY: print_char(LOW_Y)
printZ: print_char(LOW_Z)
	
