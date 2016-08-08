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
	li $a1, 120
	jal insert
	li $a1, 50
	jal insert
	li $a1, 5
	jal insert
	li $a1, 87
	jal insert
	li $a1, 42
	jal insert
	
	li $a1, 5
	li $a2, 6
	jal get
	
	lw $a0, 0($v0)
	jal print_int
	
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
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Reserve Space for New List Element
	
	li $a0, 8
	jal malloc # New List Element
	
	# Init New List Element
		
	sw $a1, 0($v0)   # Store the element's init value
	sw $zero, 4($v0) # Store NULL Reference for Next Element
	
	# Epilogue:
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
insert:
	# Prologue
	
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)
	
	# Create New Element
	
	move $a0, $a1
	jal new_list_element # Create new list element
	move $s0, $v0
		
	lw $a0, 4($sp) # Restore list address
	
	# Decide Insert
	
	jal is_empty
	
	bne $v0, $zero, insert_first # if list->isEmpty, goto insert_first
	
	insert_default:
		
		lw $t0, 0($a0) # Load address of list->first
		
		insert_while:
			lw $t1, 4($t0)              # Load address of elem->next
			beq $t1, $zero, break_while # If elem->next == NULL, break
			move $t0, $t1               # elem = elem->next
			j insert_while
		
		break_while:
			sw $s0, 4($t0) # Store new list element in elem->next
		
		j end_insert
	
	insert_first:
		sw $s0, 0($a0) # Store first list element address in list->first
		j end_insert
		
	end_insert:
	
		# Increment Size
		
		lw $t0, 4($a0)    # Load list->size
		addiu $t0, $t0, 1 # list->size++
		sw $t0, 4($a0)    # Store list->size
	
	# Epilogue
	
	lw $s0, 8($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 12
	jr $ra
	
get:
	bltz $a1, return_null
	bge $a1, $a2, return_null
	
	li $t0, 0
	lw $t1, 0($a0)
	
	cycle_list:
		beq $t0, $a1, return_elem
		lw $t1, 4($t1)
		addiu $t0, $t0, 1
		j cycle_list
	
	return_elem:
		move $v0, $t1
		jr $ra
	
	return_null:
		move $v0, $zero
		jr $ra
	
is_empty:
	lw $t0, 0($a0)	# Load List->First
	
	beq $t0, $zero, return_true # If List->First == NULL
	
	return_false:
		move $v0, $zero
		jr $ra
	return_true:
		li $v0, 1
		jr $ra
		
size:
	lw $v0, 4($a0)
	jr $ra
	
clear:
	sw $zero, 0($a0)
	sw $zero, 4($a0)
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
	
print_str:
	li $v0, 4
	syscall
	jr $ra
	
# End Program

end:
	
