
module controlPath(resetN, clock, go, newFrame, outEnable, ld_x, ld_y, ld_c);

input resetN, clock, go, newFrame;
output reg ld_x; 
output reg ld_y; 
output reg ld_c;
output reg outEnable;


//FSM data structure
 reg[2:0] current_state, next_state; //number of states = 3--> 2 bits 

 //defining states
 
 localparam
 
		S_NOT_FOUND = 3'd0,
		S_FOUND = 3'd1,
		S_CYCLE = 3'd2;
			


	//next state logic 
	
	always@(*) 
	begin: state_table
			
			case(current_state)
				S_NOT_FOUND: next_state = go ? S_FOUND : S_NOT_FOUND;
				
				S_FOUND: next_state = S_CYCLE;
				
				S_CYCLE: next_state = newFrame ? S_NOT_FOUND : S_CYCLE;
		
				default: next_state = S_NOT_FOUND;
			endcase
			
	end 


	//output logic
	
	always@(*)
	begin: enable_signals
	//default enable signals
	ld_x = 1'b0;
	ld_y = 1'b0;
	ld_c = 1'b0;
	outEnable = 1'b0;
	
		case(current_state)
			S_NOT_FOUND: 
					begin
					//do nothing
					end
					
			S_FOUND:
					begin
					ld_x = 1'b1;
					ld_y = 1'b1;
					ld_c = 1'b1;
					outEnable = 1'b1;
					end
					
			S_CYCLE: 
					begin
					ld_x = 1'b0;
					ld_y = 1'b0;
					ld_c = 1'b0;
					outEnable = 1;
					end
		
		endcase
		
	end	
		

		//current state registers
		always@(posedge clock)
			begin: state_FFs
					if(!resetN)
						begin
						current_state <= S_NOT_FOUND;
						end//end if
					
					else begin
						current_state <= next_state;
						end
			
			end
		
		

endmodule //controlPath




/*//data and control path registers and wires
wire newFrame, go, ld_x, ld_y, ld_c,outEnable; 
wire [9:0] redOut, greenOut, blueOut;
wire [10:0] xOut, yOut;


reg [10:0] xDisplay, yDisplay;
reg [9:0] redDisplay, greenDisplay,blueDisplay;



//control path instantiation

controlPath c1(
//inputs
.resetN(~KEY[1]),
.clock(CLOCK_50),
.go(go), 
.newFrame(newFrame),

//outputs
.ld_x(ld_x),
.ld_y(ld_y),
.ld_c(ld_c),
.outEnable(outEnable)
);



//data path instantiation

dataPath d1 (
//inputs
.resetN(KEY[1]),
.clock(CLOCK_50), 
.outEnable(outEnable), 
.ld_x(ld_x),
.ld_y(ld_y),
.ld_c(ld_c),
.data_x(VGA_X),
.data_y(VGA_Y), 
.data_R(VGA_R), 
.data_G(VGA_G),
.data_B(VGA_B),


//outputs
.x_out(xOut),
.y_out(yOut),
.R_out(redOut),
.G_out(greenOut),
.B_out(blueOut), 
.go(go),
.newFrame(newFrame)
);


//use KEY3 to load XY in registers
//then display to hex

always@(posedge CLOCK_50)
begin
	if(~KEY[3])begin
		xDisplay <= xOut;
		yDisplay <= yOut;
		redDisplay <= redOut;
		greenDisplay <= greenOut;
		blueDisplay <= blueOut;
		
	end //end if 

end//always  	
	
	
	
//instanatiate hex display 
	
	//x in three parts
	hex_decoder h0(xDisplay[3:0], HEX0);
	hex_decoder h1(xDisplay[7:4], HEX1);
	hex_decoder h2(xDisplay[10:8], HEX2);
	
	//y in three parts
	hex_decoder h3(yDisplay[3:0], HEX3);
	hex_decoder h4(yDisplay[7:4], HEX4);
	hex_decoder h5(yDisplay[10:8], HEX5);
*/








