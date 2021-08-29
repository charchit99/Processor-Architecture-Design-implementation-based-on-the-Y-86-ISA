`timescale 1ns / 1ps

`include "alu.v"
`include "prealu.v"
`include "controller.v"
`include "decode.v"
`include "sourcendest.v"
`include "cc.v"
`include "cond.v"
`include "dstEmodule.v"
`include "decode_reg.v"
`include "define.v"
`include "d_mem.v"
`include "execute_reg.v"
`include "fetch.v"
`include "fetch_reg.v"
`include "i_mem.v"
`include "mem.v"
`include "mem_reg.v"
`include "registers.v"
`include "select_pc.v"
`include "set_cond.v"
`include "set_m_stat.v"
`include "write_reg.v"
//`include "processor.v"


module proc_tb;
        // Inputs
        reg [79:0] inst;
	reg [63:0] data_i;
        reg d_mem_error,i_mem_error,rst,clk;
        // Outputs
        wire [63:0] data_o,addr,pc;
	wire write;


        processor proc0(
            .rst_i(rst),
            .inst_i(inst),
            .i_mem_error_i(i_mem_error),
	    .d_mem_error_i(d_mem_error),
	    .clk_i(clk),
	    .data_i(data_i),

	    .dato_o(data_o),
	    .write_o(write),
	    .pc_o(pc),
	    .addr_o(addr)
      );
	
	initial begin
                // Initialize Inputs
                $dumpfile("proc_tb.vcd");
                $dumpvars(0,proc_tb);
		clk = 1'B0;
		i_mem_error = 1'B0;
		d_mem_error = 1'B0;
		rst = 1'B0;
		data_i = 64'B0;
		inst = 80'H00560000000000000000;
		#50;
                i_mem_error = 1'B0;
                d_mem_error = 1'B0;
                rst = 1'B0;
                data_i = 64'B0;
		inst = 80'H30560200000000000000;//sending 2 to reg 6
                clk = ~clk;
		#50;
		clk = ~clk;
		#50 $stop;
		/*i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H30450300000000000000;//sending 3 to reg 5
                clk <= ~clk;
                #50
                clk <= ~clk;
                #50
		i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H60560000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;
		i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H00000000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;
		 i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H00000000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;
		 i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H00000000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;
		 i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H00000000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;
		 i_mem_error <= 1'B0;
                d_mem_error <= 1'B0;
                rst <= 1'B0;
                data_i <= 64'B0;
                inst <= 80'H00000000000000000000;
                clk <= ~clk;
                #50;
                clk <= ~clk;
                #50;*/

        end

	initial begin
		$monitor("rst=%b inst=%h i_mem_error=%b d_mem_error=%b clk=%b data_i=%h data_o=%h write=%b pc=%h addr=%h \n",rst,inst,i_mem_error,d_mem_error,clk,data_i,data_o,write,pc,addr);
	end
 

endmodule
