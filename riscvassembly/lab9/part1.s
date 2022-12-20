.global _start

_start:
	li s0, 0xffff0004 # receiver data
	li s1, 0xffff0000 # receiver control
	
	li s2, 0xffff0008 # transmitter control
	li s3, 0xffff000c # transmitter data

POLL_REC:
	lw s4, 0(s1) # read receiver control
	beqz s4, POLL_REC

	lw s5, 0(s0) # read receiver data

POLL_TRA:
	lw s6, 0(s2) # read transmitter control
	beqz s6, POLL_TRA

	sw s5, 0(s3) # write transmitter data
	
	j POLL_REC
