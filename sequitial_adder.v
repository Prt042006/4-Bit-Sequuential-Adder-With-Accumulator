` default_nettype none
`timescale 1ns / 1ps
`include "full_addr.v"
module adder (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire clk,
    input wire rst,
    output reg [7:0] sum,
    output reg cr_out,
    output reg done
);

    reg [7:0] A1, B1;
    reg [3:0] bit_count;
    reg carry_reg;

    wire lsbA1, lsbB1;
    wire adder_sum;
    wire adder_cr_out;

    // Combinational logic to pick the least significant bit
    assign lsbA1 = A1[0];
    assign lsbB1 = B1[0];

    // Instantiate the single full adder
    full_adder add (
        .in1(lsbA1),
        .in2(lsbB1),
        .cr_in(carry_reg),
        .sum(adder_sum),
        .c_out(adder_cr_out)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A1 <= 8'b0;
            B1 <= 8'b0;
            sum <= 8'b0;
            cr_out <= 1'b0;
            carry_reg <= 1'b0;
            bit_count <= 4'b0;
            done <= 1'b0;
        end
        else begin
            // State 0: Initialize with input values
            if (bit_count == 4'b0) begin
                A1 <= A;
                B1 <= B;
                sum <= 8'b0;
                carry_reg <= 1'b0;
                bit_count <= bit_count + 1;
                done <= 1'b0;
                cr_out <= 1'b0;
            end
            // States 1 to 8: Perform addition and shift
            else if (bit_count >= 1 && bit_count <= 8) begin
                sum <= {adder_sum,sum[7:1]}; // Correct: shift new bit into LSB
                A1 <= {1'b0, A1[7:1]};
                B1 <= {1'b0, B1[7:1]};
                carry_reg <= adder_cr_out;
                bit_count <= bit_count + 1;
            end
            // State 9: Finalize outputs and set done
            else if (bit_count == 9) begin
                cr_out <= carry_reg; // Use the carry from the last calculation
                done <= 1'b1;
            end
        end
    end
endmodule
