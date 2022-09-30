module tb_mux4to1;

reg clk;
wire out;
reg a, b, c, d, s0, s1;
integer i;

mux4to1 uut (
    .out    (    out    ),
    .a      (    a      ),
    .b (b),
    .c (c),
    .d (d),
    .s0 (s0),
    .s1 (s1)
);

parameter PERIOD = 20;
integer total_point = 0;

initial begin
    $dumpfile("db_tb_mux4to1.vcd");
    $dumpvars(0, tb_mux4to1);
    clk = 1'b0;
    #(PERIOD/2);

    for (i=0; i<=63; i=i+1)begin
        a = i[0];
        b = i[1];
        c = i[2];
        d = i[3];
        s0 = i[4];
        s1 = i[5];
        #(PERIOD/2);
        
        case ({s1, s0})
        0: begin
            if (out == a) begin total_point = total_point+1;end
//            break;
            end
        1: begin
            if (out == b) begin total_point = total_point+1;end
//            break;
            end
        2: begin
            if (out == c) begin total_point = total_point+1;end
//            break;
            end
        3: begin
            if (out == d) begin total_point = total_point+1;end
//            break;
            end
        default: ;//break;
        endcase
        
        end
end

endmodule
