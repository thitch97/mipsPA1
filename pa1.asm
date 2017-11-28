#--------------------------------------------------
# Timothy Hitchener 
# Programming Assignment 1 -- Reads a string of up to 8 characters from user input and checks its validity as 
#			      a hexadecimal value and prints out the corresponding decimal value.

# Registers:
#	$t0 = stores the address of the input string
# 	$t2 = the current character
#	$t3 = the decimal value of the character
# 	$t4 = counter for the length of the string
#	$t5 = 
#	$t6 = desired power
#	$t7 = 
#	$t8 = 
# Saved:
# 	$s0 = stores the sum (decimal number)
#	$s1 = stores the constant number of bits to be multiplied by the exponent during shifting
# Syscall parameters:	
#	$v0 
#	$a0  
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
	addi $s1, $zero, 4
	addi $s0, $zero, 0
	addi $s2, $zero, 10000
 	
	la $a0, input		# load the input into the syscall parameter
	li $a1, 9		# allocate the space for the input string	
	li $v0, 8		# load the syscall for read string
	syscall
	
	add $t0, $zero, $a0 	# load string address into $t0
	
	addi $t4, $zero, 0	# initialize counter to 0
	

find_length:

	lb $t2, 0($t0)			#load the first character of the string in to $t2
	beq $t2, 32, space_check	#If the char is equal to a space, check if we are within a string
	beqz $t2, end_find_length	#If the char is equal to 0, end the loop
	beq $t2, 10, end_find_length	# If the char is equal to a newline, end the loop
		
	
	addi $t4, $t4, 1 		#Increment the counter	
	addi $t0, $t0, 1		#Move to the next character
	
	j find_length

end_find_length:	
	
	add $t0, $zero, $a0  			#Reset $t0 to the string address
	add $t5, $zero, $t4	

loop:
	lb $t2, 0($t0)
		
	beq $t2, 32, store_space
	beq $t2, 10, pass
	beqz $t2, pass
	
lower_upper_bound:
	blt $t2, 103, lower_lower_bound
	j fail

lower_lower_bound:
	bgt $t2, 96, store_low_val 
	j upper_upper_bound

store_low_val:
	addi $t3, $t2, -87
	sllv $s0, $s0, $s1
	add $s0, $t3, $s0
	addi $t0, $t0, 1

	j loop


upper_upper_bound:
	blt $t2, 71, upper_lower_bound
	j fail

upper_lower_bound:
	bgt $t2, 64, store_up_val
	j num_upper_bound

store_up_val:
	addi $t3, $t2, -55
	sllv $s0, $s0, $s1
	add $s0, $t3, $s0
	addi $t0, $t0, 1
	addi $t5, $t5, -1
	
	j loop

num_upper_bound:
	blt $t2, 58, num_lower_bound
	j fail
	
num_lower_bound:
	bgt $t2, 47, store_num_val
	j fail

store_num_val: 
	addi $t3, $t2, -48
	sllv $s0, $s0, $s1
	add $s0, $t3, $s0
	addi $t0, $t0, 1
	
	j loop
		
end:
	li $v0, 10
	syscall
	
	
pass:
	div $s0, $s2
	mfhi $a0
	mflo $a1
	li $v0, 1
	syscall
	j end
	
fail:
	li $v0, 4
	la $a0, error
	syscall
	j end
	
space_check:
	
	add $t8, $zero, $t0
	addi $t8, $t8, -1
	lb $t9, 0($t8)
	beq $t9, 32, to_cont
	beq $t9, 0, to_cont
	
	
	j fail
	
to_cont:
	addi $t4, $t4, 1
	addi $t0, $t0, 1
	j find_length

store_space:
	addi $t0, $t0, 1
	j loop


 
