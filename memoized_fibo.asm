.data

list: .word

.text

main:
	li $a0, 3
	la $a1, list
	jal memo_fib
	j end

memo_fib:
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0
	
	# END PROLOGUE
	
	beq $s0, $zero, return0
	
	addiu $t0, $zero, 1
	beq $s0, $t0, return1
	
	sll $t0, $s0, 2
	addu $t1, $t0, $a1
	lw $t2, 0($t1)
	bne $t2, $zero, return_memolist
	
	recursion:
		addiu $a0, $s0, -1
		jal memo_fib
		move $s1, $v0
		
		addiu $a0, $s0, -2
		jal memo_fib
		
		addu $v0, $s1, $v0
		sw $v0, 0($t1)
		
		j epilogue
	
	return0:
		move $v0, $zero
		j epilogue
	
	return1:
		move $v0, $t0
		j epilogue
	
	return_memolist:
		move $v0, $t2
		j epilogue
	
	epilogue:
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 12
		jr $ra
	
end:
