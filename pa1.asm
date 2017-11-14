#--------------------------------------------------
# Timothy Hitchener 
# Programming Assignment 1

.data
	input:	.space 9 		# Space allocated for 8 characters and a terminating character
	prompt:	.asciiz "Enter a hexadecimal number:"	
	error: 	.asciiz "Hexadecimal number is invalid."

.text

main:
	