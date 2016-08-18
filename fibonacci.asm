.text

main:
	addiu $a0, $zero, 6
	jal fibonacci
	j end

fibonacci:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0
	
	bne $s0, $zero, else_if
	addiu $v0, $zero, 0
	j end_funct
	else_if:
		addiu $t1, $zero, 1
		bne $s0, $t1, recurs
		move $v0, $t1
		j end_funct
	recurs:
		addiu $a0, $s0, -1
		jal fibonacci
		move $s1, $v0
		addiu $a0, $s0, -2
		jal fibonacci
		addu $v0, $v0, $s1
	
	end_funct:
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 12
		jr $ra

end:
