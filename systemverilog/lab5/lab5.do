vlib work

vlog part3.sv


#vsim RateDivider
#
#log {/*}
#
#add wave {/*}
#
#force ClockIn 0,1 1 ns -r 2 ns
#
#force Speed 2'b00
#
#force Reset 1
#run 6ns
#
#force Reset 0
#
#run 60 ns



#vsim part2
#
#log {/*}
#
#add wave {/*}
#
#force ClockIn 0,1 1 ns -r 2 ns
#
#force Speed 2'b01
#
#force Reset 1
#run 6ns
#
#force Reset 0
#
#run 30ns


#vsim RateDivider
#
#log {/*}
#
#add wave {/*}
#
#force ClockIn 0,1 1000000 ns -r 2000000 ns
#
#
#force Reset 1
#run 6000000ns
#
#force Reset 0
#
#run 3000000000000 ns

vsim part3

force ClockIn 0,1 1000000 ns -r 2000000 ns


force Reset 1
run 6000000ns

force Reset 0

force Letter 3'b000
force Start 1
run 3000000ns

force Start 0
run 3000000ms

