`timescale 1ns / 1ps


module seven_seg(
		input [7:0] disp_byte, // AA BB CC DD
		input [1:0] mode, //       03 02 01 00
		output a, b, c, d, e, f, g,
		output e1, e2, e3
    ); //Display: <Mode> <byte>
	reg [4:0] r1, r2, r3;
	
	seven_decoder dec(a,b,c,d,e,f,g);

endmodule

