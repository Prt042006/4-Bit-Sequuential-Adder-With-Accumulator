module sum (sum,a,b,cr_in);
    input a,b,cr_in;
    output wire sum;
    wire t;
        xor x1 (t,a,b);
        xor x2 (sum,t,cr_in);
endmodule
