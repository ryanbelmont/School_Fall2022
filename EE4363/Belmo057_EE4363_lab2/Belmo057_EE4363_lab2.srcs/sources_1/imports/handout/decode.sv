`timescale 1ns / 1ps

module decode(
    input clk,
    input stall,
    input ijmpMem,
    input IDEXAfromWB,
    input IDEXBfromWB,
    input [31:0] IFIDIR,
    input [31:0] MEMWBValue,
    output reg [31:0] IDEXIR,
    output reg [31:0] IDEXA,
    output reg [31:0] IDEXB
    );
    
     initial begin
        IDEXIR = no_op;
        IDEXA = no_op;
        IDEXB = no_op;
     end 
     
    
    `include "parameters.sv"
    always @(posedge clk)begin
        if (stall | ijmpMem) begin // the first three pipeline stages stall if there is a load hazard
                  //TODO inject NOPs
                 
                 
              end
              else begin
                 //ID stage, with input from the WB stage
                 IDEXIR <= IFIDIR;  //pass along IR
                 if (~IDEXAfromWB)
                   IDEXA <= CPU.Regs[IFIDIR[25:21]]; // rs register value goes to IDEXA
                 else
                   IDEXA <= MEMWBValue;
                 if (~IDEXBfromWB)
                   IDEXB <= CPU.Regs[IFIDIR[20:16]]; // rt register value goes to IDEXB
                 else
                   IDEXB <= MEMWBValue;
              end
    end      
endmodule
