`timescale 1ns / 1ps

module fetch(
      input clk,
      input ijmpMem,
      input stall,
      input [31:0] PC,
      output reg [31:0] IFIDIR
    );
     `include "parameters.sv"
     
     initial begin
        IFIDIR = no_op;
     end 
     
    always @(posedge clk) begin
          if (ijmpMem) begin 
                             //TODO ... inject NOP
          end
          else if (stall) begin
             IFIDIR <= IFIDIR;
          end
          else begin
             IFIDIR <= CPU.IMemory[PC>>2];
          end
    end
endmodule
