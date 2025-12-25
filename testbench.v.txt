` default_nettype none
`timescale 1ns / 1ps
`include "sequitial_adder.v"


module testbench();
    reg [7:0] A;
    reg [7:0] B;
    reg clk;
    reg rst;
    wire [7:0] sum;
    wire cr_out;
    wire done;
    integer i=1;
    // Instantiate the adder
    adder dut (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .sum(sum),
        .cr_out(cr_out),
        .done(done)
    );

    // Clock generation
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end
    initial begin
		#1500;
		$finish();
	end

    initial begin
        // Dump file for waveform viewing
        $fsdbDumpfile("testbench.vcd");
        $fsdbDumpvars(0, testbench);

        for(i=1;i<=10;i=i+1) begin

        // Initial values for all registers
        A = 8'b0;
        B = 8'b0;
        rst = 1;

        // Hold reset for a few cycles
        repeat(2) @(posedge clk);


        // De-assert reset and provide inputs on the same clock edge
            @(posedge clk) begin
                rst = 0;
                A = $random();
                B = $random();
            end
            repeat(12) @(posedge clk);
        // Wait for the calculation to finish

            $display ("Time=%0d,rst=%0b,bit_count=%0d,A=%b,B=%b,sum=%b,carry=%0b,done=%0b",
            $time, rst, dut.bit_count, A, B, sum, cr_out, done);
        end

    end

    // Monitoring values
    //initial begin
        //$monitor ("Time=%0d,rst=%0b,bit_count=%0d,A=%b,B=%b,A1=%b,  B1=%b,sum=%b,carry=%0b,done=%0b",
            //$time, rst, dut.bit_count, A, B, dut.A1, dut.B1, sum, cr_out, done);
    //end
endmodule
