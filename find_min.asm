.data
	arr: .word 5, 10, 1, 40
	cmin: .word 50

.text

main:
	la $a0, arr
	li $a1, 4
	la $a2, cmin
	move $s0, $a2
	jal find_min
	
	lw $a0, 0($s0)
	jal print_int
	
	li $v0, 10
	syscall
	
find_min:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 1
	
	bne $a1, $t0, recurs
	
	lw $t0, 0($a0)
	lw $t1, 0($a2)
	
	slt $t2, $t0, $t1
	beq $t2, $zero, end_funct
	
	sw $t0, 0($a2)
	j end_funct
	
	recurs:
		addiu $a0, $a0, 4
		addiu $a1, $a1, -1
		jal find_min
				
	end_funct:
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra	

print_int:
	li $v0, 1
	syscall
	jr $ra