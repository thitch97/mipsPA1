#--------------------------------------------------
# Timothy Hitchener 
# Programming Assignment 1 -- Reads a string of up to 8 characters from user input and checks its validity as 
#			      a hexadecimal value and prints out the corresponding decimal value.

# Registers:
#	$t0 = 
#	$t1 = 
# Syscall parameters:	
#	$v0 = 
#	$a0 = 
#
#
#
#
#
#
#


.data
	input:	.space 9 		# Space allocated for 8 characters and a terminating character
	prompt:	.asciiz "Enter a hexadecimal number:"	
	error: 	.asciiz "Hexadecimal number is invalid."

.text

main:

	la $a0, prompt		# load the address of the prompt into the syscall parameter
	li $v0, 4		# load the syscall for printing a string into syscall variable
	syscall
	
	la $a0, input		# load the input into the syscall parameter
	li $a1, 9		# allocate the space for the input string	
	li $v0, 8		# load the syscall for read string
	syscall
	
	la $a0, ($t0)
	
	addi $t4, $zero, 0


	
	
	

