# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

force ClockIn 0,1 1ms -r 2ms

force {Start} 1'b0
force {Reset} 1'b1
force {Letter} 3'b000
run 8ms

force {Start} 1'b0
force {Reset} 1'b0
force {Letter} 3'b000
run 40ms

force {Start} 1'b1
force {Reset} 1'b0
force {Letter} 3'b000
run 2ms

force {Start} 1'b0
force {Reset} 1'b0
force {Letter} 3'b000
run 5980ms

force {Start} 1'b0
force {Reset} 1'b1
force {Letter} 3'b001
run 6ms

force {Start} 1'b0
force {Reset} 1'b0
force {Letter} 3'b001
run 40ms

force {Start} 1'b1
force {Reset} 1'b0
force {Letter} 3'b001
run 2ms

force {Start} 1'b0
force {Reset} 1'b0
force {Letter} 3'b001
run 7000ms












