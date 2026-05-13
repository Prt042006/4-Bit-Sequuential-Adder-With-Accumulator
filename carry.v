module carry (cr_out,a,b,cr_in);
    input a,b,cr_in;
    output wire cr_out;
    wire t1,t2,t3;
        and g1 (t1,a,b);
        and g2 (t2,a,cr_in);
        and g3 (t3,b,cr_in);
        or g4 (cr_out,t1,t2,t3);
endmodule
