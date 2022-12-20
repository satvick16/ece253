.data

# Messages
msg_1: .asciz "Please take a deep breath      \n"
msg_2: .asciz "Please drink some water        \n"
msg_3: .asciz "Please give your eyes a break  \n"

# Timer Related
timeNow: .word 0xFFFF0018 # current time
cmp: .word 0xFFFF0020 # time for new interrupt

.text

# Display Related
.eqv OUT_CTRL 0xffff0008
.eqv OUT 0xffff000C

main:
	
	# Set the handler address and enable interrupts
	la t0, timer_handler
	csrrw zero, utvec, t0
	csrrsi zero, ustatus, 0x1
	csrrsi zero, uie, 0x10
	
	# Loop over the messages
	addi s11, zero, 1 # number of current message
	addi s7, zero, 0 # current message
	
	addi s10, zero, 1 # constant
	addi s9, zero, 2 # constant
	addi s8, zero, 3 # constant
	
	addi s3, zero, 32
	addi a0, zero, 0
	
	# Set time to trigger interrupt to be 5000 milliseconds (5 seconds)
	li s0, 0xFFFF0020
	li s1, 5000
	sw s1, 0(s0)
	li t6, 0xFFFF0018
	sw zero, 0(t6)

LOOP:
	addi s2, zero, 0
	addi a3, zero, 1
	beq a0, s10, CHECK_1
	j LOOP

	
CHECK_1:
	bne s11, s10, CHECK_2
	beq a3, s10, LOAD1
	addi a1, zero, 2
	j DISP

CHECK_2:
	bne s11, s9, CHECK_3
	beq a3, s10, LOAD2
	addi a1, zero, 3
	j DISP

CHECK_3:
	beq a3, s10, LOAD3
	addi a1, zero, 1
	j DISP

	# Print message to ASCII display
DISP:
	lw s6, OUT_CTRL # read transmitter control
	beqz s6, DISP
	beq s2, s3, Return
	
	lb s5, 0(s7)
	addi s7, s7, 1
	
	li s4, OUT
	sw s5, 0(s4) # write transmitter data
	addi s2, s2, 1
	
	j CHECK_1

Return:
	addi s11, a1, 0
	addi a0, zero, 0
	j LOOP

LOAD1:
	la s7, msg_1
	addi a3, zero, 3
	j CHECK_1
LOAD2:
	la s7, msg_2
	addi a3, zero, 3
	j CHECK_2
LOAD3:
	la s7, msg_3
	addi a3, zero, 3
	j CHECK_3
	
timer_handler:
	addi a0, zero, 1
	# Indicate that 5 seconds have passed
	li a5, 0xFFFF0018
	lw a4, 0(a5)
	li s0, 0xFFFF0020
	li s1, 5000
	add s1, s1, a4
	sw s1, 0(s0)
	
	uret
