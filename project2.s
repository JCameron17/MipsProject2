.data
#variable for user input
#based on ID num @02839468
myString: .space 1001
invalid: .asciiz "Invalid input"
line: .asciiz "\n"
val1: .word 1     #30^0
val2: .word 30    #30^1
val3: .word 900   #30^2
val4: .word 27000 #30^3

.text
main:

 addi $t6, $zero, 1
 addi $t7, $zero, 30
 addi $t8, $zero, 900
 addi $t9, $zero, 29000


 li $v0, 8           #get user input
 la $a0, myString    #store string
 li $a1, 1001
 syscall

#move input to prepare for conversions
fixInput:
  la $s2, myString    #store input in $s2
 	add $s2, $s2, $t1   #increment
 	lb $s1, ($s2)       #load character
  beq $s1, 0, endLoop
 	beq $s1, 9, remove    #remove tab
 	beq $s1, 32, remove   #remove space
 	move $s3, $t1
 	j chooseLoop


fixIn2:
  li $s4, -1
  la $s2, myString
  add $s1, ($s2)
  bge $s5, 5, printInv  #if more than 4 char print invalid


printInv:
  li $v0, 4
  la $a0, line
  syscall

  li $v0, 4
  la $a0, invalid


chooseLoop:
     bge $t1, 5, endLoop  #if 5 characters are looped then jump to end loop
     lb $t0, 0($s2)      #place first char of string into $t0
     ble $t0, 47, outofrangeLoop   #if special character run out of range loop
     ble $t0, 57, numLoop          #if digits 0-9 run numLoop
     ble $t0, 90, upperLoop        #if uppercase letter run upperLoop
     ble $t0, 122, lowerLoop       #if lowercase letter run lowercase loop


numLoop:
 sub $t0, $t0, 48         #subtract 48 from $t0 value to convert from hexadecimal to decimal value
 beq $t1, 1, multFirst    #if it's the first character jump to multFirst
 beq $t1, 2, multSecond   #if it's the second character jump to multFirst
 beq $t1, 3, multThird    #if it's the third character jump to multFirst
 beq $t1, 4, multFourth   #if it's the fourth character jump to multFirst

lowerLoop:
  blt $t0, 97, outofrangeLoop     #special characters will be considered out of range
  bgt $t0, 117, outofrangeLoop    #u is the last char accepted in the alphabet
  beq $t1, 1, multFirst    #if it's the first character jump to multFirst
  beq $t1, 2, multSecond   #if it's the second character jump to multFirst
  beq $t1, 3, multThird    #if it's the third character jump to multFirst
  beq $t1, 4, multFourth   #if it's the fourth character jump to multFirst

 upperLoop:
   blt $t0, 65, outofrangeLoop     #special characters will be considered out of range
   bgt $t0, 85, outofrangeLoop     #U is the last char accepted in the alphabet
   beq $t1, 1, multFirst    #if it's the first character jump to multFirst
   beq $t1, 2, multSecond   #if it's the second character jump to multFirst
   beq $t1, 3, multThird    #if it's the third character jump to multFirst
   beq $t1, 4, multFourth   #if it's the fourth character jump to multFirst


 outofrangeLoop:
 sub $s3, $t0, $t0                #subtract value of register from itself
 add $s0, $s0, $s3                #compute the sum
 addi $t1, $t1, 1                  #increment loop
 addi $s2, $s2, 1                  #increment through string

    multFirst:
      mult $t0, $t6     #multiply character by 1
      mflo $t4
      #mflo $t5
      j Sum

    multSecond:
      mult $t0, $t7     #multiply character by 30
      mflo $t4
      j Sum

    multThird:
      mult $t0, $t8     #multiply character by 900
      mflo $t4
      j Sum

    multFourth:
      mult $t0, $t9     #multiply character by 27000
      mflo $t4
      j Sum

    Sum:
      add $s0, $s0, $t4        #Compute the sum
      addi $t1,$t1,1           #increment loop
      addi $s2,$s2,1           #increment through string
      j chooseLoop             #return to top of loop



endLoop:
  la $a0, line
  li $v0, 4           #print new line
  syscall

  add $a0, $s0, $zero
  li $v0, 1           #print sum
  syscall

  li $v0, 10           #end program
  syscall

endAll:
  li $v0, 10
  syscall


  remove:
    addi $t1, $t1, 1
    j fixInput
