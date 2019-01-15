# set the working dir, where all compiled verilog goes
vlib render

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog render.v rectangleTest.v rectangle.v drawCtrlTest.v drawCtrl.v

#load simulation using mux as the top level simulation module
vsim render

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave -radix unsigned {/*}


force clock 0 0ns, 1 {1ns} -r 2ns

#init
force y_g 7'b0
force y_r 7'b0
force x_ball 7'd0
force y_ball 7'd0
force reset 0
force valid 0
run 10ns

#reset
force reset 1
run 2ns
force reset 0
run 2ns

#draw one set of 
force y_g 7'd5
force y_r 7'd20
force x_ball 7'd100
force y_ball 7'd100
force valid 1
run 2ns
force valid 0 
run 2ns

run 100ns