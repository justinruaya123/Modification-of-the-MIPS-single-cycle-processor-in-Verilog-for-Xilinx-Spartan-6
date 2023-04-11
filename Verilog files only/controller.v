module controller (
	op,
	funct,
	zero,
	memtoreg,
	memwrite,
	pcsrc,
	alusrc,
	regdst,
	regwrite,
	disableRA1,
	zeroextend,
	bytemode,
	jump,
	alucontrol
);
	input wire [5:0] op;
	input wire [5:0] funct;
	input wire zero;
	output wire memtoreg;
	output wire memwrite;
	output wire pcsrc;
	output wire alusrc;
	output wire regdst;
	output wire regwrite;
	output wire disableRA1;
	output wire zeroextend;
	output wire bytemode;
	output wire jump;
	output wire [3:0] alucontrol;
	wire [1:0] aluop;
	wire branch;
	maindec md(
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
	aludec ad(
		funct,
		aluop,
		alucontrol
	);
	assign pcsrc = branch & zero;
endmodule
