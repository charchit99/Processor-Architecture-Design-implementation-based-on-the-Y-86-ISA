`timescale 1ns / 1ps
`include "define.v"


module dec_exe_tb;
	    
    reg rst,clk,D_stall,D_bubble,E_bubble;
    reg [3:0] f_icode,f_ifun,f_rA,f_rB;
    reg [63:0] f_valC,f_valP;
    reg [2:0] f_stat;
    
    
    reg [63:0] e_valE,M_valE,data,W_valE,W_valM;
    reg [3:0] e_dstE,M_dstE,M_dstM,W_dstE,W_dstM;
    
    wire [3:0] D_icode,D_ifun,D_rA,D_rB,d_dstE,d_dstM,d_srcA,d_srcB,E_icode,E_ifun,E_dstE,E_dstM;
    wire [63:0] D_valC,D_valP,d_valA,d_valB,d_rvalA,d_rvalB,E_valC,E_valA,E_valB;
    wire [2:0] D_stat,E_stat;
    wire [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14;
      
      decode_reg y86_decode_reg
      (
            .clk(clk),
            .rst(rst),
            .D_stall_i(D_stall),
            .D_bubble_i(D_bubble),
            .f_icode_i(f_icode),
            .f_ifun_i(f_ifun),
            .f_rA_i(f_rA),
            .f_rB_i(f_rB),
            .f_valC_i(f_valC),
            .f_valP_i(f_valP),
            .f_stat_i(f_stat),

            .D_icode_o(D_icode),
            .D_ifun_o(D_ifun),
            .D_rA_o(D_rA),
            .D_rB_o(D_rB),
            .D_valC_o(D_valC),
            .D_valP_o(D_valP),
            .D_stat_o(D_stat)
      );
	
      sourcendest snd
      (
	    .D_icode_i(D_icode),
	    .D_rA_i(D_rA),
	    .D_rB_i(D_rB),
	    
      	    .d_srcA_o(d_srcA),
	    .d_srcB_o(d_srcB),
	    .d_dstE_o(d_dstE),
	    .d_dstM_o(d_dstM)
      );

      decode y86_decode
      (
            .D_icode_i(D_icode),
            .D_valP_i(D_valP),
            .d_srcA_i(d_srcA),//.D_srcA_i(D_rA),
            .d_srcB_i(d_srcB),//.D_srcB_i(D_rB),
            .d_rvalA_i(d_rvalA),
            .d_rvalB_i(d_rvalB),
            .e_dstE_i(e_dstE),
            .e_valE_i(e_valE),
            .M_dstE_i(M_dstE),
            .M_valE_i(M_valE),
            .M_dstM_i(M_dstM),
            .m_valM_i(data), //data to be changed to m_valM
            .W_dstE_i(W_dstE),
            .W_valE_i(W_valE),
            .W_dstM_i(W_dstM),
            .W_valM_i(W_valM),
            
            .d_valA_o(d_valA),
            .d_valB_o(d_valB)
      );

      execute_reg y86_execute_reg
      (
            .clk(clk),
            .rst(rst),
            .E_bubble_i(E_bubble),
            .D_stat_i(D_stat),
            .D_icode_i(D_icode),
            .D_ifun_i(D_ifun),
            .D_valC_i(D_valC),
            .d_valA_i(d_valA),
            .d_valB_i(d_valB),
            .d_dstE_i(d_dstE),//
            .d_dstM_i(d_dstM),//
            .d_srcA_i(d_srcA),
            .d_srcB_i(d_srcB),

            .E_stat_o(E_stat),
            .E_icode_o(E_icode),
            .E_ifun_o(E_ifun),
            .E_valC_o(E_valC),
            .E_valA_o(E_valA),
            .E_valB_o(E_valB),
            .E_dstE_o(E_dstE),
            .E_dstM_o(E_dstM)
      );

      rgfile rgfilemod
      (
            .clk(clk),
            .rst(rst),
            .W_dstE_i(W_dstE),
            .W_valE_i(W_valE),
            .W_dstM_i(W_dstM),
            .W_valM_i(W_valM),
            .d_srcA_i(d_srcA),
            .d_srcB_i(d_srcB),

            .d_rvalA_o(d_rvalA),
            .d_rvalB_o(d_rvalB),
            .rax(rax), .rcx(rcx), .rdx(rdx), .rbx(rbx), .rsp(rsp), .rbp(rbp), .rsi(rsi), .rdi(rdi), 
            .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14)
      );
	
    initial begin
                // Initialize Inputs
                $dumpfile("dec_exe_tb.vcd");
                $dumpvars(0,dec_exe_tb);
		clk <= 1'B0;
		#50;
		clk <= ~clk;
		rst <= 1'B0;
		D_stall <= 1'B0;
		D_bubble <= 1'B0;
		E_bubble <= 1'B0;
		f_icode <= 4'H3;
		f_ifun <= 4'H0;
		f_rA <= 4'H4;
		f_rB <= 4'H5;
		f_valP <= 64'Ha;
		f_valC <= 64'H2;
		f_stat <= 3'B0;
		e_valE <= 64'H0;
		M_valE <= 64'H0;
		data <= 64'H0;
		W_valE <= 64'H0;
		W_valM <= 64'H0;
		e_dstE <= 4'H0;
		M_dstE <= 4'H0;
		M_dstM <= 4'H0;
		W_dstE <= 4'H0;
		W_dstM <= 4'H0;
		#50;
		clk <= ~clk;
                #50;
		clk <= ~clk;
		rst <= 1'B0;
		D_stall <= 1'B0;
		D_bubble <= 1'B0;
		E_bubble <= 1'B0;
		f_icode <= 4'H3;
		f_ifun <= 4'H0;
		f_rA <= 4'H5;
		f_rB <= 4'H6;
		f_valP <= 64'Ha;
		f_valC <= 64'H3;
		f_stat <= 3'B0;
		e_valE <= 64'H0;
		M_valE <= 64'H0;
		data <= 64'H0;
		W_valE <= 64'H0;
		W_valM <= 64'H0;
		e_dstE <= 4'H0;
		M_dstE <= 4'H0;
		M_dstM <= 4'H0;
		W_dstE <= 4'H0;
		W_dstM <= 4'H0;
		#50;
		clk <= ~clk;
		#50;
		clk <= ~clk;
		rst <= 1'B0;
		D_stall <= 1'B0;
		D_bubble <= 1'B0;
		E_bubble <= 1'B0;
		f_icode <= 4'H6;
		f_ifun <= 4'H0;
		f_rA <= 4'H5;
		f_rB <= 4'H6;
		f_valP <= 64'H2;
		f_valC <= 64'H8;
		f_stat <= 3'B0;
		e_valE <= 64'H0;
		M_valE <= 64'H0;
		data <= 64'H0;
		W_valE <= 64'H0;
		W_valM <= 64'H0;
		e_dstE <= 4'H0;
		M_dstE <= 4'H0;
		M_dstM <= 4'H0;
		W_dstE <= 4'H0;
		W_dstM <= 4'H0;
		#50;
		clk <= ~clk;
		#50;

        end
	initial begin
		$monitor("\n\nrst=%b clk=%b D_stall_i=%b D_bubble_i=%b f_icode_i=%h f_ifun_i=%h f_rA_i=%h \n f_rB_i=%h f_valC_i=%h f_valP_i=%h f_stat_i=%b\n D_icode_o=%h D_ifun_o=%h D_rA_o=%h D_rB_o=%h \n D_valC_o=%h D_valP_o=%h D_stat_o=%b\n d_srcA=%h d_srcB=%h E_dstE=%h E_dstM=%h d_rvalA=%h d_rvalB=%h\n d_dstE=%h d_dstM=%h  r4=%h r5=%h r6=%h ",rst,clk,D_stall,D_bubble,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,
D_valP,D_stat,d_srcA,d_srcB,E_dstE,E_dstM,d_rvalA,d_rvalB,d_dstE,d_dstM,rsp,rbp,rsi);
	end
 endmodule
