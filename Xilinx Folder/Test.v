`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:14 07/11/2022 
// Design Name: 
// Module Name:    Test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Test(
		input CLK_RAW,
		input BUTTON_LEFT, BUTTON_RIGHT,
		output a,b,c,d,e,f,g,
		output SE0, SE1, SE2,
		output led1, led2, led3, led4, led5, led6, led7, led8,
		output dot
    );
	reg [25:0] count_7seg = 0;
	reg [25:0] count_imem = 0;
	reg [25:0] count_fsm = 0;
	reg CLK_OUT;
	reg CLK_IMEM;
	reg CLK_FSM;
	reg [1:0] state; //change between the 3 digits
	initial begin
		CLK_OUT <= 0;
		state <= 0;
	end

	always @(posedge CLK_RAW) begin
		count_7seg <= count_7seg + 1;
		count_imem <= count_imem + 1;
		count_fsm <= count_fsm + 1;
		if(count_7seg == 250000) begin //50 000 000; 250000 = 66 fps
			CLK_OUT = ~CLK_OUT;
			count_7seg <= 0;
		end
		if(count_imem == 50000000) begin
			CLK_IMEM = ~CLK_IMEM;
			count_imem <= 0;
		end
		if(count_fsm == 10000000) begin
			CLK_FSM =  ~CLK_FSM;
			count_fsm <= 0;
		end
	end
	reg [7:0] imemc = 0;
	
	always @(posedge CLK_IMEM) begin
		imemc <= imemc + 1;
		if(imemc == 52) begin
			imemc <= 0;
		end
	end
	wire [31:0] rd;
	
	wire reset;
	wire [31:0] writedata, dataadr;
	wire memwrite;
	top top(CLK_IMEM, reset, writedata, dataadr, memwrite,
		led1, led2, led3, led4, led5, led6, led7, led8);
	
	//button debouncing
	wire b_right, b_left;
	debounce db_left(BUTTON_LEFT,CLK_FSM,b_left);
	debounce db_right(BUTTON_RIGHT,CLK_FSM,b_right);
	
	// 10 01 00
	always @(posedge b_right or posedge b_left) begin
		if(b_left) begin
			case(state) 
				2'b00: state <= 2'b01;
				2'b01: state <= 2'b10;
				2'b10: state<= 2'b10;
			endcase
		end else begin
			case(state) 
				2'b00: state <= 2'b00;
				2'b01: state <= 2'b00;
				2'b10: state <= 2'b01;
			endcase
		end
	end
	
	wire [11:0] value;
	assign value = (state == 2'b00) ? dataadr[11:0] : (state == 2'b01) ? dataadr[23:12] : {4'b0000,dataadr[31:24]};
	
	
	seven_controller controller(value,state,CLK_OUT,a,b,c,d,e,f,g,SE0, SE1, SE2, dot);
	

endmodule
