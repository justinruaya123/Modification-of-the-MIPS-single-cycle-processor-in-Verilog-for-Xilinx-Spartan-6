module aludec (
	funct,
	aluop,
	alucontrol
);
	input wire [5:0] funct;
	input wire [1:0] aluop;
	output reg [3:0] alucontrol;
	always @(*)
		case (aluop)
			2'b00: alucontrol <= 4'b0010;
			2'b01: alucontrol <= 4'b1010;
			2'b11: alucontrol <= 4'b1101;
			default:
				case (funct)
					6'b000000: alucontrol <= 4'b0100;
					6'b100000: alucontrol <= 4'b0010;
					6'b100010: alucontrol <= 4'b1010;
					6'b100100: alucontrol <= 4'b0000;
					6'b100101: alucontrol <= 4'b0001;
					6'b101010: alucontrol <= 4'b1011;
					6'b110011: alucontrol <= 4'b0110;
					default: alucontrol <= 4'bxxxx;
				endcase
		endcase
endmodule
