.text

string_print:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s1, $a0
	
	addiu $s0, $zero, 0
	beg_for:
		beq $s0, $a1, end_funct
		addu $t0, $s1, $s0
		lbu $a0, 0($t0)
		jal print
		addiu $s0, $s0, 1
		j beg_for
	
	end_funct:
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 12
		jr $ra
	
print: