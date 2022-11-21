`timescale 1ns / 1ps


module comparator_4b(A, B, less_or_eq);
    input [3:0] A, B;
    output less_or_eq;
    wire w1, w2, w3;
    
    mux4to1 g1(w1, 1, 0, 1, 1, A[0], B[0]);
    mux4to1 g2(w2, w1, 0, 1, w1, A[1], B[1]);
    mux4to1 g3(w3, w2, 0, 1, w2, A[2], B[2]);
    mux4to1 g4(less_or_eq , w3, 0, 1, w3, A[3], B[3]);
    
endmodule
