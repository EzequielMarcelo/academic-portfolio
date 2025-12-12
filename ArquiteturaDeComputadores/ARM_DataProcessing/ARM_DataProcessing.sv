module ARM_DataProcessing (
    input  logic         clk,
    input  logic         reset,
    input  logic [31:0]  Instr,
    output logic [31:0]  SrcA,
    output logic [31:0]  SrcB,
    output logic [31:0]  ALUResult
);

    // Campos da instrução (ARM data-processing subset)
    logic        I;
    logic [3:0]  cmd;
    logic [3:0]  Rn;
    logic [3:0]  Rd;
    logic [3:0]  Rm;
    logic [11:0] imm12;

    assign I     = Instr[25];
    assign cmd   = Instr[24:21];
    assign Rn    = Instr[19:16];
    assign Rd    = Instr[15:12];
    assign Rm    = Instr[3:0];
    assign imm12 = Instr[11:0];

    // Wires interno
    logic [31:0] imm_ext;
    logic [31:0] reg_read1;
    logic [31:0] reg_read2;
    logic        RegWrite;
    assign RegWrite = 1'b1; // habilitado para o lab

    // Instância do regfile
    regfile reg_file_inst (
        .clk(clk),
        .reset(reset),
        .Rn_addr(Rn),
        .Rm_addr(Rm),
        .Rd_addr(Rd),
        .write_data(ALUResult),
        .RegWrite(RegWrite),
        .read_data1(reg_read1),
        .read_data2(reg_read2)
    );

    // Extend com rotação ARM (imm12 => imm32)
    extend extend_inst (
        .imm12_in(imm12),
        .extended_imm_out(imm_ext)
    );

    // Mux SrcB: 0 -> register, 1 -> immediate
    mux2 srcb_mux (
        .sel(I),
        .data0(reg_read2),
        .data1(imm_ext),
        .out(SrcB)
    );

    assign SrcA = reg_read1;

    // ALU
    ALU alu_inst (
        .A(SrcA),
        .B(SrcB),
        .ALUControl(cmd),
        .ALUResult(ALUResult)
    );

endmodule
