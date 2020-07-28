# COMP1521 Practice Prac Exam #1
# main program + show function

   .data
msg1:
   .asciiz "The matrix\n"
msg2:
   .asciiz "is an identity matrix\n"
msg3:
   .asciiz "is not an identity matrix\n"
   .align  2

   .text
   .globl main
main:
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)
   addi $sp, $sp, -4
   sw   $s1, ($sp)

   la   $a0, m
   lw   $a1, N
   jal  is_ident      # s1 = is_ident(m,N)
   move $s1, $v0

   la   $a0, msg1
   li   $v0, 4
   syscall           # printf("The matrix\n")
   la   $a0, m
   lw   $a1, N
   jal  showMatrix   # showMatrix(m, N)

main_if:             # if (s1)
   beqz $s1, main_else
   la   $a0, msg2
   li   $v0, 4
   syscall           # printf("is an identity matrix\n")
   j    end_main_if

main_else:           # else
   la   $a0, msg3
   li   $v0, 4
   syscall           # printf("is not an identity matrix\n")

end_main_if:
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

#main function!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# end main()

# void showMatrix(m, N)
#void function!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# params: m=$a0, N=$a1
# locals: m=$s0, N=$s1, row=$s2, col=$s3
showMatrix:
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)
   addi $sp, $sp, -4
   sw   $s0, ($sp)
   addi $sp, $sp, -4
   sw   $s1, ($sp)
   addi $sp, $sp, -4
   sw   $s2, ($sp)
   addi $sp, $sp, -4
   sw   $s3, ($sp)

   move $s0, $a0
   move $s1, $a1
   li   $s2, 0
show_matrix_loop1:
   bge  $s2, $s1, end_show_matrix_loop1

   li   $s3, 0
show_matrix_loop2:
   bge  $s3, $s1, end_show_matrix_loop2

   li   $a0, ' '          # putchar(' ')
   li   $v0, 11
   syscall

   move $t0, $s2
   mul  $t0, $t0, $s1
   add  $t0, $t0, $s3
   li   $t1, 4
   mul  $t0, $t0, $t1
   add  $t0, $t0, $s0
   lw   $a0, ($t0)
   li   $v0, 1            # printf("%d",m[row][col])
   syscall

   addi $s3, $s3, 1       # col++
   j    show_matrix_loop2

end_show_matrix_loop2:
   li   $a0, '\n'         # putchar('\n')
   li   $v0, 11
   syscall

   addi $s2, $s2, 1       # row++
   j    show_matrix_loop1

end_show_matrix_loop1:

   lw   $s3, ($sp)
   addi $sp, $sp, 4
   lw   $s2, ($sp)
   addi $sp, $sp, 4
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

   .text
   .globl is_ident

# params: m=$a0, n=$a1
is_ident:
# prologue
	sw $fp,-4($sp)
	la $fp,-4($sp)
	sw $ra,-4($fp)
	sw $s0,-8($fp)   #save a0..m
	sw $s1,-12($fp)	#save a1..n
	sw $s2,-16($fp)	#save row
	sw $s3,-20($fp) #save col
	sw $s4,-24($fp) #save 1
	addi $sp,$sp,-28


   # if you need to save more than four $s? registers
   # add extra code here to save them on the stack
	#code for function 2
	
	move $s0,$a0
	move $s1,$a1
	li $s2,0
	li $s3,0
	li $s4,1
loop1:
	bge $s2,$s1,end_loop1
	loop2:
		bge $s3,$s1,end_loop2
		if1:
			bne $s2,$s3,else1
			if1_1:
				beq $s0,$s4,end_loop1
				li $v0,0
				j epilogue
		else1:
			else1_1:
				beq $s0,$0,end_loop1
				li $v0,0
				j epilogue
			
end_loop2:
	addi $s2,$s2,1
end_loop1:
	li $v0,1


epilogue:
   # if you saved more than four $s? registers
   # add extra code here to restore them
	lw $s4,($sp)
	addi $sp,$sp,4
   lw   $s3, ($sp)
   addi $sp, $sp, 4
   lw   $s2, ($sp)
   addi $sp, $sp, 4
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

# COMP1521 18s1 Exam Q1
# Matrix data

   .data
N:
   .word   9
m:
   .word   1, 0, 0, 0, 0, 0, 0, 0, 0
   .word   0, 1, 0, 0, 0, 0, 0, 0, 0
   .word   0, 0, 1, 0, 0, 0, 0, 0, 0
   .word   0, 0, 0, 1, 0, 0, 0, 0, 0
   .word   0, 0, 0, 0, 1, 0, 0, 0, 0
   .word   0, 0, 0, 0, 0, 1, 0, 0, 0
   .word   0, 0, 0, 0, 0, 0, 1, 0, 0
   .word   0, 0, 0, 0, 0, 0, 0, 1, 0
   .word   0, 0, 0, 0, 0, 0, 0, 0, 1

   .align  2

