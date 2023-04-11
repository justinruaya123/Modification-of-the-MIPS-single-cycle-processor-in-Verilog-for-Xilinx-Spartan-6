module mips (
	clk,
	reset,
	pc,
	instr,
	memwrite,
	bytemode,
	aluout,
	writedata,
	readdata,
	led1, led2, led3, led4, led5, led6, led7, led8
);
	output wire led1, led2, led3, led4, led5, led6, led7, led8;
	input wire clk;
	input wire reset;
	output wire [31:0] pc;
	input wire [31:0] instr;
	output wire memwrite;
	output wire bytemode;
	output wire [31:0] aluout;
	output wire [31:0] writedata;
	input wire [31:0] readdata;
	wire memtoreg;
	wire alusrc;
	wire regdst;
	wire regwrite;
	wire jump;
	wire pcsrc;
	wire zero;
	wire disableRA1;
	wire zeroextend;
	wire [3:0] alucontrol;
	controller c(
		instr[31:26],
		instr[5:0],
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
	datapath dp(
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
endmodule
