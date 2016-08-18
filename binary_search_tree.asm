.text

insert:
	# $a0 -- key
	# $a1 -- tree
	
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0
	
	lw $s1, 0($a1)
	
	beq $s1, $zero, ins
	
	lw $t0, 0($s1)
	
	slt $t1, $a0, $t0
	bne $t1, $zero, rec_left
	
	bne $a0, $t0, rec_right
	
	ins:
		la $t1, str_node
		lw $a0, 0($t1)
		jal sizeof
		
		move $a0, $v0
		jal malloc
		
		sw $v0, 0($s1)
		sw $a0, 0($v0)
		sw $zero, 4($v0)
		sw $zero, 8($v0)
		
		j end_funct
	rec_left:
		addi $a1, $t0, 4
		jal insert
		j end_funct
	rec_right:
		addi $a1, $t0, 8
		jal insert
		j end_funct
	
	end_funct:
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		jr $ra
		
search:
	# $a0 -- key
	# $a1 -- leaf
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $a1, $zero, return_null
	
	lw $t0, 0($a1)
	
	beq $a0, $t0, return_leaf
	
	slt $t1, $a0, $t0
	bne $t1, $zero, return_search_left
	
	j return_search_right
	
	
	return_leaf:
		move $v0, $a1
		j end_search
	
	return_search_left:
		lw $a1, 4($a1)
		jal search
		j end_search
	
	return_search_right:
		lw $a1, 8($a1)
		jal search
		j end_search
	
	return_null:
		move $v0, $zero
		j end_search
	
	end_search:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra