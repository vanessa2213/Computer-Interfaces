# Perla Vanessa Jaime Gaytán A00344428
		
	lui  $t1, 65535       		#load address ffff0000 in register t1 for later use 
	addi  $t2, $t1, 4   		#load address ffff0004 ($t1 + 4) in register t2 for later use
loop: 	lw   $t3, ($t1)      		#read the addres ffff0000 in order to see if 
	beq  $t3, $zero, loop 		#keep in track if ffff0000 changes to 1 it means that a key was pressed if not go to loop and keep check in it
	lw   $t4, ($t2)			#read which key was pressed on ffff0004 ($t2) and save it in $t4
	#validation to see which one was pressed  in ascii codeand print it
	#space
	li  $t5, 32			#0 
	beq  $t4, $t5, printspace
	#nums
	li  $t5, 48			#0
	beq  $t4, $t5, print0
	li  $t5, 49			#1
	beq  $t4, $t5, print1
	li  $t5, 50			#2
	beq  $t4, $t5, print2	
	li  $t5, 51			#3
	beq  $t4, $t5, print3
	li  $t5, 52			#4
	beq  $t4, $t5, print4	
	li  $t5, 53			#5
	beq  $t4, $t5, print5
	li  $t5, 54			#6
	beq  $t4, $t5, print6
	li  $t5, 55			#7
	beq  $t4, $t5, print7
	li  $t5, 56			#8
	beq  $t4, $t5, print8
	li  $t5, 57			#9
	beq  $t4, $t5, print9
	#lower case letters
	li  $t5, 97
	beq  $t4, $t5, printa
	li  $t5, 98
	beq  $t4, $t5, printb
	li  $t5, 99
	beq  $t4, $t5, printc
	li  $t5, 100
	beq  $t4, $t5, printd
	li  $t5, 101
	beq  $t4, $t5, printe
	li  $t5, 102
	beq  $t4, $t5, printf
	li  $t5, 103
	beq  $t4, $t5, printg
	li  $t5, 104
	beq  $t4, $t5, printh
	li  $t5, 105
	beq  $t4, $t5, printi
	li  $t5, 106
	beq  $t4, $t5, printj
	li  $t5, 107
	beq  $t4, $t5, printk
	li  $t5, 108
	beq  $t4, $t5, printl
	li  $t5, 109
	beq  $t4, $t5, printm
	li  $t5, 110
	beq  $t4, $t5, printn
	li  $t5, 241
	beq  $t4, $t5, printñ
	li  $t5, 111
	beq  $t4, $t5, printo
	li  $t5, 112
	beq  $t4, $t5, printp
	li  $t5, 113
	beq  $t4, $t5, printq
	li  $t5, 114
	beq  $t4, $t5, printr
	li  $t5, 115
	beq  $t4, $t5, prints
	li  $t5, 116
	beq  $t4, $t5, printt
	li  $t5, 117
	beq  $t4, $t5, printu
	li  $t5, 118
	beq  $t4, $t5, printv
	li  $t5, 119
	beq  $t4, $t5, printw
	li  $t5, 120
	beq  $t4, $t5, printx
	li  $t5, 121
	beq  $t4, $t5, printy
	li  $t5, 122
	beq  $t4, $t5, printz
	#upper case letters
	li  $t5, 65
	beq  $t4, $t5, printA
	li  $t5, 66
	beq  $t4, $t5, printB
	li  $t5, 67
	beq  $t4, $t5, printC
	li  $t5, 68
	beq  $t4, $t5, printD
	li  $t5, 69
	beq  $t4, $t5, printE
	li  $t5, 70
	beq  $t4, $t5, printF
	li  $t5, 71
	beq  $t4, $t5, printG
	li  $t5, 72
	beq  $t4, $t5, printH
	li  $t5, 73
	beq  $t4, $t5, printI
	li  $t5, 74
	beq  $t4, $t5, printJ
	li  $t5, 75
	beq  $t4, $t5, printK
	li  $t5, 76
	beq  $t4, $t5, printL
	li  $t5, 77
	beq  $t4, $t5, printM
	li  $t5, 78
	beq  $t4, $t5, printN
	li  $t5, 209
	beq  $t4, $t5, printÑ
	li  $t5, 79
	beq  $t4, $t5, printO
	li  $t5, 80
	beq  $t4, $t5, printP
	li  $t5, 81
	beq  $t4, $t5, printQ
	li  $t5, 82
	beq  $t4, $t5, printR
	li  $t5, 83
	beq  $t4, $t5, printS
	li  $t5, 84
	beq  $t4, $t5, printT
	li  $t5, 85
	beq  $t4, $t5, printU
	li  $t5, 86
	beq  $t4, $t5, printV
	li  $t5, 87
	beq  $t4, $t5, printW
	li  $t5, 88
	beq  $t4, $t5, printX
	li  $t5, 89
	beq  $t4, $t5, printY
	li  $t5, 90
	beq  $t4, $t5, printZ
	j   loop			#just in case a letter not identificated was pressed go back to loop
	
#Print which key was pressed	
      .data
zero:   .asciiz "0"        
one:    .asciiz "1"  
two:    .asciiz "2"  
thr:    .asciiz "3"    
four:   .asciiz "4"  
five:   .asciiz "5"  
six:    .asciiz "6" 
sev:    .asciiz "7"   
eig:    .asciiz "8"  
nine:    .asciiz "9"  

space: .asciiz  " "

