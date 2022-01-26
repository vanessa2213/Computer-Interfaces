###############################################################################
# First partial exam
# Interrupts & exceptions
# 08/Sep/2020
# Name:		Luis Alfredo Aceves Astengo
# Student ID:	A01229441
###############################################################################

###############################################################################
# .eqv declaration
###############################################################################
eqv: # Your eqv declatarions go here (if needed)
		.eqv VADDR 	 $8				#coprocessor 0 aliases
		.eqv STATUS 	 $12
		.eqv CAUSE 	 $13
		.eqv EPC 	 $14
		
		.eqv EXC_CODE 	 $t0				#to copy exception code
		.eqv COMP_REG 	 $t1				#to compare exception code 
		.eqv EPC_COPY 	 $t2				#to copy the PC address that caused an exception
		.eqv BAD_COPY 	 $t3				#to copy bad address
		.eqv STATUS_COPY $t4				#to copy and write to status register
		.eqv CAUSE_COPY  $t5				#to copy and cause register
		
		.eqv OV_REG 	 $s0				#we will overflow this register
		.eqv LOAD_REG    $s1				#address to where we'll try to load a word
		.eqv STORE_REG 	 $s2				#address from where we'll try to store a word 
		.eqv LOOP_REG    $s3				#register to do something in loop
		
		.eqv UNEX_ADDR1  0x20000000			#unexistent address 1
		.eqv UNEX_ADDR2	 0x20000004			#unexistent address 2
		
		.eqv RxCR 	 0xFFFF0000			#receiver control register
		.eqv RxCR_COPY   $s4				#copy to write RxCR
		.eqv RxDR 	 0xFFFF0004			#receiver data register
		.eqv RxDR_COPY   $s5				#copy of RxDR
		.eqv AUX1 	 $s6				#auxiliary 1
		.eqv AUX2 	 $s7				#auxiliary 2
###############################################################################
# Macros declaration
###############################################################################
macros: # Your macro declarations go here (if needed)
		.macro print_offending_address(%reg)
      			move  $a0, %reg   			#write address in $a0 for printing service
      			li    $v0, 34            		#specify print integer as hexadecimal service
      			syscall                			#print address that caused exception
		.end_macro
		
		.macro print_skip_message
			la    $a0, skipmsg        		#load address of print heading
      			li    $v0, 4           			#specify print string service
      			syscall               			#print skiping
		.end_macro
		
		.macro return_and_skip
			addi  EPC_COPY, EPC_COPY, 0x4		#increase offending instruction by 4
      			jr    EPC_COPY				#return to program but skipping address that caused exception
		.end_macro
		
		.macro clear_exception_bit
			mfc0  STATUS_COPY, STATUS			#can't write status directly, so add immediate steps
			andi  STATUS_COPY, STATUS_COPY, 0xFFFFFFFD	#clear exception level bit
			mtc0  STATUS_COPY, STATUS			#write new value in coprocessor 0
		.end_macro
###############################################################################
# Text segment - User code
###############################################################################
    # DO NOT DELETE THE FOLLOWING LINE
		.text
		.data
skipmsg: 	.asciiz  "\nSkipping offending instruction\n"
      		.text 
		.data	
msgk: 		.asciiz  "\nIdle until keyboard interrupt:\n"
      		.text	
###############################################################################
# Main program
# Execute each of the 4 exam problems
# When debugging your code, it may be useful to comment/uncomment problem calls
###############################################################################
main:
		mfc0  STATUS_COPY, STATUS				#can't write status directly, so add immediate steps
		ori   STATUS_COPY, STATUS_COPY, 0x00000001		#enable interrupts bit
		mtc0  STATUS_COPY, STATUS				#write new value in coprocessor 0
		
		jal problem1
		jal problem2
		jal problem3
		jal problem4
		# Finish execution - may not be used after correctly solving problem 4
		jal end_exam

###############################################################################
# Problem1: Resolve a breakpoint exception
###############################################################################
problem1:
    # TODO: Write your code for handling a breakpoint exception
    # No need to modify this subroutine
    # Your exception handler MUST be placed in the ktext segment
    # Cause a breakpoint exception
		break
		# Return to main program
		jr $ra

###############################################################################
# Problem2: Generate and solve an overflow exception
###############################################################################
problem2:
    # TODO: Write your code below
		li   OV_REG, 0x7FFFFFFF			#maximum signed positive value
		addi OV_REG, OV_REG, 1			#add 1 and you'll get an overflow
    		# Return to main program
		jr $ra

###############################################################################
# Problem3: Generate and solve a bad address exception on load and store
# instructions
###############################################################################
problem3:
    # TODO: Write your code below
		lw LOAD_REG UNEX_ADDR1			#try to load from unexistent address
		#exception will be handled and return to next instruction
		li STORE_REG 0xFFFFFFFF			#precharge a value to later store in memory
		sw STORE_REG UNEX_ADDR2			#try to store in unexistent address
		# Return to main program
		jr $ra

###############################################################################
# Problem4: Keyboard interrupts
###############################################################################
problem4:
    # TODO: Write your code below
		lw  RxCR_COPY, RxCR			#to enable interrupts in RxCR
		ori RxCR_COPY, RxCR_COPY, 0x00000002			
		sw  RxCR_COPY, RxCR
		
		#enable keyboard interrupt (seems it is enabled by default)
		mfc0 STATUS_COPY, STATUS			#copy status register to enable interrupt source
		ori STATUS_COPY, STATUS_COPY, 0x00000100 	#keyboard interrupt mask
		mtc0 STATUS_COPY, STATUS
		
		la    $a0, msgk        			#load address of print heading
      		li    $v0, 4           			#specify print string service
      		syscall    				#print
      		
	loop:	addi LOOP_REG, LOOP_REG, 1
		jal  loop
    		# Return to main program
		# NOTE: The following instruction shouldn't execute after this problem is
		# correctly solved. Instead, this program should enter into an
		# infinite loop
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
	.data	
