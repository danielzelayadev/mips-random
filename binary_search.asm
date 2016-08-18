.data
	arr: .word 10, 2, 400, 40, 200, 1000, 2000, 300, 1500, 100

.text

main:
	la $a0, arr
	li $a1, 0
	li $a2, 9
	li $a3, 300
	
	jal binary_search
	
	move $a0, $v0
	jal print_int
	
	li $v0, 10
	syscall	

binary_search:
	# $a0 -- arr pointer
	# $a1 -- left
	# $a2 -- right
	# $a3 -- x
	
	slt $t0, $a2, $a1
	bne $t0, $zero, returnNeg1
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	sub $t0, $a2, $a1
	srl $t0, $t0, 1
	add $t0, $t0, $a1
	
	sll $t1, $t0, 2
	add $t1, $t1, $a0
	lw $t1, 0($t1)
	
	beq $t1, $a3, returnMid
	slt $t2, $a3, $t1
	bne $t2, $zero, returnLeft
	j returnRight
	
	returnMid:
		move $v0, $t0
		j end_funct
	
	returnLeft:
		addi $a2, $t0, -1
		jal binary_search
		j end_funct
		
	returnRight:
		addi $a1, $t0, 1
		jal binary_search
		j end_funct
		
	returnNeg1:
		li $v0, -1
		jr $ra
	
	end_funct:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra		

print_int:
	li $v0, 1
	syscall
	jr $ra
	
	