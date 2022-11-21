`timescale 1ns / 1ps

module prc(
     input clk,
     input ijmpMem,
     input stall,
     input [31:0] ijmpPCValue,
     output reg [31:0] PC
    );
    
    initial
    begin
        PC = 0;
    end
    
    always @(posedge clk)
    begin
        if (ijmpMem) begin 
               //TODO ... update the PC value
          end
          else if (stall) begin // if there is a Load Use Hazard, then stall
             PC <= PC;
          end
          else begin
             PC <= PC + 4;
          end
     end     
endmodule
