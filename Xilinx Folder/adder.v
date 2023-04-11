
module adder #(parameter N = 8)
              (input  wire [N-1:0] a, b,
               input  wire         cin,
               output wire [N-1:0] s,
               output wire         cout);

  assign {cout, s} = a + b + cin;
endmodule
