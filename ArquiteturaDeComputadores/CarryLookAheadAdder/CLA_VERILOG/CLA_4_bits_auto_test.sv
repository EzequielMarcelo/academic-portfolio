`timescale 1ns/1ps

module CLA_4_bits_auto_test;	
	logic [3:0] A, B;
	logic       Cin;
	logic [3:0] Sum;
	logic      Cout;

	CLA_4_bits dut (.*);

	// Variáveis para loop e referência
	int a, b, c;
	int expected_val;
	logic [3:0] expected_sum;
	logic       expected_cout;

	int errors = 0;
	int total_tests = 0;

	initial begin
		$display("Iniciando teste automatico ...\n");

		// Loop para todas as combinações
		for (a = 0; a < 16; a = a + 1) begin
			for (b = 0; b < 16; b = b + 1) begin
				for (c = 0; c < 2; c = c + 1) begin
					// Aplica valores
					A   = a;
					B   = b;
					Cin = c;

					#5;  // espera DUT calcular

					// Resultado esperado
					expected_val  = a + b + c;
					expected_sum  = expected_val[3:0];
					expected_cout = expected_val[4];

					total_tests = total_tests + 1;

					// Verificação
					if (Sum === expected_sum && Cout === expected_cout) begin
						 $display("Passou: A=%0d, B=%0d, Cin=%0b => Sum=%0d, Cout=%0b",
									 A, B, Cin, Sum, Cout);
					end else begin
						 $display("Falhou: A=%0d, B=%0d, Cin=%0b => DUT: Sum=%0d, Cout=%0b, Esperado: Sum=%0d, Cout=%0b",
									 A, B, Cin, Sum, Cout, expected_sum, expected_cout);
						 errors = errors + 1;
					end
				end
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

	$finish;
	end
endmodule
