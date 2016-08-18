.text

main:
	li $a0, 15
	jal factorial
	
	move $a0, $v0
	jal print_int
	
	li $v0, 10
	syscall
	
factorial:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	slti $t0, $a0, 2
	
	beq $t0, $zero, recurs
	
	return1:
		li $v0, 1
		j end_funct
	
	recurs:
		move $s0, $a0
		addiu $a0, $a0, -1
		
		jal factorial
		
		mult $s0, $v0
		mflo $v0
		
		j end_funct
	
	end_funct:	
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 8
	
		jr $ra
	
print_int:
	li $v0, 1
	syscall
	jr $ra