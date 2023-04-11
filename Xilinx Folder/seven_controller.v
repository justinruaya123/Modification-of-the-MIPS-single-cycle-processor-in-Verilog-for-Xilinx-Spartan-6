`timescale 1ns / 1ps

// INPUT: CLK, 3-digit hexadecimal number
// OUTPUT: 7 segment controls
module seven_controller(
			input [11:0] number,
			input [1:0] state,
			input clk, //fast clock
			output a,b,c,d,e,f,g,
			output reg s0,s1,s2,dot
    );
	reg [4:0] selected;
	 
	reg [1:0] count = 0;
	always @(posedge clk) begin
		case(count)
			2'b00:
				begin
					{s0, s1, s2} <= 3'b101;
					count <= 2'b01;
					selected = number[7:4];
					if(state == 2'b01) begin
						dot <= 0;
					end else begin
						dot <= 1;
					end
				end
			2'b01:
				begin
					{s0, s1, s2} <= 3'b011;
					count <= 2'b10;
					selected = number[3:0];
					if(state == 2'b00) begin
						dot <= 0;
					end else begin
						dot <= 1;
					end
				end
			2'b10:
				begin
					{s0, s1, s2} <= 3'b110;
					count <= 2'b00;
					selected = number[11:8];
					if(state == 2'b10) begin
						dot <= 0;
					end else begin
						dot <= 1;
					end
				end
		endcase
	end
	
	seven_decoder decoder(a,b,c,d,e,f,g,selected); 
endmodule
