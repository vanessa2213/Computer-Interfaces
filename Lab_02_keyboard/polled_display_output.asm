# Perla Vanessa Jaime Gaytán A00344428
	lui  $t1, 65535      	#load address ffff0000 in register t1 for later use  	
	addi $t2, $t1, 4   	#load address ffff0004 ($t1 + 4) in register t2 for later use
	addi $t5, $t1, 12	#load address ffff000c ($t1 + 12) in register t5 for later use 
loop: 	lw   $t3, ($t1)      	#read the addres ffff0000 in order to see if 
	beq  $t3, $zero, loop 	#keep in track if ffff0000 changes to 1 it means that a key was pressed if not go to loop and keep check in it
	lw   $t4, ($t2)		#read which key was pressed on ffff0004 ($t2) and save it in $t4
	sw   $t4, ($t5)		#save the key that was pressed ($t4) in ffff000c ($t5) to show on the display
	j loop			#jump to loop in order to check again 
	