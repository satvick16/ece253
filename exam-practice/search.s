.data
LIST: .word 1, 2, 3, 5, -1

.text
.global _start

_start:
    la s0, LIST
    addi s1, zero, 6 # target value
    jal SEARCH_LIST

END:
	ebreak

SEARCH_LIST:
    addi s2, zero, -1 # end value

LOOP:
    lw s3, 0(s0) # current value
    beq s3, s1, FOUND
    beq s3, s2, NOT_FOUND
    addi s0, s0, 4
    j LOOP

FOUND:
    jr ra

NOT_FOUND:
    addi s0, zero -1
    jr ra
