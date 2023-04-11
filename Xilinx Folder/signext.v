module signext(input  wire [15:0] a,
               input  wire        zeroextend, //Signs or zero extends for li instruction
               output wire [31:0] y);
  assign y = zeroextend ? {16'b0, a} : {{16{a[15]}}, a}; 
endmodule