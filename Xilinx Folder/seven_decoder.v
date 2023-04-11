module seven_decoder(
		output reg a,b,c,d,e,f,g,
		input [3:0] DisplayNum);
	always @(DisplayNum) begin
		case (DisplayNum)
				0 : {a,b,c,d,e,f,g} <= 7'b0000001;
				1 : {a,b,c,d,e,f,g} <= 7'b1001111;
				2 : {a,b,c,d,e,f,g} <= 7'b0010010;
				3 : {a,b,c,d,e,f,g} <= 7'b0000110;
				4 : {a,b,c,d,e,f,g} <= 7'b1001100;
				5 : {a,b,c,d,e,f,g} <= 7'b0100100;
				6 : {a,b,c,d,e,f,g} <= 7'b0100000;
				7 : {a,b,c,d,e,f,g} <= 7'b0001111;
				8 : {a,b,c,d,e,f,g} <= 7'b0000000;
				9 : {a,b,c,d,e,f,g} <= 7'b0000100;
				10: {a,b,c,d,e,f,g} <= 7'b0001000; // a
				11: {a,b,c,d,e,f,g} <= 7'b1100000; // b
				12: {a,b,c,d,e,f,g} <= 7'b0110001; // c
				13: {a,b,c,d,e,f,g} <= 7'b1000010; // d
				14: {a,b,c,d,e,f,g} <= 7'b0110000; // e
				15: {a,b,c,d,e,f,g} <= 7'b0111000; // f
			default : {a,b,c,d,e,f,g} <= 7'b1111110;
		endcase
	end
endmodule
