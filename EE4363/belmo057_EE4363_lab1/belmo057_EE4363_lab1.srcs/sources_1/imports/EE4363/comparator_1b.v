`timescale 1ns / 1ps


module comparator_1b(A, B, less_or_eq);
    input A, B;
    output less_or_eq;

    mux4to1 g1(less_or_eq, 1,1,0,1, B, A);
    
    
    
endmodule
