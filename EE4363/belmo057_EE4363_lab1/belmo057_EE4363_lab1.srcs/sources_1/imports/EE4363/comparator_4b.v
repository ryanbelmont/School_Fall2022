`timescale 1ns / 1ps


module comparator_4b(A, B, less_or_eq);
    input [3:0] A, B;
    output less_or_eq;
    wire w1, w2, w3;
    
    comparator_1b g1(A[3],B[3],w1);
    comparator_1b g2(A[2],B[2],w2);
    comparator_1b g3(A[1],B[1],w3);
    comparator_1b g4(A[0],B[0],less_or_eq);
    
endmodule
