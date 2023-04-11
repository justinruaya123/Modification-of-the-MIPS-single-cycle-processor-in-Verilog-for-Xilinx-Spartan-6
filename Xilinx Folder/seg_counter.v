module seg_counter(input clk,
					output reg SE0, SE1, SE2,
					output reg [1:0] test_count
					);
	reg [1:0] test_count = 0;
	always @(posedge CLK_OUT) begin
		case(test_count)
			2'b00:
				begin
					{SE0, SE1, SE2} <= 3'b101;
					test_count <= 2'b01;
					{a,b,c,d,e,f,g} <= 7'b0000001;
				end
			2'b01:
				begin
					{SE0, SE1, SE2} <= 3'b011;
					test_count <= 2'b10;
					{a,b,c,d,e,f,g} <= 7'b0001000;
				end
			2'b10:
				begin
					{SE0, SE1, SE2} <= 3'b110;
					test_count <= 2'b00;
					{a,b,c,d,e,f,g} <= 7'b1110001;
				end
		endcase
endmodule 