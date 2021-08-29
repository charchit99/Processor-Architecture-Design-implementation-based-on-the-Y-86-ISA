`timescale 1ns / 1ps

module fetch_tb;
        // Inputs
        reg [79:0] inst;
	reg [63:0] f_pc;
        reg mem_error;
        // Outputs
        wire [3:0] f_icode,f_ifun,f_rA,f_rB;
        wire [63:0] f_valC,f_valP,f_predPC;
	wire [2:0] f_stat;

        fetch fetch0(
            .f_pc_i(f_pc),
            .inst_i(inst),
            .mem_error_i(mem_error),

            .f_icode_o(f_icode),
            .f_ifun_o(f_ifun),
            .f_rA_o(f_rA),
            .f_rB_o(f_rB),
            .f_valC_o(f_valC),
            .f_valP_o(f_valP),
            .f_predPC_o(f_predPC),
            .f_stat_o(f_stat)
      );
	
	initial begin
                // Initialize Inputs
                $dumpfile("fetch_tb.vcd");
                $dumpvars(0,fetch_tb);
		//clk <= 1'B0;
		mem_error <= 1'B0;
		f_pc <= 64'B001;
		inst <= 80'H00560000000000000000;
		#50;
		//clk <= 1'B1;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H10560000000000000000;
		#50
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H20560000000000000000;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H30560000000000000009;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H40560000000000000107;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H50560000000000000100;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H60560000000000000000;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H70560000000000000020;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H80560000000000000031;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'H90560000000000000000;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'HA0560000000000000000;
                #50;
		mem_error <= 1'B0;
                f_pc <= 64'B001;
                inst <= 80'HB0560000000000000000;
                #50;
                // Wait 100 ns for global reset to finish
                #100;

                // Add stimulus here
                /*#20 b=1;
                #20 a=1;b=0;
                #20 b=1;
                #20 a=0;b=0;cin=1;
                #20 b=1;
                #20 a=1;b=0;
                #20 b=1;*/
        end
	initial begin
		$monitor("f_pc=%d inst=%h mem_error=%d f_icode=%d f_ifun=%d f_rA=%d f_rB=%d f_valC=%d f_valP=%d f_predPC=%d f_stat=%d\n",f_pc,inst,mem_error,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_predPC,f_stat);
 
	end
 endmodule
