module alu (
	a,
	b,
	shamt,
	alucontrol,
	result,
	zero
);
	input wire [31:0] a;
	input wire [31:0] b;
	input wire [4:0] shamt;
	input wire [3:0] alucontrol;
	output reg [31:0] result;
	output wire zero;
	wire [31:0] condinvb;
	wire [31:0] sum;
	assign condinvb = (alucontrol[3] ? ~b : b);
	assign sum = (a + condinvb) + alucontrol[3];
	always @(*)
		case (alucontrol[2:0])
			3'b000: result = a & b;
			3'b001: result = a | b;
			3'b010: result = sum;
			3'b011: result = sum[31];
			3'b100: result = b << shamt;
			3'b110: result = (a >> ({1'b0, b[4:0]} + 6'b000001)) << ({1'b0, b[4:0]} + 6'b000001);
		endcase
	assign zero = (alucontrol[2:0] == 3'b101 ? ~($signed(b) < $signed(a)) : result == 32'b00000000000000000000000000000000);
endmodule
