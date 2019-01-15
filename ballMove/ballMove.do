# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog ballMoveTest.v ballMove.v 

#load simulation using mux as the top level simulation module
vsim ballMoveTop

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave -radix unsigned {/*}
add wave -radix unsigned -group data ballMoveTop/ballDp/* 
add wave -radix unsigned -group control ballMoveTop/ballCp/* 

force clock 0 0ns, 1 {1ns} -r 2ns


#defaults
force startGame 0
force reset 0
force y_g 7'd0
force y_r 7'd0
force valid 0

run 20ns

#reset
force reset 1
run 10ns
force reset 0 
run 10ns

#startGame
force y_g 7'd50
force y_r 7'd30
force startGame 1
run 20ns

force startGame 0

force valid 1
run 20ns

force valid 0

#valid
run 300 ns