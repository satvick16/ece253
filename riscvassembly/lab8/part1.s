.global _start
.text

_start:

	#First, consider what the inner loop should do:
	
	la s2, LIST
	addi a0, zero, 0
	addi s9, zero, -1
	addi s10, zero, 0
	
	lw a1, 0(s2)
	
LOOP1: 	beq a1, s9, END
	jal ONES
	addi s2, s2, 4
	lw a1, 0(s2)
	j LOOP1

ONES:
	sub a2, a2, a2
	sub a0, a0, a0
	addi a2, zero, 0
	addi a0, zero, 0
	
LOOP2:
	beqz a1, ENDLOOP
	srli a2, a1, 1
	and a1, a1, a2
	addi a0, a0, 1
	b LOOP2
	
ENDLOOP:
	bge a0, s10, SWAP
	jr ra

SWAP:
	sub s10, s10, s10
	addi s10, a0, 0
	jr ra
END:
	ebreak
	
.global LIST
.data
LIST:
.word 0xf03, 0xff3, 0x191, -1
