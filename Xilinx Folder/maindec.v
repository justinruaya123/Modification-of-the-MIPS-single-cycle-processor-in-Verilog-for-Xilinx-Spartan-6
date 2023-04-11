module maindec (
	op,
	memtoreg,
	memwrite,
	branch,
	alusrc,
	regdst,
	regwrite,
	jump,
	disableRA1,
	zeroextend,
	bytemode,
	aluop
);
	input wire [5:0] op;
	output wire memtoreg;
	output wire memwrite;
	output wire branch;
	output wire alusrc;
	output wire regdst;
	output wire regwrite;
	output wire jump;
	output wire disableRA1;
	output wire zeroextend;
	output wire bytemode;
	output wire [1:0] aluop;
	reg [11:0] controls;
	assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, disableRA1, zeroextend, bytemode, aluop} = controls;
	always @(*)
		case (op)
			6'b000000: controls <= 12'b110000000010;
			6'b100011: controls <= 12'b101001000000;
			6'b101011: controls <= 12'b001010000000;
			6'b000100: controls <= 12'b000100000001;
			6'b001000: controls <= 12'b101000000000;
			6'b000010: controls <= 12'b000000100000;
			6'b101000: controls <= 12'b001010000100;
			6'b011111: controls <= 12'b000100000011;
			6'b010001: controls <= 12'b101000011000;
			default: controls <= 12'bxxxxxxxxxxxx;
		endcase
endmodule
