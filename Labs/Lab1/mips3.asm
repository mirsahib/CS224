

#Q3)
#Write a MIPS program that 
#Implements the following expression without using div. If necessary use instructions other that we have seen in the class.x= (c - d) % 2
	
	.text
	.globl __start
__start:
	
	la $s0, message,
	li $v0,4
	syscall #printing first message
	
	li $v0,5
	syscall #reading
	move $t0,$v0 #the value which is taken form the user as c
	
	la $a0, message2
	li $v0,4
	syscall#printing second message
	
	li $v0,5
	syscall #reading
	move $t1,$v0 #the value which is taken form the user as d
	
	slt $t4,$t0,$t1 #c<d ? t4=1
	beq $t4,1,great
	sub, $t2,$t0,$t1 #reg t2=c-d
	j while
great:
	sub $t2,$t1,$t0
	#the step of c-d as an devision parts
loop:
	beq $t2,0,Case_lo#if
	beg $t2,1,Case_hi#if
	
	sub $t2,$t2,2
	j loop
Case_lo:
	la $a0,lo
	li $v0,4#print
	syscall
	j terminate
Case_hi:	
	la $a0,hi
	li $v0,4 #print
	syscall
terminate:
	li $v0,10
	syscall#exit
	.data
message: .asciiz "\n Enter the value of the C"
message2: .asciiz "\n Enter the value of the D"
lo: .asciiz "The result is 0"
hi: .asciiz "The result is 1"


#Part4
#Generate the object code (in hex) for the following la instructions. Show your work for the #intermediate steps (please remember that la is a pseudo instruction and implemented by #two instructions).
#0x3C 01 10 01
#0x34 29 00 14
#0x3C 01 10 01
#0x34 2A 00 24

