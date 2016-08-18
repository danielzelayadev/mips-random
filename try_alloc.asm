.text

main:
	li $a0, 8
	jal malloc
	sw $a0, 0($v0)
	lw $a0, 0($v0)
	li $v0, 1
	syscall
	j end

malloc:
	li $v0, 9
	syscall
	jr $ra
	
end: