module datapath (
	clk,
	reset,
	memtoreg,
	pcsrc,
	alusrc,
	regdst,
	regwrite,
	jump,
	disableRA1,
	zeroextend,
	alucontrol,
	zero,
	pc,
	instr,
	aluout,
	writedata,
	readdata,
	led1, led2, led3, led4, led5, led6, led7, led8
);
	output wire led1, led2, led3, led4, led5, led6, led7, led8;
	input wire clk;
	input wire reset;
	input wire memtoreg;
	input wire pcsrc;
	input wire alusrc;
	input wire regdst;
	input wire regwrite;
	input wire jump;
	input wire disableRA1;
	input wire zeroextend;
	input wire [3:0] alucontrol;
	output wire zero;
	output wire [31:0] pc;
	input wire [31:0] instr;
	output wire [31:0] aluout;
	output wire [31:0] writedata;
	input wire [31:0] readdata;
	wire [4:0] writereg;
	wire [31:0] pcnext;
	wire [31:0] pcnextbr;
	wire [31:0] pcplus4;
	wire [31:0] pcbranch;
	wire [31:0] signimm;
	wire [31:0] signimmsh;
	wire [31:0] srca;
	wire [31:0] srcb;
	wire [31:0] result;
	flopr #(32) pcreg(
		clk,
		reset,
		pcnext,
		pc
	);
	assign {led8, led7, led6, led5, led4, led3, led2, led1} = pc[9:2];
	
	adder #(32) pcadd1(
		pc,
		32'b00000000000000000000000000000100,
		'b0,
		pcplus4
	);
	sl2 immsh(
		signimm,
		signimmsh
	);
	adder #(32) pcadd2(
		pcplus4,
		signimmsh,
		'b0,
		pcbranch
	);
	mux2 #(32) pcbrmux(
		pcplus4,
		pcbranch,
		pcsrc,
		pcnextbr
	);
	mux2 #(32) pcmux(
		pcnextbr,
		{pcplus4[31:28], instr[25:0], 2'b00},
		jump,
		pcnext
	);
	regfile rf(
		clk,
		regwrite,
		disableRA1,
		instr[25:21],
		instr[20:16],
		writereg,
		result,
		srca,
		writedata
	);
	mux2 #(5) wrmux(
		instr[20:16],
		instr[15:11],
		regdst,
		writereg
	);
	mux2 #(32) resmux(
		aluout,
		readdata,
		memtoreg,
		result
	);
	signext se(
		instr[15:0],
		zeroextend,
		signimm
	);
	mux2 #(32) srcbmux(
		writedata,
		signimm,
		alusrc,
		srcb
	);
	alu alu(
		srca,
		srcb,
		instr[10:6],
		alucontrol,
		aluout,
		zero
	);
endmodule
