`timescale 1ns/1ps

module CLA_4_bits_tv_test;
	logic [3:0] A, B;
	logic       Cin;
	logic [3:0] Sum;
	logic      Cout;

	CLA_4_bits dut (.*);
	
	reg [13:0] vectors [0:511]; // 512 vetores de 14 bits
	int nlines;
	int i;

	// Valores extraídos do vetor
	logic [3:0] a, b;
	logic       c_in;
	logic [3:0] expected_sum;    
	logic       expected_cout; 
	int errors = 0;
	int total_tests = 0;	

    initial begin
        $display("Iniciando leitura e plotagem dos vetores ...");

        // Lê arquivo binário
        $readmemb("cla_vectors.tv", vectors, 0, 511);

        nlines = 512;

        for (i = 0; i < nlines; i = i + 1) begin
            // Extrai sinais do vetor (A B Cin Sum Cout)
            {a, b, c_in, expected_sum, expected_cout}    = vectors[i];
				// Aplica valores
				A   = a;
				B   = b;
				Cin = c_in;

				#5;  // espera DUT calcular
				
				total_tests = total_tests + 1;
			
				// Verificação
				if (Sum === expected_sum && Cout === expected_cout) begin
					 $display("Passou: Linha=%0d, A=%0d, B=%0d, Cin=%0b => Sum=%0d, Cout=%0b",
								 i, A, B, Cin, Sum, Cout);
				end else begin
					 $display("Falhou: Linha=%0d, A=%0d, B=%0d, Cin=%0b => DUT: Sum=%0d, Cout=%0b, Esperado: Sum=%0d, Cout=%0b",
								 i, A, B, Cin, Sum, Cout, expected_sum, expected_cout);
					 errors = errors + 1;
				end
        end
			// Resumo final
			if (errors == 0) begin
				$display("==================================================");
				$display(" TODOS OS %0d TESTES PASSARAM SEM ERROS!", total_tests);
				$display("==================================================");
			end else begin
				$display("==================================================");
				$display(" TESTE FINALIZADO COM %0d ERROS EM %0d TESTES.",
							errors, total_tests);
				$display("==================================================");
			end
			  $display("Leitura de arquivo finalizada.");
			  #10;
			  $finish;
    end
endmodule
