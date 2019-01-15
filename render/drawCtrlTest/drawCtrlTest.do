# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog drawCtrlTest.v drawCtrl.v

#load simulation using mux as the top level simulation module
vsim drawCtrlTest

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave -radix unsigned {/*} 

add wave -radix unsigned -group ctrl drawCtrlTest/cp/* 
add wave -radix unsigned -group data drawCtrlTest/dp/* 


force clock 0 0ns, 1 {1ns} -r 2ns

#defaults
force {y_g} 0
force {y_r} 0
force valid 1'b0
force done 1'b0
force startGame 0



#reset
force {reset} 1
run 2ns
force {reset} 0
run 2ns

#initializations
#in black state -> move to wait 1 -> green
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in green state -> move to wait 2 -> red
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in red state -> move to wait 3 -> scan
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in ball state -> move to wait 4 -> scan
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

run 1000ns

#make sure valid does nothing before startgame
force valid 1
run 12ns
force valid 0
run 1000ns

#startgame
force startGame 1
force y_g 7'd50
force y_r 7'd20
force x_ball 8'd20
force y_ball 7'd60
#in wait state -> move to black
force {valid} 1
run 2ns
force {valid} 0
run 2ns

#in black state -> move to wait 1 -> green
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in green state -> move to wait 2 -> red
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in red state -> move to wait 3 -> ball
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns

#in ball state -> move to wait 4 -> scan
run 100ns
force {done} 1
run 2ns
force {done} 0
run 2ns


#show scan
force {done} 0
run 200ns