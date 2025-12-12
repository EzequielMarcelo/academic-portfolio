module extend (
    input  logic [11:0] imm12_in,
    output logic [31:0] extended_imm_out
);

    // imm12 = rotate_imm[11:8] : imm8[7:0]
    logic [3:0] rotate_imm;
    logic [7:0] imm8;

    function automatic logic [31:0] ror32(input logic [31:0] val, input int amt);
        logic [31:0] tmp;
        int a;
        begin
            a = amt % 32;
            if (a == 0) tmp = val;
            else tmp = (val >> a) | (val << (32 - a));
            return tmp;
        end
    endfunction

    always_comb begin
        rotate_imm = imm12_in[11:8];
        imm8 = imm12_in[7:0];
        extended_imm_out = ror32({24'b0, imm8}, rotate_imm * 2);
    end

endmodule

