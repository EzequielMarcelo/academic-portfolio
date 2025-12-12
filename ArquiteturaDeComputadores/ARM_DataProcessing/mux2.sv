module mux2 (
    input  logic         sel,
    input  logic [31:0]  data0,
    input  logic [31:0]  data1,
    output logic [31:0]  out
);

    always_comb begin
        out = sel ? data1 : data0;
    end

endmodule
