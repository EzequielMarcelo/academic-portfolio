module ALU (
    input  logic [31:0] A,
    input  logic [31:0] B,
    input  logic [3:0]  ALUControl,
    output logic [31:0] ALUResult
);

    always_comb begin
        case (ALUControl)
            4'b0100: ALUResult = A + B;    // ADD
            4'b0010: ALUResult = A - B;    // SUB
            4'b0000: ALUResult = A & B;    // AND
            4'b1100: ALUResult = A | B;    // ORR
            default: ALUResult = 32'h0000_0000;
        endcase
    end
endmodule
