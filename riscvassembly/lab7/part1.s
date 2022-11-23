.global _start
.text
_start:
	la s2, LIST
	addi s10, zero, 0
	addi s11, zero, 0

	addi s9, zero, -1

LOOP1:	lw t1, 0(s2)
		add s10, s10, t1
		addi s2, s2, 4
       	addi s11, s11, 1
        bne t1, s9, LOOP1

addi s10, s10, 1
addi s11, s11, -1

END:
	ebreak
.global LIST
.data
LIST:
.word 1, 2, 3, 5, 10, -1
