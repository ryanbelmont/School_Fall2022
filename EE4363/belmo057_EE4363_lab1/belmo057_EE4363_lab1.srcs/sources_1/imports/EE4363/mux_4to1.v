`timescale 1ns / 1ps

module mux4to1(out, a, b, c, d, s0, s1);
    input a, b, c, d, s0, s1;
    output out;
    wire e,f,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10;
    not (e,s1);
    not (f,s0);
    
    and (w1,a,e);
    and (w2,b,e);
    and (w3,c,s1);
    and (w4,d,s1);
    
    and (w5,w1,f);
    and (w6,w2,s0);
    and (w7,w3,f);
    and (w8,w4,s0);
    
    or (w9,w5,w6);
    or (w10,w7,w8);
    or (out,w9,w10);
    
   
endmodule
