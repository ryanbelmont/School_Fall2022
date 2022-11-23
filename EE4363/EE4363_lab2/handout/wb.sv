`timescale 1ns / 1ps

module wb(
    input clk,
    input [31:0] MEMWBValue,
    input MEMWBFlagOut,   
    input [31:0] MEMWBIR
    );
    
    wire [5:0] MEMWBop;
    wire [5:0] MEMWBrd;
    assign MEMWBop = MEMWBIR[31:26];
    assign MEMWBrd = MEMWBIR[15:11];    
     
   `include "parameters.sv"
   always @(posedge clk)
   begin
       if ((MEMWBop==ALUop) & (MEMWBrd != 0)) CPU.Regs[MEMWBrd] <= MEMWBValue; // ALU operation
          else if ((MEMWBop == LW) & (MEMWBIR[20:16] != 0))
                begin
                   CPU.Regs[MEMWBIR[20:16]] <= MEMWBValue; // Load operation
                end
          else if ( MEMWBop == CDEC ) if (MEMWBFlagOut == 1) 
                begin                     // TODO ... update register file using MEMWBValue
                   CPU.Regs[MEMWBIR[15:11]] <= MEMWBValue;
                end
          else if ( MEMWBop == IJMP ) begin ;  end // Do nothing
   end
endmodule
