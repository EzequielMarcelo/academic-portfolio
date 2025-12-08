module CLA_4_bits (
    input  [3:0] A,       // Operando A
    input  [3:0] B,       // Operando B
    input        Cin,     // Carry-in
    output [3:0] Sum,     // Soma
    output       Cout     // Carry-out
);

    wire [3:0] G; // Generate
    wire [3:0] P; // Propagate
    wire [3:0] C; // Carry interno

    // Gerar sinais de propagate e generate
    assign G = A & B;
    assign P = A ^ B;

    // Carry lookahead
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    // Soma
    assign Sum = P ^ C[3:0];

endmodule