
//data path
module rectangleData(input [7:0]x0, 
							input[6:0]y0, 
							input[6:0]height, 
							input[7:0]width, 
							input[2:0]RGB,

							input x_en, 
							input[2:0]x_sel, 
							input y_en, 
							input y_sel, 
							input init, 
							input clk, 
							input reset,

							output x_done, 
							output y_done, 
							output reg [7:0]x, 
							output reg [6:0]y, 
							output reg [2:0]colorOut);
							
reg [7:0]x_last;
reg [6:0]y_last;
reg [7:0]x0_r;

	always @ (posedge clk) begin
		if (init) begin
			x0_r <= x0;
			x_last <= x0 + width - 8'd1;
			y_last <= y0 + height - 7'd1;
			colorOut <= RGB;
		end
		
		if (x_en) begin
			case (x_sel)
				2'd0: x <= x0;
				2'd1: x <= x + 1;
				2'd2: x <= x0_r;
			endcase
		end
		
		if(y_en)begin
			case (y_sel)
				1'd0: y <= y0;
				1'd1: y <= y+1;
			endcase
		end

		//if(x_done && y_done) done <= 1'b1;
		
	end
	
	assign x_done = (x == x_last);
	assign y_done = (y == y_last);


	endmodule
	
	
module rectangleCtrl
(
	input clk,
	input reset,
	
	input go,
	output reg done,
	
	output reg init,
	output reg x_en,
	output reg [2:0] x_sel,
	output reg y_en,
	output reg y_sel,
	input x_done,
	input y_done,
	
	output reg plot
);	

//state registers

reg [2:0] nextstate, state;
	
	localparam 		  S_IDLE = 3'd0,
				  S_DRAW = 3'd1,
				  S_INC_Y = 3'd2;
				 
	
	
	always @ (posedge clk or posedge reset) begin
		if (reset) state <= S_IDLE;
		else state <= nextstate;
	end
	
	
	always@(*) begin
	//default enables
		nextstate = state;
		done = 1'b0;
		init = 1'b0;
		x_en = 1'b0;
		y_en = 1'b0;
		x_sel = 2'b00;
		y_sel = 1'b0;
		plot = 1'b0;
		
		case (state)
			S_IDLE: begin
				init = 1'b1;
				x_en = 1'b1;
				y_en = 1'b1;
				x_sel = 2'd0;
				y_sel = 1'b0;
				if (go) begin
					nextstate = S_DRAW;
				end
			end
			
			S_DRAW: begin
				plot = 1'b1;
				x_en = 1'b1;
				x_sel = 2'd1;
				if (x_done) begin
					x_sel = 2'd2;
					nextstate = S_INC_Y;
				end
			
			end
			
			S_INC_Y: begin
				y_en = 1'b1;
				y_sel = 1'b1;
				if (y_done) begin
					done = 1'b1;
					nextstate = S_IDLE;
				end
				else begin
					nextstate = S_DRAW;
				end
				
			end
		endcase
		
	end
endmodule