module dmem (
	clk,
	we,
	bytemode,
	a,
	wd,
	rd
);
	input wire clk;
	input wire we;
	input wire bytemode;
	input wire [31:0] a;
	input wire [31:0] wd;
	output wire [31:0] rd;
	reg [31:0] RAM [63:0];
	assign rd = RAM[a[31:2]];
	always @(posedge clk)
		if (we)
			if (bytemode)
				case (a[1:0])
					2'b00: RAM[a[31:2]][31:24] <= wd[7:0];
					2'b01: RAM[a[31:2]][23:16] <= wd[7:0];
					2'b10: RAM[a[31:2]][15:8] <= wd[7:0];
					2'b11: RAM[a[31:2]][7:0] <= wd[7:0];
				endcase
			else
				RAM[a[31:2]] <= wd;
endmodule
