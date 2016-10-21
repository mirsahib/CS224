

#Q1)
#Creates an array of maximum size of 100 elements that asks the user enter the elements one by one. 
#Displays array contents
#Reverses the array contents and display the array (for example 1, 2, 3 becomes 3, 2, 1).
	
	.text 
	.globl __start
	
	
__start:
	
	lw $s0,arrSize # so=array size setted as 100 
	la $s1,arr #pointing to the array
	li $t2,0 #number of elements in the array
	
loo:
	la $a0,string1 #promting the system message
	li $v0,4 
	syscall
	########
	li $v0,5 #reading integers
	syscall
	move $t1,$v0 #t1=readed integer
	########
	sw $t1,($s1) #write the readed value which is currently in $t0 to $s1
	add $s1,$s1,4 # write to the current s1 pointer
	add $t2,$t2,1# numofElements++
	bne $t2,$s0,loo # until we finished t2=s0 the loo which is reading and allocating the values to the array 
	#s1 will be point to the last element of the arr at the end of the array
	########
	la $a0,string2#promt string2
	li $v0,4
	syscall 
		########
	la  $s1, arr # resetting the pointer to the s1
looReverse:
	la $a0,endl#promt the string3
	li $v0,4
	syscall
	########	
	lw $t1,($s1)
	move $a0,$t1
	#li $v0,1;                                
	#syscall
	
	add $s1,$s1,4 #iteration all along the array
	sub $t2,$t2,1 # t2 shold be equal to the size of the array at the and of the loo,
	bne $t2,0,looReverse #looping untill the register t2 is equal to 0
	
	la $a0,string3
	li $v0,4
	syscall
	
	sub $t1, $s0,1 #the address of the last element is (arrSize-1)*4+address of the arr ($s1)
	mul $t1,$t1,4
	la $s1,arr
	add $s1,$s1,$t1
loo2:
	la $a0,endl
	li $v0,4
	syscall #print

 	lw $t1, ($s1)
	move $a0,$t1
	li $v0,2
	syscall
	
	sub $s1,$s1,4
	add $t2,$t2,1
	bne $t2,$s0,loo2 #when t2 is equal to 0 ,loop over
	
done: 	li $v0,10 #exit 
	syscall
	
.data
	arr: .space 40 #(int=8 byte -- 800 for 100 sized int array)
	arrSize: .word 5
	endl : .asciiz "\n"
	string1: .asciiz "enter the int"
	string2: .asciiz "the array"
	string3: .asciiz "the array in reverse order"
	



	
	 
	 
	
	 
	 
	
















