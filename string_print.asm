.text

main:
	addiu $a0, $zero, 400
	jal string_print

string_print:
	addi $sp, $sp, -8 # Reservar stack frame
	sw $ra, 0($sp)    # Guardar return address
	sw $s0, 4($sp)    # Guardar s0
	
	move $s0, $a0     # s0 = a0
	
	beg_while:
		lbu $a0, 0($s0)            # Load char[i] 
		beq $a0, $zero, end_funct  # while (char[i] != '\0')
		jal print                  # print(char[i])
		addiu $s0, $s0, 1          # char++
		j beg_while
	end_funct:
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addiu $sp, $sp, 8
		jr $ra
	
print:
