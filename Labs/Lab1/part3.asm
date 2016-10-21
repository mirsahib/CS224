	.text		
.globl __start
 
__start:	
	#t1=x, $t2=y , $t3=z $t4=y*z $t5=result
	li $t1,0
	li $t2,0
	li $t3,0
	li $t4,0
	li $t5,0
	
	la $a0,x
	li $v0,4 
	syscall
	li $v0,5 #reading integers
	syscall
	move $t1,$v0 #t1=readed integer
	
	la $a0,y
	li $v0,4 
	syscall
	li $v0,5 #reading integers
	syscall
	move $t2,$v0 #t1=readed integer
	
	la $a0,z
	li $v0,4 
	syscall
	li $v0,5 #reading integers
	syscall
	move $t3,$v0 #t1=readed integer
	
	mul $t4,$t2,$t3
	sub $t5,$t1,$t4
	
	la $a0,result
	li $v0,4 
	syscall
	la $a0,($t5)
	li $v0,1 
	syscall
	
	
	.data
x: .asciiz "value of x: \n"
y: .asciiz "value of y: \n"
z: .asciiz "value of z: \n"
result: .asciiz "result is: "
endl: .asciiz "\n"