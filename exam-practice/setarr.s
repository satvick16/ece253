.data
LIST: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.global _start

_start:
	addi s0, zero, 3 # num
	addi s4, zero, 0 # i
	addi s5, zero, 10 # 10
	la s6, LIST

LOOP:
	bge s4, s5, END
	
	jal COMPARE
	
	sw a0, 0(s6)
	
	addi s4, s4, 1
	addi s6, s6, 4
	j LOOP

COMPARE:
	sub a1, s0, s4
	bgez a1, ONE
	addi a0, zero 0
	jr ra

ONE:
	addi a0, zero, 1
	jr ra

END:
	ebreak