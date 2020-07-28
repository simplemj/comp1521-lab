# COMP1521 18s2 Week 04 Lab
# Compute factorials, recursive function


### Global data

   .data
msg1:
   .asciiz "n  = "
msg2:
   .asciiz "n! = "
eol:
   .asciiz "\n"

### main() function
   .text
   .globl main
main:
   #  set up stack frame
   sw    $fp, -4($sp)       # push $fp onto stack
   la    $fp, -4($sp)       # set up $fp for this function
   sw    $ra, -4($fp)       # save return address
   sw    $s0, -8($fp)       # save $s0 to use as ... int n;
   addi  $sp, $sp, -12      # reset $sp to last pushed item

   #  code for main()
   li    $s0, 0             # n = 0;
   
   la    $a0, msg1
   li    $v0, 4
   syscall                  # printf("n  = ");

   li    $v0, 5
   syscall
   move  $s0, $v0           # scanf("%d", &n);
   
   move  $a0, $s0           
   jal   fac
   nop
   move  $s0, $v0           # tmp = fac(n);
                            # recycle $s0, don't need n now
   la    $a0, msg2
   li    $v0, 4
   syscall                  # printf("n! = ");

   move  $a0, $s0
   li    $v0, 1
   syscall                  # printf("%d\n",tmp);

   la    $a0, eol
   li    $v0, 4
   syscall                  # printf("\n");

   # clean up stack frame
   lw    $s0, -8($fp)       # restore $s0 value
   lw    $ra, -4($fp)       # restore $ra for return
   la    $sp, 4($fp)        # restore $sp (remove stack frame)
   lw    $fp, ($fp)          # restore $fp (remove stack frame)

   li    $v0, 0
   jr    $ra                # return 0

# fac() function

fac:
   # set up stack frame
# ... TODO ...
   sw    $fp, -4($sp)
   la    $fp, -4($sp)
   sw	 $ra, -4($fp)
   sw    $s0, -8($fp)
   sw    $s1, -12($fp)
   sw    $s2, -16($fp)
   addi  $sp, $sp, -20
   # code for recursive fac()
# ... TODO ...
   move  $s0, $a0
   li    $s2, 1
if_basic_case:
   bgt   $s0, $s2, end_if
   nop
   li    $v0, 1  
   j     end
end_if:
   addi  $a0, $s0, -1
   jal   fac
   mul   $s0, $s0, $v0
   move  $v0, $s0  
   # clean up stack frame
# ... TODO ...   
end:
   addi  $sp, $sp,12
   lw    $s2, -16($fp)
   lw    $s1, -12($fp)
   lw    $s0, -8($fp)
   lw    $ra, -4($fp)
   la    $sp, 4($fp)
   lw    $fp, ($fp)
   jr    $ra               # return tmp;
