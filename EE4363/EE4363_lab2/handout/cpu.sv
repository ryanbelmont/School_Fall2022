`timescale 1ns / 1ps

module CPU (clock);
   integer fd,code,str,t;
   input clock;
   `include "parameters.sv"
   reg [31:0] Regs[0:31], IMemory[0:1023], DMemory[0:1023];
   wire[31:0] PC, // separate memories
             IFIDIR, IDEXA, IDEXB, IDEXIR, EXMEMIR, EXMEMB, // pipeline registers
             EXMEMALUOut, MEMWBValue, MEMWBIR; // pipeline registers
   wire [31:0] ijmpPCValue; wire ijmpMem;
   wire EXMEMFlagOut, MEMWBFlagOut;
   //declare the bypass signals
   wire stall, bypassAfromMEM, bypassAfromALUinWB,bypassBfromMEM, bypassBfromALUinWB,
        bypassAfromLWinWB, bypassBfromLWinWB,bypassIDEXAfromWB, bypassIDEXBfromWB,
        IDEXAfromWB, IDEXBfromWB;
   
   control CTRL(
     .IFIDIR(IFIDIR),
     .IDEXIR(IDEXIR),
     .EXMEMIR(EXMEMIR),
     .MEMWBIR(MEMWBIR),
     .EXMEMFlagOut(EXMEMFlagOut),
     .MEMWBFlagOut(MEMWBFlagOut),
     .bypassAfromMEM(bypassAfromMEM),
     .bypassBfromMEM(bypassBfromMEM),
     .bypassAfromALUinWB(bypassAfromALUinWB),
     .bypassBfromALUinWB(bypassBfromALUinWB),
     .bypassAfromLWinWB(bypassAfromLWinWB),
     .bypassBfromLWinWB(bypassBfromLWinWB),
     .IDEXAfromWB(IDEXAfromWB),
     .IDEXBfromWB(IDEXBfromWB),
     .stall(stall),
     .ijmpMem(ijmpMem)
    ); 
   
    prc PRC(
    .clk(clock),
    .ijmpMem(ijmpMem),
    .stall(stall),
    .ijmpPCValue(ijmpPCValue),
    .PC(PC)
    );
   
    fetch FETCH(
    .clk(clock),
    .ijmpMem(ijmpMem),
    .stall(stall),
    .PC(PC),
    .IFIDIR(IFIDIR)
    );
   
    decode DEC(
    .clk(clock),
    .stall(stall),
    .ijmpMem(ijmpMem),
    .IDEXAfromWB(IDEXAfromWB),
    .IDEXBfromWB(IDEXBfromWB),
    .IFIDIR(IFIDIR),
    .MEMWBValue(MEMWBValue),
    .IDEXIR(IDEXIR),
    .IDEXA(IDEXA),
    .IDEXB(IDEXB)
    );   
   
    execute EX(
     .bypassAfromMEM(bypassAfromMEM),
     .bypassAfromALUinWB(bypassAfromALUinWB),
     .bypassAfromLWinWB(bypassAfromLWinWB),
     .bypassBfromMEM(bypassBfromMEM),
     .bypassBfromALUinWB(bypassBfromALUinWB),
     .bypassBfromLWinWB(bypassBfromLWinWB),
     .clk(clock),
     .ijmpMem(ijmpMem), 
     .IDEXIR(IDEXIR), 
     .IDEXA(IDEXA),
     .IDEXB(IDEXB),
     .MEMWBValue(MEMWBValue),
     .EXMEMB(EXMEMB),
     .EXMEMIR(EXMEMIR),
     .EXMEMFlagOut(EXMEMFlagOut),
     .EXMEMALUOut(EXMEMALUOut)
    );

    mem MEM(
    .clk(clock),
    .EXMEMALUOut(EXMEMALUOut),
    .EXMEMB(EXMEMB), 
    .EXMEMFlagOut(EXMEMFlagOut),
    .EXMEMIR(EXMEMIR),
    .MEMWBValue(MEMWBValue),
    .MEMWBFlagOut(MEMWBFlagOut),
    .MEMWBIR(MEMWBIR),
    .ijmpPCValue(ijmpPCValue)
    );
     
    wb WB(
    .clk(clock),
    .MEMWBValue(MEMWBValue),
    .MEMWBFlagOut(MEMWBFlagOut),    
    .MEMWBIR(MEMWBIR)
    );
   
   reg [10:0] i; //used to initialize registers
   //string filename = "regs.dat";

   initial begin
      t=0;
      #1 //delay of 1, wait for the input ports to initialize
      //IDEXIR = no_op; EXMEMIR = no_op; MEMWBIR = no_op; // put no_ops in pipeline registers
      for(i=0;i<=31;i=i+1) Regs[i]=i; //initialize registers
      for(i=0;i<=1023;i=i+1) IMemory[i]=0;
      for(i=0;i<=1023;i=i+1) DMemory[i]=0;
      fd=$fopen(filename,"r");
      i=0; while(!$feof(fd)) begin
        code=$fscanf(fd, "%b\n", str);
        Regs[i]=str;
        i=i+1;
      end
      i=0; fd=$fopen(filename1,"r");
      while(!$feof(fd)) begin
        code=$fscanf(fd, "%b\n", str);
        DMemory[i]=str;
        i=i+1;
      end
      i=0; fd=$fopen(filename2,"r");
      while(!$feof(fd)) begin
        code=$fscanf(fd, "%b\n", str);
        IMemory[i]=str;
        i=i+1;
      end
      #2096
      i=0; fd =$fopen(filename3,"w" ); //open memory result file
      while(i < 32)
      begin
        str = DMemory[i];  //dump the first 32 memory values
        $fwrite(fd, "%b\n", str);
        i=i+1;
      end
      $fclose(fd);
      i=0; fd =$fopen(filename4,"w" ); //open register result file
      while(i < 32)
      begin
        str = Regs[i];  //dump the register values
        $fwrite(fd, "%b\n", str);
        i=i+1;
      end
      $fclose(fd);
   end    
endmodule
//////////////////////////////////////////////////////////////////////////////////
