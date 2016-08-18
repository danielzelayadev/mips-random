# void bubbleSort(int ar[])
# {
#  for (int i = (ar.length - 1); i >= 0; i--)
#   {
#      for (int j = 1; j ≤ i; j++)
#      {
#         if (ar[j-1] > ar[j])
#         {
#              int temp = ar[j-1];
#              ar[j-1] = ar[j];
#              ar[j] = temp;
#         } 
#     } 
#  } 
# }

.data
	arr: .word 10, 2, 400, 40, 200, 1000, 2000, 300, 1500, 100
	sp: .asciiz "\t"

.text

main:
	la $a0, arr
	li $a1, 10

	jal bubble_sort
	
	la $a0, arr
	li $a1, 10
	
	jal print_array
	
	li $v0, 10
	syscall
	
bubble_sort:
	# $a0 --  arr pointer
	# $a1 -- size
	
	addi $t0, $a1, -1
	
	for_top:
		slt $t1, $t0, $zero
		bne $t1, $zero, end_bubble
		
		li $t1, 1
		for:
			slt $t2, $t0, $t1
			bne $t2, $zero, post_for
			
			addi $t2, $t1, -1 # j - 1
			
			sll $t2, $t2, 2
			add $t2, $a0, $t2
			lw $t2, 0($t2)     # ar[j-1]
			
			sll $t3, $t1, 2
			add $t3, $a0, $t3
			lw $t3, 0($t3)     # ar[j]
			
			slt $t2, $t3, $t2 # t2 = t3 < t2;
			beq $t2, $zero, adv_for
			
			addi $t2, $t1, -1 # j - 1
			sll $t2, $t2, 2
			add $t2, $a0, $t2
			lw $t4, 0($t2)     # temp = ar[j-1]
			
			sll $t3, $t1, 2
			add $t3, $a0, $t3
			lw $t5, 0($t3)     # ar[j]
			
			sw $t5, 0($t2)    # ar[j-1] = ar[j]
			sw $t4, 0($t3)    # ar[j] = temp
			
			adv_for:
				addi $t1, $t1, 1
				j for
		post_for:
			addi $t0, $t0, -1
			j for_top

	end_bubble:
		jr $ra
	

# UTILITIES

print_array:
	# $a0 -- arr pointer
	# $a1 -- size
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	li $s1, 0
	move $s0, $a0
	
	for_print_array:
		beq $s1, $a1, end_print_array
		
		sll $a0, $s1, 2
		add $a0, $s0, $a0
		
		lw $a0, 0($a0)
		
		jal print_int
		
		la $a0, sp
		jal print_str
		
		addi $s1, $s1, 1
		j for_print_array
	
	end_print_array:
		lw $s1, 8($sp)
		lw $s0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		jr $ra

print_int:
	li $v0, 1
	syscall
	jr $ra
	
print_str:
	li $v0, 4
	syscall
	jr $ra