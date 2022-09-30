module tb_comparator_1b;

wire less_or_eq;
reg A, B;
integer i;

comparator_1b uut (
    .less_or_eq    (    less_or_eq    ),
    .A      (    A      ),
    .B (B)
);

parameter PERIOD = 100;
integer total_point = 0;

initial begin
    $dumpfile("db_tb_comparator_1b.vcd");
    $dumpvars(0, tb_comparator_1b);
    #(PERIOD/2);

    for (i=0; i<=3; i=i+1)begin
        A = i[0];
        B = i[1];
        #(PERIOD/2);
        
        if (A > B) begin
            if (less_or_eq == 0) total_point = total_point + 1;
        end
            
        else begin
            if (less_or_eq == 1) total_point = total_point + 1;
        end
        end
end

endmodule
