# Compute and place all values of x in contiguous memory addresses
      .data
fibs: .word   0 : 100        # "array" of 12 words to contain fib values
size: .word  101             # size of "array"
      .text
      la   $t0, fibs        # load address of array
      la   $t5, size        # load address of size variable
      lw   $t5, 0($t5)      # load array size
      li   $t2, 0           # x[0]=0
      sw   $t2, 0($t0)	     # load value x[0]
      addi $t6, $zero, 1    #starting loop at i = 1
      addi $t1, $t5, 0      # Counter for loop, will execute 100 times
loop: lw   $t3, 0($t0)      # Get value from array x[i-1]
      add  $t2, $t3, $t6    # $t2 = x[i-1] + i
      sw   $t2, 4($t0)      # Store in x[i]
      addi $t0, $t0, 4      # increment address
      addi $t6, $t6, 1      # increment loop counter
      bne $t1,$t6, loop     # repeat if not finished yet.
      la   $a0, fibs        # first argument for print (array)
      add  $a1, $zero, $t5  # second argument for print (size)
      jal  print            # call print routine.
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.

#########  routine to print the numbers on one line.

      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "The numbers of x[N] are:\n"
      .text
print:add  $t0, $zero, $a0  # starting address of array
      add  $t1, $zero, $a1  # initialize loop counter to array size
      la   $a0, head        # load address of print heading
      li   $v0, 4           # specify Print String service
      syscall               # print heading
out:  lw   $a0, 0($t0)      # load fibonacci number for syscall
      li   $v0, 1           # specify Print Integer service
      syscall               # print fibonacci number
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # output string
      addi $t0, $t0, 4      # increment address
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, out         # repeat if not finished
      jr   $ra              # return
