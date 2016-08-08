.text

# Linked List:
# First - 4 Bytes
# Size  - 4 Bytes

# Linked List Element:
# Value - 4 Bytes
# Next  - 4 Bytes

main:
	# Create New Linked List
	
	jal new_list
	
	move $s0, $v0 # Store new_list address in local variable
	
	# Insert New Element
	
	move $a0, $s0
	li $a1, 500
	jal insert
	
	j end

new_list:
	# Prologue
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Reserving Space for New Linked List
	
	li $a0, 8
	jal malloc  # New Linked List
	
	# Init New Linked List
	
	sw $zero, 0($v0) # Store NULL Reference for First Element
	sw $zero, 4($v0) # Store Element Count
	
	# Epilogue
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
new_list_element:
	# Prologue
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	# Reserve Space for New List Element
	
	li $a0, 8
	jal malloc # New List Element
	
	lw $a0, 4($sp) # Restore argument0
	
	# Init New List Element
		
	sw $a0, 0($v0)   # Store the element's init value
	sw $zero, 4($v0) # Store NULL Reference for Next Element
	
	# Epilogue:
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	jr $ra
	
insert:
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
	
