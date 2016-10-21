#Note: $v0 is a symbolic name used by the assember for $2.
#      $a0 is a symbolic name used by the assember for $4.

          .data

prompt_str:     .asciiz  "Please type a text string: "
prompt_ptr: .asciiz  "Please type a pattern string: "
print_yes:  .asciiz  "Yes, there is a match."
print_no:   .asciiz  "No, there is no match."
text_str:   .asciiz  "Text string : "
pattern_str:    .asciiz  "Pattern string : "
print_out:      .asciiz  "Output to be produced :"
print_dash:     .asciiz  "----------------------"
print_index:    .asciiz  "Starting index :"
print_msg :     .asciiz  "Length of longest partial match = "
nl:             .asciiz  "\n"
print_outer:    .asciiz  "please enter string"   

str :       .space  81
ptr :       .space  81
tmp :       .space  81
          .text



main:   la  $a0, prompt_str   
        li  $v0, 4          #print_string command.
        syscall

        la  $a0,str   #read string
    li  $a1,81
    li  $v0,8
    syscall

    la  $t0,str     #move string to $t0

    la  $a0,prompt_ptr
    li  $v0,4       #print pattern command
    syscall

    la  $a0,ptr     #read pattern
    li  $a1,81
    li  $v0,8
    syscall

    la  $t1,ptr     #move pattern to $t1    

    lb  $t2,0($t0)  #pointer first element array of string
    move    $t4,$t2     #address pointer of $t2
    lb  $t3,0($t1)  #pointer first element array of pattern

outer_loop :    beq $t2,$0,end_outer_loop
        j   inner_loop  

inner_loop :    beq $t2,$0,end_inner_loop
        beq $t3,$0,end_inner_loop
        beq $t2,$t3,end_inner_loop
        addiu   $t2,$t2,1
        addiu   $t3,$t3,1
        j   inner_loop

end_inner_loop :bne $t3,$0,inc_ptr
        j   print_match

inc_ptr :   add $t2,$t4,1   
        j   outer_loop

end_outer_loop :la  $a0,print_outer
        li  $v0,4
        syscall





print_match :   la  $a0,text_str    #print string
        li  $v0,4
        syscall
        move    $a0,$t0
        li  $v0,4
        syscall

        la  $a0,nl      #print newline character
        li  $v0,4
        syscall

        la  $a0,pattern_str #print pattern string
        li  $v0,4
        syscall
        move    $a0,$t1
        li  $v0,4
        syscall

        la  $a0,nl      #print newline character
        li  $v0,4
        syscall         

        la  $a0,print_out   #print output line and newline character
        li  $v0,4
        syscall
        la  $a0,nl
        li  $v0,4
        syscall

        la  $a0,print_dash
        li  $v0,4
        syscall
        la  $a0,print_yes
        li  $v0,4
        syscall
        la  $a0,print_index     #print starting index
        li  $v0,4
        syscall
        li  $v0,10
        syscall

end_loop :  li  $v0,10
        syscall