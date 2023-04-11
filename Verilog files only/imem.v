module imem(
		input [7:0] a,
		output [31:0] rd
    );
	 reg [31:0] RAM[63:0];
	 integer x = 0;
	 initial
			begin
				for(x = 0; x < 64; x=x+1) begin
					RAM[x] = 0;
				end
				$readmemh("memfile.mem", RAM);
			end

	assign rd = RAM[a];

endmodule
