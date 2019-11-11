.data
#variable for user input
myString: .space 1000
line: .asciiz "\n"

.text
main:

    li $v0, 1000           #get user input
    la $a0, myString    #store string
    li $a1, 1001
    syscall