msg9: 	.asciiz  "\nBreakpoint exception generated by instruction located at address "
      	.text
      	
	.data	
msg12: 	.asciiz  "\nOverflow exception generated by instruction located at address "
      	.text	

	.data	
msg4: 	.asciiz  "\nBad address on load exception. Trying to read address "
      	.text	

	.data	
msg5: 	.asciiz  "\nBad address on store exception. Trying to write address "
      	.text	
###############################################################################
# KERNEL DATA SEGMENT
# All interrupt/exception handlers should be placed in Kernel segment
###############################################################################
# NOTE: DO NOT MODIFY THE FOLLOWING LINE
	.ktext 0x80000180
	
kernel_segment: # This label isn't used in the code, it's just for debugging
		# TODO: Detect exception/interrupt source
		# Place your exception/interrupt handler routines below
		# It is recommended to use one handler per exception/interrupt source
	
		mfc0  EXC_CODE, CAUSE			#copy cause register
		andi  EXC_CODE, EXC_CODE, 0x000000FC	#extract exception code (0xFC is the 6-bit mask that stores this)
		srl   EXC_CODE, EXC_CODE, 2		#shift right 2 to normalize value
		
		mfc0  EPC_COPY, EPC			#copy EPC register 
		
		subi  COMP_REG, EXC_CODE, 9		#check if exception 9 (breakpoint)
		beq   COMP_REG, $zero, excep9		#go to exception 9 handler if match

		subi  COMP_REG, EXC_CODE, 12		#check if exception 12 (arithmetic overflow)
		beq   COMP_REG, $zero, excep12		#go to exception 12 handler if match
		
		mfc0  BAD_COPY, VADDR			#next exceptions will print bad address register
		
		subi  COMP_REG, EXC_CODE, 4		#check if exception 4 (load address error)
		beq   COMP_REG, $zero, excep4		#go to exception 4 handler if match

		subi  COMP_REG, EXC_CODE, 5		#check if exception 5 (store address error)
		beq   COMP_REG, $zero, excep5		#go to exception 5 handler if match

		beq   EXC_CODE, $zero, int		#if exception code is 0, we have an interrupt

				
excep9:		la    $a0, msg9        			#load address of print heading
      		li    $v0, 4           			#specify print string service
      		syscall               			#print message for exception 9	
		print_offending_address(EPC_COPY)
		print_skip_message
		clear_exception_bit
		return_and_skip


excep12:	la    $a0, msg12        		#load address of print heading
      		li    $v0, 4           			#specify print string service
      		syscall               			#print message for exception 12	
		print_offending_address(EPC_COPY)
		print_skip_message
		clear_exception_bit
		return_and_skip


excep4:		la    $a0, msg4        			#load address of print heading
      		li    $v0, 4           			#specify print string service
      		syscall               			#print message for exception 4
		print_offending_address(BAD_COPY)
		print_skip_message
		clear_exception_bit
		return_and_skip


excep5:		la    $a0, msg5	        		#load address of print heading
      		li    $v0, 4           			#specify print string service
      		syscall               			#print message for exception 5
      		print_offending_address(BAD_COPY)
      		print_skip_message
		clear_exception_bit
		return_and_skip


		#this might seem a bit useless, but would be useful if we had more possible interruptions to check
int:		mfc0 CAUSE_COPY, CAUSE			#copy cause register to see interrupt source
		andi CAUSE_COPY, CAUSE_COPY, 0x00000100 #keyboard interrupt mask
		srl  CAUSE_COPY, CAUSE_COPY, 8		#normalize
		subi COMP_REG, CAUSE_COPY, 1		#I can reuse COMP_REG for this: check if CAUSE_COPY=1
		beq  COMP_REG, $zero, keyboard		#go to keyboard handler
		
		clear_exception_bit			#no keyboard int, so just clear and continue
		jr    EPC_COPY				#return to where we were


		#ASCII
		#A-Z: 65-90
		#a-z: 97-122
keyboard:	lw RxDR_COPY, RxDR			#copy RxDR					
		bgt RxDR_COPY, 64, gt64			#if greater than 64 branch, else print
			
print:		move $a0, RxDR_COPY			#move contents of RxDR_COPY to $a0
      		li   $v0, 11           			#print char service
      		syscall               			#print
		#clear keyboard interrupt bit
	        mfc0 CAUSE_COPY, CAUSE			#copy cause register to clear interrupt source
		andi CAUSE_COPY, CAUSE_COPY, 0xFFFFFEFF #keyboard interrupt mask
		mtc0 CAUSE_COPY, CAUSE			
      		clear_exception_bit
		jr    EPC_COPY				#return to where we were

gt64:		bgt RxDR_COPY, 122, print		#if greater than 122 don't change caps and print
		blt RxDR_COPY, 91, uppercase		#if less than 91, it is upper case
		bgt RxDR_COPY, 96, lowercase		#if greater than 96, it is lower case

uppercase:      addi RxDR_COPY, RxDR_COPY, 32		#add 32 in ASCII changes to make lowercase
		jal print

lowercase:      subi RxDR_COPY, RxDR_COPY, 32		#sub 32 in ASCII changes to make uppercase
		jal print
			      		      		
      		
