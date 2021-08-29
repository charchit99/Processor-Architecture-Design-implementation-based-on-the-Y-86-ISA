`timescale 1ns/1ps
`include "define.v"

module rgfile_tb;
	
	reg [63:0] W_valE_i , W_valM_i ;
	reg [3:0] W_dstE_i , W_dstM_i ,  d_srcA_i, d_srcB_i;
	reg [0:0] clk , rst ;
	wire [63:0] d_rvalA_o, d_rvalB_o ;

	integer cnt ;
	wire [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi,
r8, r9, r10, r11, r12, r13, r14;
	
	rgfile r0(rst,clk,W_dstE_i, W_valE_i, W_dstM_i, W_valM_i, d_srcA_i, d_rvalA_o, d_srcB_i, d_rvalB_o, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
	
	initial
		begin
			$dumpfile("rgfile_tb.vcd") ;
			$dumpvars(0,rgfile_tb) ;
		end
		
	initial
		begin
			#1 ;
			rst = 1 ;
			#10 
			rst = 0 ;
			W_dstM_i = 4'hf ;
			W_dstE_i = 4'h0 ;
			W_valE_i = 64'h13 ;
			#10 		 ;	
		end
	
	initial
		begin
			$monitor("rax_out = %h\nvalA = %h\nvalB = %h\n valE=%h\nvalM=%h\n" ,rax  , d_rvalA_o, d_rvalB_o ,W_valE_i , W_valM_i ) ;
		end
	
	initial
		begin
			cnt = 0 ;
			clk = 0 ;
			#5 ;
			
			while ( cnt < 11 )
				begin
					clk = ~clk ;
					cnt = cnt + 1 ;
					#5 ;
				end
		end
endmodule
