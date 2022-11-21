`timescale 1ns / 1ps


module mux16to1(D, control, out);
    input [15:0] D;
    input [3:0] control;
    output out;
    wire w1,w2,w3,w4;
    
        
    mux4to1 g1(w1,D[0],D[1],D[2],D[3],control[1],control[0]);
    mux4to1 g2(w2,D[4],D[5],D[6],D[7],control[1],control[0]);
    mux4to1 g3(w3,D[8],D[9],D[10],D[11],control[1],control[0]);
    mux4to1 g4(w4,D[12],D[13],D[14],D[15],control[1],control[0]);
    
    mux4to1 g5(out, w1, w2, w3, w4, control[2], control[3]);
    

endmodule