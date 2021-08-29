`timescale 1ns / 1ps
`include "define.v"


module dreg_tb;
    reg rst,clk,D_stall_i,D_bubble_i;
    reg [3:0] f_icode_i,f_ifun_i,f_rA_i,f_rB_i;
    reg [`DATA_BUS] f_valC_i;
    reg [`ADDR_BUS] f_valP_i;
    reg [`STAT_BUS] f_stat_i;
    
    wire [`ICODE_BUS] D_icode_o,D_ifun_o,D_rA_o,D_rB_o;
    wire [`DATA_BUS] D_valC_o;
    wire [`ADDR_BUS] D_valP_o;
    wire [`STAT_BUS] D_stat_o;
	
decode_reg dreg0(
    rst,
    clk,
    D_stall_i,
    D_bubble_i,
    f_icode_i,
    f_ifun_i,
    f_rA_i,
    f_rB_i,
    f_valC_i,
    f_valP_i,
    f_stat_i,
    
    D_icode_o,
    D_ifun_o,
    D_rA_o,
    D_rB_o,
    D_valC_o,
    D_valP_o,
    D_stat_o
    );
	
    initial begin
                // Initialize Inputs
                $dumpfile("dreg_tb.vcd");
                $dumpvars(0,dreg_tb);
		clk <= 1'B0;
		//#50;
		//clk <= ~clk;
		rst <= 1'B0;
		D_stall_i <= 1'B0;
		D_bubble_i <= 1'B0;
		f_icode_i <= 4'H6;
		f_ifun_i <= 4'H0;
		f_rA_i <= 4'H5;
		f_rB_i <= 4'H6;
		f_valP_i <= 64'H2;
		f_valC_i <= 64'H8;
		f_stat_i <= 3'B0;
		#50;

		clk <= ~clk;
                #50;
                clk <= ~clk;
                rst <= 1'B0;
                D_stall_i <= 1'B0;
                D_bubble_i <= 1'B1;
                f_icode_i <= 4'H6;
                f_ifun_i <= 4'H0;
                f_rA_i <= 4'H5;
                f_rB_i <= 4'H6;
                f_valP_i <= 64'H2;
                f_valC_i <= 64'H8;
                f_stat_i <= 3'B0;
                #50;

		clk <= ~clk;
                #50;
                clk <= ~clk;
                rst <= 1'B0;
                D_stall_i <= 1'B0;
                D_bubble_i <= 1'B0;
                f_icode_i <= 4'H3;
                f_ifun_i <= 4'H0;
                f_rA_i <= 4'H5;
                f_rB_i <= 4'H6;
                f_valP_i <= 64'H2;
                f_valC_i <= 64'H8;
                f_stat_i <= 3'B0;
                #50;
		clk <= ~clk;
                #50;

        end
	initial begin
		$monitor("rst=%b clk=%b D_stall_i=%b D_bubble_i=%b f_icode_i=%h f_ifun_i=%h f_rA_i=%h f_rB_i=%h f_valC_i=%h f_valP_i=%h f_stat_i=%b D_icode_o=%b D_ifun_o=%h D_rA_o=%h D_rB_o=%h D_valC_o=%h D_valP_o=%h D_stat_o=%b",rst,clk,D_stall_i,D_bubble_i,f_icode_i,f_ifun_i,f_rA_i,f_rB_i,f_valC_i,f_valP_i,f_stat_i,D_icode_o,D_ifun_o,D_rA_o,D_rB_o,D_valC_o,D_valP_o,D_stat_o);
	end
 endmodule
