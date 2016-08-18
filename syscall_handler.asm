.text

syscall_handler:
	# Prologue
	
	addi $sp, $sp -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0
	
	addi $a0, $sp, 8
	lw $a1, 12($s0)
	jal get_int_from_user
	
	slt $t0, $s1, $zero
	bne $t0, $zero, else
	li $t1, 17
	slt $t0, $t1, $s1
	bne $t0, $zero, else
	
	la $t0, syscall_table
	
	sll $t1, $s1, 2
	add $t0, $t0, $t1
	lw $t0, 0($t0)
	
	lw $a0, 12($s0)
	jalr $t0
	
	sw $v0, 28($s0)
	j epilogue
	
	else:
		jal thread_exit
		
	epilogue:
	
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		jr $ra