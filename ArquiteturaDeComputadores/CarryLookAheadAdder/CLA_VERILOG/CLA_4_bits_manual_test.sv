`timescale 1ns/1ps

module CLA_4_bits_manual_test;
   logic [3:0] A, B;
   logic Cin;
   logic [3:0] Sum;
   logic Cout;

   CLA_4_bits dut (.*);

   initial	
		begin
	   $display("Iniciando teste manual...\n");
	   $display("time |  A  |  B  | Cin | Cout | Sum ");

	   $monitor("%4t  | %0d | %0d |  %b |  %b  |  %0d", $time, A, B, Cin, Cout, Sum);

	   // sequência de testes
		A = 0;  B = 0;  Cin = 0;  #10;
		A = 0;  B = 0;  Cin = 1;  #10;
		
	   A = 1;  B = 1;  Cin = 0;  #10;
		A = 1;  B = 1;  Cin = 1;  #10;
		
	   A = 3;  B = 6;  Cin = 0;  #10;
		A = 3;  B = 6;  Cin = 1;  #10;
	   
		A = 4;  B = 2;  Cin = 0;  #10;
		A = 4;  B = 2;  Cin = 1;  #10;
	   
		A = 12;  B = 3;  Cin = 0;  #10;
	   A = 12;  B = 3;  Cin = 1;  #10;
	   
		A = 15; B = 1;  Cin = 0;  #10;
	   A = 15; B = 1;  Cin = 1;  #10;

	   $display("\nTestbench finalizado.");
	   #10;
	   $finish;
	end
endmodule
