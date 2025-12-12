`timescale 1ns/1ps

module DataProcessing_tv_test;

    // Clock / reset / sinais
    logic clk;
    logic reset;
    logic [31:0] Instr;
    logic [31:0] SrcA, SrcB, ALUResult;

    // Memória de instruções
    logic [31:0] instruction_memory [0:255];

    // Debug vars (declaradas fora do loop)
    logic [3:0] dbg_Rd;
    integer i;

    // Instancia o DUT
    ARM_DataProcessing dut (
        .clk(clk),
        .reset(reset),
        .Instr(Instr),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUResult(ALUResult)
    );

    // Geração do clock (10 ns period = 100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Carrega instrucoes
        $display("Lendo instrucoes...");
        $readmemh("instr.tv", instruction_memory);

        // Reset inicial
        reset = 1;
        Instr = 32'h0;
        #20;
        reset = 0;

        // Cabeçalho
        $display("------------------------------------------------------------------");
        $display("Ciclo | Instrucao (Hex) | SrcA | SrcB | ALUResult");
        $display("------------------------------------------------------------------");

        // Loop principal: aplica Instr no negedge, captura após 1 posedge
        for (i = 0; i < 7; i = i + 1) begin
            @(negedge clk);
            Instr = instruction_memory[i];

            // espera 1 posedge: ALU executa e regfile escreve
            @(posedge clk);
            #1ps;

            // debug: extrai Rd para mostrar conteúdo do regfile
            dbg_Rd = Instr[15:12];

            $display("%5d | %h | %h | %h | %h",
                i, Instr, SrcA, SrcB, ALUResult);
        end

        $display("------------------------------------------------------------------");
        $finish;
    end

    // Waveform dump (VCD) - ModelSim/others podem usar $dumpfile/$dumpvars
    initial begin
        $dumpfile("DadaProcessing_wave.vcd");
        $dumpvars(0, DataProcessing_tv_test);
    end

endmodule
