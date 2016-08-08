.text

# Linked List:
# Type  - 4 Bytes
# Size  - 4 Bytes
# First - 4 Bytes

main:
	li $a0, 4 
	jal new_list
	
	# Testing New List
	
	move $s0, $v0
	
	lw $a0, 0($s0)
	jal print_int
	
	lw $a0, 4($s0)
	jal print_int
	
	lw $a0, 8($s0)
	jal print_int
	
	j end

new_list:
	# Prologue
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	# Reserving Space for New Linked List
	
	li $a0, 12
	jal malloc  # New Linked List
	
	lw $a0, 4($sp) # Restore new_list argument0
	
	# Init New Linked List
	
	sw $a0, 0($v0)   # Store Element Size
	sw $zero, 4($v0) # Store Element Count
	sw $zero, 8($v0) # Store NULL Reference for First Element
	
	# Epilogue
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	jr $ra
	
# UTILITIES

malloc:
	li $v0, 9
	syscall
	jr $ra

print_int:
	li $v0, 1
	syscall
	jr $ra
	
# End Program

end:
	