A:    .asciiz "A"
B:    .asciiz "B"
C:    .asciiz "C"
D:    .asciiz "D"
E:    .asciiz "E"
F:    .asciiz "F"
G:    .asciiz "G"
H:    .asciiz "H"
I:    .asciiz "I"
J:    .asciiz "J"
K:    .asciiz "K"
L:    .asciiz "L"
M:    .asciiz "M"
N:    .asciiz "N"
Ñ:    .asciiz "Ñ"
O:    .asciiz "O"
P:    .asciiz "P"
Q:    .asciiz "Q"
R:    .asciiz "R"
S:    .asciiz "S"
T:    .asciiz "T"
U:    .asciiz "U"
V:    .asciiz "V"
W:    .asciiz "W"
X:    .asciiz "X"
Y:    .asciiz "Y"
Z:    .asciiz "Z"

a:    .asciiz "a"
bi:   .asciiz "b"
c:    .asciiz "c"
d:    .asciiz "d"
e:    .asciiz "e"
f:    .asciiz "f"
g:    .asciiz "g"
h:    .asciiz "h"
i:    .asciiz "i"
jo:    .asciiz "j"
k:    .asciiz "k"
l:    .asciiz "l"
m:    .asciiz "m"
n:    .asciiz "n"
ñ:    .asciiz "ñ"
o:    .asciiz "o"
p:    .asciiz "p"
q:    .asciiz "q"
r:    .asciiz "r"
s:    .asciiz "s"
t:    .asciiz "t"
u:    .asciiz "u"
v:    .asciiz "v"
w:    .asciiz "w"
x:    .asciiz "x"
y:    .asciiz "y"
z:    .asciiz "z"
      .text
printspace: la   $a0, space  
      	    li   $v0, 4           
       	    syscall              
      	    j   loop 
#print numbers
print0: la   $a0, zero   
      	li   $v0, 4           
      	syscall              
      	j   loop
print1: la   $a0, one   
      	li   $v0, 4           
      	syscall              
      	j   loop
print2: la   $a0, two  
      	li   $v0, 4           
      	syscall              
      	j   loop
print3: la   $a0, thr   
      	li   $v0, 4           
      	syscall              
      	j   loop
print4: la   $a0, four   
      	li   $v0, 4           
      	syscall              
      	j   loop
print5: la   $a0, five   
      	li   $v0, 4           
      	syscall              
      	j   loop
print6: la   $a0, six   
      	li   $v0, 4           
      	syscall              
      	j   loop
print7: la   $a0, sev   
      	li   $v0, 4           
      	syscall              
      	j   loop
print8: la   $a0, eig  
      	li   $v0, 4           
      	syscall              
      	j   loop
print9: la   $a0, nine  
      	li   $v0, 4           
      	syscall              
      	j   loop
#print upper case letters      	
printA: la   $a0, A   
      	li   $v0, 4           
      	syscall              
      	j   loop
printB: la   $a0, B  
      	li   $v0, 4           
      	syscall              
      	j   loop
printC: la   $a0, C  
      	li   $v0, 4           
      	syscall               
      	j   loop      	      
printD: la   $a0, D  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printE: la   $a0, E  
      	li   $v0, 4           
      	syscall              
      	j   loop   
printF: la   $a0, F  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printG: la   $a0, G  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printH: la   $a0, H 
      	li   $v0, 4           
      	syscall               
      	j   loop  
printI: la   $a0, I  
     	li   $v0, 4           
      	syscall               
      	j   loop      
printJ: la   $a0, J  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printK: la   $a0, K  
      	li   $v0, 4           
      	syscall              
      	j   loop      
printL: la   $a0, L 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printM: la   $a0, M  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printN: la   $a0, N 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printÑ: la   $a0, Ñ 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printO: la   $a0, O  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printP: la   $a0, P 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printQ: la   $a0, Q  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printR: la   $a0, R  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printS: la   $a0, S  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printT: la   $a0, T 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printU: la   $a0, U  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printV: la   $a0, V 
      	li   $v0, 4          
      	syscall               
      	j   loop      
printW: la   $a0, W  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printX: la   $a0, X 
      	li   $v0, 4           
      	syscall               
      	j   loop      
printY: la   $a0, Y  
      	li   $v0, 4
      	syscall               
      	j   loop      
printZ: la   $a0, Z  
      	li   $v0, 4           
      	syscall              
      	j   loop      
#print lower case letters
printa: la   $a0, a   
      	li   $v0, 4           
      	syscall              
      	j   loop
printb: la   $a0, bi  
      	li   $v0, 4           
      	syscall              
      	j   loop
printc: la   $a0, c  
      	li   $v0, 4           
      	syscall               
      	j   loop      	      
printd: la   $a0, d  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printe: la   $a0, e  
      	li   $v0, 4           
      	syscall              
      	j   loop   
printf: la   $a0, f  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printg: la   $a0, g  
      	li   $v0, 4           
      	syscall               
      	j   loop   
printh: la   $a0, h  
      	li   $v0, 4           
      	syscall               
      	j   loop  
printi: la   $a0, i  
     	li   $v0, 4           
      	syscall               
      	j   loop      
printj: la   $a0, jo  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printk: la   $a0, k  
      	li   $v0, 4           
      	syscall              
      	j   loop      
printl: la   $a0, l  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printm: la   $a0, m  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printn: la   $a0, n  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printñ: la   $a0, ñ  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printo: la   $a0, o  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printp: la   $a0, p  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printq: la   $a0, q  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printr: la   $a0, r  
      	li   $v0, 4           
      	syscall               
      	j   loop      
prints: la   $a0, s  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printt: la   $a0, t  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printu: la   $a0, u  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printv: la   $a0, v  
      	li   $v0, 4          
      	syscall               
      	j   loop      
printw: la   $a0, w  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printx: la   $a0, x  
      	li   $v0, 4           
      	syscall               
      	j   loop      
printy: la   $a0, y  
      	li   $v0, 4
      	syscall               
      	j   loop      
printz: la   $a0, z  
      	li   $v0, 4           
      	syscall              
      	j   loop      
