.data
str.Dragon: .asciiz "Dragon "
str.Sword: .asciiz "Sword "
str.Orc: .asciiz "Orc "
.text
#--------------------sets up the loop------------------------------------------
#acts as a condition check for the counter
li $t1, 2
#----------------------roll the dice----------------------------------------------------
random:
#adds 1 to the counter
addi $t0, $t0, 1
#sets the upper bound to 12 - this means the the lowest number possible is 0 and the highest is 11.
#which is still 12 numbers in total matching 12 possible outcomes
li $a1, 12
#generates random number within the range set above range
li $v0, 42
syscall
#get the random number out of $a0 since $a0 is reused later
move $s0, $a0
#$s0 contains the dice roll
#------------------------print outcome---------------------------------------------------
#branch if less or equal to 4 which is 5 sides of the dice (0,1,2,3,4)
ble $s0, 4, dragon
#since the above branch did not execute, try this if statement
#branch if less or equal to 7 which is 3 sides of the dice (5,6,7)
ble $s0, 7, sword
#branch if greather than 7 which is 4 sides of the dice (8,9,10,11)
#essentially an else statement, if the program reaches this line, it means the two above branch statements were false
j orc

dragon:
#load outcome string into register
la $a0, str.Dragon
#print string
li $v0, 4
syscall
#if the counter reaches 2, then stop the program
beq $t0, $t1, stop
#else roll the dice again
j random

#same as dragon
sword:
la $a0, str.Sword
li $v0, 4
syscall
beq $t0, $t1, stop
j random

#same as dragon
orc:
la $a0, str.Orc
li $v0, 4
syscall
beq $t0, $t1, stop
j random


#------------------------exit---------------------------------------------
stop:
li $v0, 10
syscall
