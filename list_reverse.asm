.text

main:


list_reverse:

	# Prologue
	
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0
	
	jal list_empty
	move $a0, $s0
	beq $v0, $zero, end_funct
	
	jal list_begin
	move $a0, $s0
	move $s0, $v0
	
	for:
		jal list_end
		move $a0, $s0
		
		beq $s1, $v0, post_for
		
		move $a0, $s1
		
		addi $s1, $s1, 4
		
		move $a1, $s1
		
		jal swap
		
		lw $s1, 0($s0)
		j for
	
	post_for:
		
		addi $a0, $s0, 4
		addi $a1, $s0, 12
		
		jal swap
		
		lw $a0, 4($s0)
		lw $a1, 12($s0)
		
		addi $a1, $a1, 4
		
		jal swap
	
	end_funct:
	
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp,$sp, 12
		jr $ra

list_begin:

list_end:	
	
list_empty:

swap:
	