.text

string_print:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	move $s0, $a0
	
	lbu $a0, 0($s0)
	
	beq $a0, $zero, end_funct
	
	do:
		jal print
		addiu $s0, $s0, 1
		lbu $a0, 0($s0)
	bne $a0, $zero, do
	
	end_funct:
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 8
		jr $ra

print: