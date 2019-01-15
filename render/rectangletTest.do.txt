# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog rectangletTest.v rectangle.v

#load simulation using mux as the top level simulation module
vsim rectangleTop

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave -radix unsigned {/*}
add wave -radix unsigned -group data rectangleTop/dp/* 


force clck 0 0ns, 1 {1ns} -r 2ns

#init
force x0 8'b0
force y0 7'b0
force width 8'b0
force height 7'b0
force reset 0
force go 0
force RGB 0
run 10ns

#reset
force reset 1
run 2ns
force reset 0
run 2ns

#draw square 4x4 white
force x0 8'd0
force y0 7'd0
force width 8'd3
force height 7'd3
force RGB 3'b111 
run 100ns

force go 1
run 10ns
force go 0
run 100ns