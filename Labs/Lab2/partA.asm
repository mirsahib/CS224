	.data

prompt_str:     .asciiz  "Please type a text string: "
prompt_ptr: .asciiz  "Please type a pattern string: "
ptr_yes: .asciiz "The string contains : "
text_str:   .asciiz  "Text string : "
pattern_str:    .asciiz  "Pattern string : "
pattern_lenght: .asciiz  "Pattern has the lenght of "
print_dash:     .asciiz  "----------------------"   
empty: .asciiz "Your pattern is empty. "
#string portion
ptr :       .space  128	
tmp :       .space  128
buffer:	    .space  128
n: .asciiz "\n"
pattern: .asciiz " patterns"	
invalid: .asciiz "invalid input. \n"	
	
	.text


#Note: $v0 is a symbolic name used by the assember for $2.
#      $a0 is a symbolic name used by the assember for $4.
# t0--->string
# t1--->pattern
# t2--->pattern lenght
# t7---> pointer to pattern
# t8---> char pointer pattern
# t9---> pointer to the string
# t6---> char pointer string 
# t5---> t5 compare string pointer .
# t4---> foundedr
# t3---> temp 
main:   
	#Print for input string 
	la  $a0, prompt_str   
        li  $v0, 4          #print_string command.
        syscall
        #read for string input
 	li $v0,8 #take in input by system command
        la $a0, buffer #load byte space into address buffer 
        li $a1, 128 # allocate the byte space for string
        move $t0,$a0 #save string to t0
        syscall
        #Print for input string 
	la  $a0, prompt_ptr   
        li  $v0, 4          #print_string command.
        syscall
        #read the pattern input
        li $v0,8 #take in input by system command
        la $a0, ptr #load byte space into address ptr
        li $a1, 128 # allocate the byte space for string
        move $t1,$a0 #save pattern to t1
        syscall
	
	la $t9,($t0) # t9 points top of the string
	la $t7,($t1) # t7 points top of the pattern
	lb $t8,($t7)
	move $t2,$zero
	 
	
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
pattern_Lenght:
	loop:
	lb $t8,($t7)
	beq $t8,10,promt_EmptyMssg
	beq $t8,0,promt_EmptyMssg
	addi $t2,$t2,1
	addi $t7,$t7,1
	j loop	
promt_EmptyMssg:
	la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
	la  $a0,invalid
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
       
	
        
        la $t7,($t1)
	lb $t8,($t7)
	la $t6,($t0)
	lb $t5,($t0)
	
p_recog:
	# We need to check as pattern length  
	# t9 untouched at this point
	
	#la  $t5,($t6)
	
	
	bne $t8,$t5,end_recog_fail
	
check: 
	lb $t8,($t7)
	lb $t5,($t9)
	bne $t8,$t5,end_recog_fail # optimization
	
	addi $t7,$t7,1
	addi $t9,$t9,1
	lb $t8,($t7)
	lb $t5,($t9)
		
	beq $t8,10,done
	#bne $t5,$t8,end_recog
	j check

end_recog_fail:
	addi $t9,$t9,1
	move $t6,$t9
	lb $t5,($t6)
	beq $t5,10,exit
	lb $t8,($t7)
	move $t7,$t1
	j p_recog
end_recog:
	la $t3,($t2)
	j increment 
done: 
	addi $t4,$t4,1 
	move $t7,$t1
	lb $t8,($t7)
	beq $t5,10,exit
	j p_recog
increment:
	addi $t6,$t6,1
	subi $t3,$t3,1
	beq  $t3,0,p_recog
	b increment
	#increment the string pointer by pattern size
	#increment the string pointer by 1	
exit:
	la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
	la  $a0,text_str
        li  $v0, 4 #print_str command.
        syscall
       	la  $a0,($t0)
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
        
    
        la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,pattern_str
        li  $v0, 4 #print_str command.
        syscall
       	la  $a0,($t1)
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
	
	la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
	la  $a0,pattern_lenght
        li  $v0, 4 #print_str command.
        syscall
	la  $a0,($t2)  
        li  $v0, 1 #print_strnt command.
        syscall
        la  $a0,n
        li  $v0, 4 #print_strt command.
        syscall
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
        
        la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
        
	la  $a0,ptr_yes
        li  $v0, 4 #print_int command.
        syscall
	la  $a0,($t4)  
        li  $v0, 1 #print_int command.
        syscall
        la  $a0,pattern
        li  $v0, 4 #print_int command.
        syscall
         la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,print_dash
        li  $v0, 4 #print_str command.
        syscall
        la  $a0,n
        li  $v0, 4 #print_str command.
        syscall
       
	li $v0,10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	