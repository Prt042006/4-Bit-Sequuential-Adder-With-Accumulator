`timescale 1ns / 1ps

`include "sum.v"
`include "carry.v"
module full_adder (c_out,sum,in1,in2,cr_in);
    input wire in1,in2,cr_in;
    output wire sum,c_out;
        sum s1(sum,in1,in2,cr_in);
        carry c1(c_out,in1,in2,cr_in);
endmodule


