`include "define.v"

module sourcendest(
    input wire [3:0] D_icode_i,
    input wire [3:0] D_rA_i,
    input wire [3:0] D_rB_i,
    
    output reg [3:0] d_srcA_o,
    output reg [3:0] d_srcB_o,
    output reg [3:0] d_dstE_o,
    output reg [3:0] d_dstM_o
    );
    
    always @(*)//(D_icode_i,D_rA_i,D_rB_i)
    begin
	    d_srcA_o = (D_icode_i == `CXX | D_icode_i == `RMMOVQ | D_icode_i == `OPQ | D_icode_i ==`PUSHQ) ? D_rA_i :
		    ((D_icode_i == `POPQ | D_icode_i == `RET) ? `RSP : `NREG);
	    d_srcB_o = (D_icode_i == `MRMOVQ | D_icode_i == `RMMOVQ | D_icode_i == `OPQ) ? D_rB_i :
                    ((D_icode_i == `POPQ | D_icode_i == `RET | D_icode_i == `CALL | D_icode_i == `PUSHQ) ? `RSP : `NREG);
	    d_dstE_o = (D_icode_i == `CXX | D_icode_i == `IXX | D_icode_i == `OPQ) ? D_rB_i :
                    ((D_icode_i == `POPQ | D_icode_i == `RET | D_icode_i == `CALL | D_icode_i == `PUSHQ) ? `RSP : `NREG);
	    d_srcB_o = (D_icode_i == `MRMOVQ | D_icode_i == `POPQ) ? D_rA_i : `NREG;
    end 
endmodule
