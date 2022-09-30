module tb_mux16to1;

reg clk;
wire out;
reg [15:0] D;
reg [3:0] control;
integer i;

mux16to1 uut (
    .out    (    out    ),
    .D      (    D      ),
    .control (control)
);

parameter PERIOD = 20;
integer total_point = 0;

initial begin
    $dumpfile("db_tb_mux16to1.vcd");
    $dumpvars(0, tb_mux16to1);
    clk = 1'b0;
    #(PERIOD/2);
    
    D = 16'b1010101010101010;

    for (i=0; i<=2**4-1; i=i+1)begin
        control = i[3:0];
        #(PERIOD/2);
        
        case ({control})
        0: begin
            if (out == D[0]) begin total_point = total_point+1;end
//            break;
            end
        1: begin
            if (out == D[1]) begin total_point = total_point+1;end
//            break;
            end
        2: begin
            if (out == D[2]) begin total_point = total_point+1;end
//            break;
            end
        3: begin
            if (out == D[3]) begin total_point = total_point+1;end
//            break;
            end
        4: begin
            if (out == D[4]) begin total_point = total_point+1;end
//            break;
            end
        5: begin
            if (out == D[5]) begin total_point = total_point+1;end
//            break;
            end
        6: begin
            if (out == D[6]) begin total_point = total_point+1;end
//            break;
            end
        7: begin
            if (out == D[7]) begin total_point = total_point+1;end
//            break;
            end
        8: begin
            if (out == D[8]) begin total_point = total_point+1;end
//            break;
            end
        9: begin
            if (out == D[9]) begin total_point = total_point+1;end
//            break;
            end
        10: begin
            if (out == D[10]) begin total_point = total_point+1;end
//            break;
            end
        11: begin
            if (out == D[11]) begin total_point = total_point+1;end
//            break;
            end
        12: begin
            if (out == D[12]) begin total_point = total_point+1;end
//            break;
            end
        13: begin
            if (out == D[13]) begin total_point = total_point+1;end
//            break;
            end
        14: begin
            if (out == D[14]) begin total_point = total_point+1;end
//            break;
            end
        15: begin
            if (out == D[15]) begin total_point = total_point+1;end
//            break;
            end
        default: ;//break;
        endcase
        
        end
end

endmodule
