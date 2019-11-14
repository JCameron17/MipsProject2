.data
#variable for user input
#based on ID num @02839468
myString: .space 1000
invalid: .asciiz "Invalid "
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
 addi $t9, $zero, 27000


 li $v0, 8           #get user input
 la $a0, myString    #store string
 li $a1, 1001
 syscall

 move $s2, $a0
 move $t1, $zero

chooseLoop:
     bge $t1, 5, endLoop  #if 5 characters are looped then jump to end loop
     lb $t0, 0($s2)      #place first char of string into $t0
     ble $t0, 47, outofrangeLoop   #if special character run out of range loop
     ble $t0, 57, numLoop          #if digits 0-9 run numLoop
     ble $t0, 90, upperLoop        #if uppercase letter run upperLoop
     ble $t0, 122, lowerLoop       #if lowercase letter run lowercase loop

removeSpace:
  slti $t2, $s1, 33
  bne $t1, $zero, remove

remove:
  add $t3, $s0, $a0
  sb $0, 0($t3)
  syscall

numLoop:
 sub $t0, $t0, 48         #subtract 48 from $t0 value to convert from hexadecimal to decimal value
 bge $t1, 1, multFirst    #if it's the first character jump to multFirst
 bge $t1, 2, multSecond    #if it's the first character jump to multFirst
 bge $t1, 3, multThird    #if it's the first character jump to multFirst
 bge $t1, 4, multFourth    #if it's the first character jump to multFirst


 Sum:
 add $s0, $s0, $t0        #Compute the sum
 addi $t1,$t1,1           #increment loop
 addi $s2,$s2,1           #increment through string
 j chooseLoop             #return to top of loop

multFirst:
  mult $t0, val1     #multiply character by 1
  mfhi $t4
  mfhi $t5
  j Sum

multSecond:
  mult $t0, val2     #multiply character by 30
  mfhi $t4
  mfhi $t5
  j Sum

multThird:
  mult $t0, val3     #multiply character by 900
  mfhi $t4
  mfhi $t5
  j Sum

multFourth:
  mult $t0, val4     #multiply character by 27000
  mfhi $t4
  mfhi $t5
  j Sum

lowerLoop:
 blt $t0, 97, outofrangeLoop     #special characters will be considered out of range
 bgt $t0, 117, outofrangeLoop    #u is the last char accepted in the alphabet
 sub $t0, $t0, 87                #subtract 87 from $t0 value to convert from hexadecimal to decimal valu
 add $s0, $s0, $t0               #Compute the sum
 addi $t1,$t1,1                  #increment loop
 addi $s2,$s2,1
 j chooseLoop


upperLoop:
  blt $t0, 65, outofrangeLoop     #special characters will be considered out of range
  bgt $t0, 85, outofrangeLoop     #U is the last char accepted in the alphabet
  sub $t0, $t0, 55                #subtract 55 from $t0 value to convert from hex to decimal
  add $s0, $s0, $t0               #Compute the sum
  addi $t1,$t1,1                  #increment loop
  addi $s2,$s2,1                  #increment through string
  j chooseLoop



outofrangeLoop:
sub $s3, $t0, $t0                #subtract value of register from itself
add $s0, $s0, $s3                #compute the sum
addi $t1, $t1, 1                  #increment loop
addi $s2, $s2, 1                  #increment through string


endLoop:
  la $a0, line
  li $v0, 4           #print new line
  syscall

  add $a0, $s0, $zero
  li $v0, 1           #print sum
  syscall

  li $v0, 10           #end program
  syscall
