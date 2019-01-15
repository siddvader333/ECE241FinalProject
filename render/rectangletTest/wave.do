onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /rectangleTop/x0
add wave -noupdate -radix unsigned /rectangleTop/y0
add wave -noupdate -radix unsigned /rectangleTop/width
add wave -noupdate -radix unsigned /rectangleTop/height
add wave -noupdate /rectangleTop/RGB
add wave -noupdate /rectangleTop/clck
add wave -noupdate /rectangleTop/reset
add wave -noupdate /rectangleTop/go
add wave -noupdate /rectangleTop/xOut
add wave -noupdate /rectangleTop/yOut
add wave -noupdate /rectangleTop/plotEnable
add wave -noupdate /rectangleTop/colorOut
add wave -noupdate /rectangleTop/x_en
add wave -noupdate /rectangleTop/y_en
add wave -noupdate /rectangleTop/init
add wave -noupdate /rectangleTop/y_sel
add wave -noupdate -radix unsigned /rectangleTop/x_sel
add wave -noupdate /rectangleTop/x_done
add wave -noupdate /rectangleTop/y_done
add wave -noupdate /rectangleTop/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {117581 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {101940 ps} {130290 ps}
