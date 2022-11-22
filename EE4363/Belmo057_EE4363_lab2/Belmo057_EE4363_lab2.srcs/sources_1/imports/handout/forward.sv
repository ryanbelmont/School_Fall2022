`timescale 1ns / 1ps
 
module forward(
    input clk,
    input bypassAfromMEM,
    input bypassAfromALUinWB,
    input bypassAfromLWinWB,
    input bypassBfromMEM,
    input bypassBfromALUinWB,
    input bypassBfromLWinWB,
    input [31:0] IDEXA,
    input [31:0] IDEXB,
    input [31:0] MEMWBValue,
    input [31:0] EXMEMALUOut,
    output reg [31:0] Ain,
    output reg [31:0] Bin
    );
    
   // TODO ...  assign the correct values to Ain, forwarding if needed   
   always @ (posedge clk)
   begin
        if (bypassAfromMEM)
        begin
            Ain <= EXMEMALUOut;
        end
        
        else if (bypassAfromALUinWB)
        begin
            Ain <= MEMWBValue;
        end
        
        else if (bypassAfromLWinWB)
        begin
            Ain <= MEMWBValue;
        end
        
        else
        begin
            assign Ain = IDEXA;
        end
   end 
   // assign Ain = IDEXA;

   // TODO ...  assign the correct values to Ain, forwarding if needed    
   always @ (posedge clk)
   begin
        if (bypassBfromMEM)
        begin
            Bin <= EXMEMALUOut;
        end
        
        else if (bypassBfromALUinWB)
        begin
            Bin <= MEMWBValue;
        end
        
        else if (bypassBfromLWinWB)
        begin
            Bin <= MEMWBValue;
        end
        
        else
        begin
            assign Bin = IDEXB;
        end
   end 
   // assign Bin = IDEXB;
               
endmodule
