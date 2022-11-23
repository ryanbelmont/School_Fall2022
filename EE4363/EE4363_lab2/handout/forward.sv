`timescale 1ns / 1ps
 
module forward(
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
    
    assign Ain = ((bypassAfromALUinWB | bypassAfromLWinWB) ?  MEMWBValue : IDEXA);
    assign Ain = (bypassAfromMEM  ? EXMEMALUOut: a);
    
    assign Bin = ((bypassBfromALUinWB | bypassBfromLWinWB) ? MEMWBValue : IDEXB);
    assign Bin = (bypassBfromMEM  ? EXMEMALUOut : b);
    
    
    //assign a = ((bypassAfromALUinWB | bypassAfromLWinWB) ? MEMWBValue  : IDEXA);
    //assign Ain = (bypassAfromMEM  ? EXMEMALUOut : a);
    
    //assign b = ((bypassBfromALUinWB | bypassBfromLWinWB) ? MEMWBValue  : IDEXB);
    //assign Bin = (bypassBfromMEM  ? EXMEMALUOut : b);
    
      //assign Ain = (select[0] ? b : a);
   
   //assign Ain = (bypassAfromMEM ? EXMEMALUOut : ((bypassAfromALUinWB | bypassAfromLWinWB) ? MEMWBValue : IDEXA));
   //assign Bin = (bypassBfromMEM ? EXMEMALUOut : ((bypassBfromALUinWB | bypassBfromLWinWB) ? MEMWBValue : IDEXB));
               
endmodule
