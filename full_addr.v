`timescale 1ns / 1ps
module full_adder (
    input wire in1,
    input wire in2,
    input wire cr_in,
    output wire sum,
    output wire c_out
 );
    assign sum = in1 ^ in2 ^ cr_in;
    assign c_out = (in1 & in2) | (in1 & cr_in) | (in2 & cr_in);
endmodule
