.data
#variable for user input
#based on ID num @02839468
myString: .space 1000
invalid: .asciiz "Invalid "
line: .asciiz "\n"

.text
main:

    li $v0, 8           #get user input
    la $a0, myString    #store string
    li $a1, 1001
    syscall

    move $s2, $a0

    lb $t0, 0($s2)      #place first char of string into $t0
    li $v0, 4           #print chars iteratively
    syscall


    chooseLoop:
        bge $t1, 11, endLoop
        lb $t0, 0($s2)
        ble $t0, 47, outofrangeLoop
        ble $t0, 57, numLoop
        ble $t0, 90, upperLoop
        ble $t0, 122, lowerLoop


    numLoop:
        sub $t0, $t0, 48
        add $s0, $s0, $t0   #Compute the sum

        addi $t1,$t1,1
        addi $s2,$s2,1
        j chooseLoop


    lowerLoop:
      blt $t0, 97, outofrangeLoop
      bgt $t0, 117, outofrangeLoop
      sub $t0, $t0, 87
      add $s0, $s0, $t0   #Compute the sum

      addi $t1,$t1,1
      addi $s2,$s2,1
      j chooseLoop


       upperLoop:
           blt $t0, 65, outofrangeLoop
           bgt $t0, 85, outofrangeLoop
           sub $t0, $t0, 55
           add $s0, $s0, $t0   #Compute the sum

           addi $t1,$t1,1
           addi $s2,$s2,1
           j chooseLoop



      outofrangeLoop:
          sub $s3, $t0, $t0
          add $s0, $s0, $s3

          addi $t1,$t1,1
          addi $s2,$s2,1
          j chooseLoop

      endLoop:
          la $a0, line
          li $v0, 4
          syscall

          add $a0, $s0, $zero
          li $v0, 1
          syscall

          li $v0, 10
          syscall
