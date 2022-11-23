`timescale 1ns / 1ps

module mem(
    input clk,
    input [31:0] EXMEMALUOut,
    input [31:0] EXMEMB, 
    input  EXMEMFlagOut,
    input [31:0] EXMEMIR,
    output reg [31:0] MEMWBValue,
    output reg  MEMWBFlagOut,
    output reg [31:0] MEMWBIR,
    output [31:0] ijmpPCValue
    );

    wire [5:0] EXMEMop;    
    assign ijmpPCValue = EXMEMALUOut;
    assign EXMEMop = EXMEMIR[31:26];

    initial begin
        MEMWBIR = no_op;
        MEMWBFlagOut = 0;
        MEMWBValue = 0;
    end 
     
    `include "parameters.sv"
    always @ (posedge clk)
    begin
        if (EXMEMop==ALUop) MEMWBValue <= EXMEMALUOut; //Pass along ALU result
              else if (EXMEMop == LW) MEMWBValue <= CPU.DMemory[EXMEMALUOut>>2]; //Load
              else if (EXMEMop == SW) CPU.DMemory[EXMEMALUOut>>2] <= EXMEMB; //Store
              else if (EXMEMop == CDEC) begin
                            // TODO ... Update MEMWBValue with EXMEMALUOut
                            MEMWBValue <= EXMEMALUOut;
                            // TODO ... Pass along the EXMEMFlagOut to MemWBFlagOut
                            MEMWBFlagOut <= EXMEMFlagOut;
                   end
              else if (EXMEMop == IJMP) begin ; end // Do nothing
                           
              MEMWBIR <= EXMEMIR; //pass along IR
    end
endmodule
