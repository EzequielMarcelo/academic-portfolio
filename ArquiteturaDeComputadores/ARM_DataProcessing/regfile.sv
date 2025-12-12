module regfile (
    input  logic         clk,
    input  logic         reset,
    input  logic [3:0]   Rn_addr,
    input  logic [3:0]   Rm_addr,
    input  logic [3:0]   Rd_addr,
    input  logic [31:0]  write_data,
    input  logic         RegWrite,
    output logic [31:0]  read_data1,
    output logic [31:0]  read_data2
);

    // 16 registradores de 32 bits
    logic [31:0] registers [15:0];

    // Leitura assíncrona
    assign read_data1 = registers[Rn_addr];
    assign read_data2 = registers[Rm_addr];

    // Escrita síncrona com reset
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 16; i++) registers[i] <= 32'h0000_0000;
        end else if (RegWrite) begin
            // evita escrever em R15 opcionalmente
            if (Rd_addr != 4'hF) begin
                registers[Rd_addr] <= write_data;
            end
        end
    end

endmodule
