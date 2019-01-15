
module dataPath(resetN, clock, outEnable, ld_x, ld_y, ld_c, data_x, data_y, data_R, data_G, data_B, x_out, y_out, R_out, G_out, B_out, go, newFrame);
input resetN, clock, ld_x, ld_y, ld_c, outEnable;
input [10:0] data_x;
input [10:0] data_y;
input [9:0] data_R;
input [9:0] data_G;
input [9:0] data_B;

output reg [10:0] x_out;
output reg [10:0] y_out;
output reg [9:0] R_out;
output reg [9:0] G_out;
output reg [9:0] B_out;

output reg go;
output reg newFrame;


//input registers

reg [10:0] x;
reg [10:0] y;
reg [9:0] R, G, B;

//registers with respective input logic
always@(posedge clock) begin
	if(!resetN) //reset all registers
		begin
			x <= 11'b0;
			y <= 11'b0;
			R <= 10'b0;
			G <= 10'b0;
			B <= 10'b0;
		end// end if 
		
	else
		begin
		//pixel found -> write to registers
		if(ld_x)
			x <= data_x;
		
		if(ld_y)
			y <= data_y;
			
		if(ld_c)
				begin
				 R <= data_R;
				 G <= data_G;
				 B <= data_B;
				end
		//output
		if(outEnable)
			begin
			x_out <= x;
			y_out <= y;
			R_out <= R;
			G_out <= G;
			B_out <= B;
			end
			
		//check pixel colour and output go		
		if(data_R >8'd255 && data_G < 8'd50 && data_B == 8'd50)		
				go <= 1'b1;				
		
		//newFrame reached --> if x and y are 0
		if(data_x == 11'b0 && data_y == 11'b0)
			newFrame <= 1'b1;
			
		end//end else
		
end// always		
	

endmodule//dataPath