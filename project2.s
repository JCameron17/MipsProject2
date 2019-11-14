.data
#variable for user input
#based on ID num @02839468
myString: .space 1000
invalid: .asciiz "Invalid "
line: .asciiz "\n"
val2: .word 30
val3: .word 90
val4: .word 27000

.text
main:

li $v0, 8           #get user input
 la $a0, myString    #store string
 li $a1, 1001
 syscall

 move $s2, $a0
 move $t1, $zero

chooseLoop:
     bge $t1, 5, endLoop  #if 11 characters are looped then jump to end loop
     lb $t0, 0($s2)      #place first char of string into $t0
     ble $t0, 47, outofrangeLoop   #if special character run out of range loop
     ble $t0, 57, numLoop          #if digits 0-9 run numLoop
     ble $t0, 90, upperLoop        #if uppercase letter run upperLoop
     ble $t0, 122, lowerLoop       #if lowercase letter run lowercase loop

numLoop:
 sub $t0, $t0, 48         #subtract 48 from $t0 value to convert from hexadecimal to decimal value
 add $s0, $s0, $t0        #Compute the sum
 addi $t1,$t1,1           #increment loop
 addi $s2,$s2,1           #increment through string
 j chooseLoop               #return to top of loop


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
