##
##	Program5.asm is a array 
##        

#################################
#					 	#
#		text segment			#
#						#
#################################

	.text		
.globl __start
 
__start:			# execution starts here
#################	initialization		#################	
	la $a0,endl
	li $v0,4 
	syscall
	la $a0,sizeMessage
	li $v0,4 
	syscall
	li $t9,0
	li $v0,5 #reading integers
	syscall
	move $t9,$v0 #t1=readed integer
	la $s7,($t9)
	
#################		
	la $s0,($s7) # so=array size setted as 100 
	la $s1,array #pointing to the array
	li $t2,0 #number of elements in the array t2(numberofelement=0)
####################################################################################################################
input:	
	la $a0,strPrmt #promting the system message
	li $v0,4 
	syscall
	########
	li $v0,5 #reading integers
	syscall
	move $t1,$v0 #t1=readed integer
	########
	sw $t1,0($s1) #write the readed value which is currently in $t0 to $s1
	addi $s1,$s1,4 # write to the current s1 pointer
	addi $t2,$t2,1# numofElements++
	bne $t2,$s0,input # until we finished t2=s0 the loo which is reading and allocating the values to the array 
	#s1 will be point to the last element of the arr at the end of the array
	########
	j menu
####################################################################################################################################	
menu: #$t2 is the menu opt?on�
	
	la $a0,endl
	li $v0,4 
	syscall
	
	la $a0,menuOpt1#promting the  menu option 1
	li $v0,4 
	syscall
	la $a0,menuOpt2#promting the  menu option 2
	li $v0,4 
	syscall
	la $a0,menuOpt3#promting the  menu option 3
	li $v0,4 
	syscall
	la $a0,menuOpt4#promting the  menu option 4
	li $v0,4 
	syscall
	########	
	li $v0,5 #reading integers
	syscall
	move $t5,$v0 #t1=readed integer
	b selected
	######## $t5 is the readed integer for menu
selected:
	beq $t5,1,menu1
	beq $t5,2,menu2
	beq $t5,3,menu3
	beq $t5,4,menu4
####################################################################################################################	
menu1:
	#$t6 is the sum
	la $t7,($s7)
	la $s1,array  
	li $t6,0
	la $a0,inputint
	li $v0,4 
	syscall
	li $v0,5 #reading integers
	syscall
	move $t5,$v0 #t1=readed integer
	
	b add_loop
	######## $t5 is the readed integer for menu

	
add_loop:
	lw $t4,0($s1)
	subi $t7,$t7,1
	bgt $t4,$t5,add
	j iterate
add:	add $t6, $t6,$t4
iterate:addi $s1,$s1,4
	
	bne $t7,$zero,add_loop
		######## $
	la $a0,sum
	li $v0,4 
	syscall
		######## $
	la  $a0,($t6)
	li $v0,1
	syscall
		######## $
	la $a0,endl
	li $v0,4 
	syscall
		######## $
	j menu
###################################################################################################	
menu2:
	la $t7,($s7)
	addi $t7,$t7,1
	la $s1,array
	li $t6,0 #even sum
	li $t8,0 #odd sum
	#li $v0,5 #reading integers
	#syscall
	
loop2: 
	subi $t7,$t7,1
	beqz $t7,print
 	lw $t5,($s1)
	andi $t9,$t5,1
	bnez $t9, odd
	
even: 	
	la $a0,sum_Even
	li $v0,4 
	syscall
	lw $t4,($s1)
	add $t6,$t6,$t4
	addi $s1,$s1,4
	j loop2
	
odd:
	la $a0,sum_Odd
	li $v0,4 
	syscall
	lw $t4,($s1)
	add $t8,$t8,$t4
	addi $s1,$s1,4
	j loop2

	
print:			
	la  $a0,($t6) #promting the add
	li $v0,1 
	syscall
	la $a0,endl
	li $v0,4 
	syscall
	
	la  $a0,($t8) #promting the dd
	li $v0,1 
	syscall
	la $a0,endl
	li $v0,4 
	syscall
	j menu
###################################################################################################
menu3:
	#$t6 is the int for input
	la $t7,($s7)
	#addi $t7,$t7,1
	la $s1,array  
	li $t6,0
	la $a0,divcall#promting the  menu option 3
	li $v0,4 
	syscall
	
	li $v0,5 #reading integers
	syscall
	move $t5,$v0 #t1=readed integer
	la $a0,devi#promting the  menu option 3
	li $v0,4 
	syscall
loop3:
	lw $t4,0($s1)
	subi $t7,$t7,1
	div  $t4,$t5
	mfhi $t4
	beqz  $t4,else
	addi $s1,$s1,4
	beq $t7,0, menu	
	b loop3
else:	
	lw $t4,0($s1)
	la $a0,($t4)
	li $v0,1
	syscall
	######
	la $a0,coma
	li $v0,4 
	syscall
	######	
	
	addi $s1,$s1,4	
	
	beq $t7,0, menu
	j loop3
		
####################################################################################################################################
menu4: 
	li $v0,10
	syscall

	
####################################################################################################################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
array: .space 400
$s7: .word 10
#################
strPrmt: .asciiz "Please Enter The Number\n"
sum: .asciiz "The Summation of the array greater than input\n"
sum_Even: .asciiz "The Summation of Even Numbers in the Array\n"
sum_Odd: .asciiz "The Summation of Odd Numbers in the Array\n"
divcall:.asciiz "Enter the number for division.\n"
#################
menuOpt1: .asciiz"1.Find summation of numbers stored in the array which is greater than an input number.\n"
menuOpt1Msg1: .asciiz"Please enter the number as: \n"
sizeMessage: .asciiz"Enter the size of the array: \n"
devi: .asciiz"Numbers that can be devided by the input: \n"
menuOpt2: .asciiz"2.Find summation of even and odd numbers and display them.\n"
menuOpt3: .asciiz "3.Display the number of occurrences of the array elements divisible by a certain input number.\n"
menuOpt4: .asciiz "4.Quit.\n"
endl: .asciiz "\n"
coma: .asciiz ", "
inputint: .asciiz "Input: \n"
