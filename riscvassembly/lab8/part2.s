.global _start
.text

_start:

	la s2, LIST
	lw s3, 0(s2) #Length of list
	addi s9, zero, 0#Counter 1
	
	addi s6, s3, -1
	
LOOP1:
	beq s9, s6, END
	sub s8, s6, s9
	addi s4, s2, 4 
	addi s9, s9, 1
	addi s7, zero, 0
	b LOOP2
	
LOOP2: 
	beq s7, s8, LOOP1
	addi a0, s4, 0
	jal SWAP
	addi s4, s4, 4
	addi s7, s7, 1
	j LOOP2
	
SWAP:
	addi a1, a0, 4
	lw a2, 0(a1)
	lw a3, 0(a0)
	ble a2, a3, SWAP_sub
	addi a0, zero, 0
	jr ra

SWAP_sub:
	sw a2, 0(a0)
	sw a3, 0(a1)
	addi a0, zero, 1
	jr ra
	
END:
	ebreak
	
.global LIST
.data
LIST:
.word 6, 10, 9, 8, 7, 6, 5