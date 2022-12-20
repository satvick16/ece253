.data
LIST: .word 1, 2, 3, 5, -1

.text
.global _start

_start:
	addi a0, zero, 9 # a
	addi a1, zero, 2 # b

F:
	add a2, zero, a0 # j
	jal G
	add a3, a0, a1
	add a0, a2, a3

END:
	ebreak

G:
	bnez a1, PUSH
	jr ra

PUSH:
	addi sp, sp, -8
	sw a1, 4(sp)
	sw ra, 0(sp)
	
	addi a1, a1, -1
	jal G

EEE:
	lw t0, 4(sp)
	lw ra, 0(sp)
	addi sp, sp, 8
	addi s3, zero, 3
	add a1, a1, s3
	jr ra