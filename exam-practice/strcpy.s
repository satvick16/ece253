.data
SRC: .word 1, 2, 3, 6, -1
DST: .word 0, 0, 0, 0, 0

.text
.global _start

_start:
    la s0, SRC
    la s1, DST

    addi s2, zero, -1
    
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

LOOP:
    lw t1, 0(s0)
    beq t1, s2, END
    sw t1, 0(s1)

    addi s0, s0, 4
    addi s1, s1, 4

    j LOOP

END:
	lw s0, 0(sp)
	lw s1, 4(sp)
	addi sp, sp, 8
	
	ebreak
