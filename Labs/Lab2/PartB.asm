	.data
codeprm: .asciiz" enter the code \n"
originalprm:.asciiz" enter the original \n"
inputprm:.asciiz"enter the text to convert \n"
code :       .space  128	
input :       .space  128
original:	.space  128
n: .asciiz "\n"
.text
main:
 	#Print for input string 
	la  $a0,originalprm
        li  $v0, 4          #print_string command.
        syscall
        #read for string input
        #read for string original input
 	li $v0,8 #take in input by system command
        la $a0, original #load byte space into address buffer 
        li $a1, 128 # allocate the byte space for string
        move $t0,$a0 #save string original to t0
        syscall
       
         #Print for input string 
	la  $a0, codeprm  
        li  $v0, 4          #print_string command.
        syscall
        #read for string input
       	#read for string code input
        li $v0,8 #take in input by system command
        la $a0, code #load byte space into address ptr
        li $a1, 128 # allocate the byte space for string
        move $t1,$a0 #save pattern to t1
        syscall
       
        #Print for input string 
	la  $a0, inputprm   
        li  $v0, 4          #print_string command.
        syscall
        #read for string input 
        #read the pattern input
        li $v0,8 #take in input by system command
        la $a0, input #load byte space into address ptr
        li $a1, 128 # allocate the byte space for string
        move $t2,$a0 #save pattern to t2
        syscall

	
	lb $t8,($t0)#origin
	lb $t9,($t1)#code
	lb $t7,($t2) #text
translate:
	move $t3,$zero
	bne $t7,10,check	
search:
	lb $t6,($t0)
	iterate:
		beq $t6,$t7,found
		addi $t6,$t6,1
		addi $t3,$t3,1
		bne $t6,$zero,notfound
		j iterate
			
notfound:
	#iterate t7
found:
	#swap	
# t0-->original t8,t6
# t1-->code t9
# t2-->text t7  
# t3 count of what position in array