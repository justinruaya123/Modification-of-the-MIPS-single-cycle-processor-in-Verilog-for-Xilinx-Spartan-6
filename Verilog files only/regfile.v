`timescale 1ns / 1ps
module regfile(input  reg        clk, 
               input  reg        we3, disableRA1, //Disable RA1 for Li
               input  wire [4:0]  ra1, ra2, wa3, 
               input  reg [31:0] wd3,
               output wire [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clk
  // register 0 hardwired to 0
  // note: for pipelined processor, write on
  // falling edge of clk

  always @(posedge clk)
    if (we3) rf[wa3] <= wd3;
    	 

    assign rd1 = (ra1 == 0 | disableRA1) ? 32'b0 : rf[ra1]; //Setter for disable RA1
    assign rd2 = (ra2 != 0) ? rf[ra2] : 32'b0;
endmodule
