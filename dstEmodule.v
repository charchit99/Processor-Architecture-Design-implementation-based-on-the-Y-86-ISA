`include "define.v"

module dstEmodule(
    input wire e_Cnd_i,
    input wire [3:0] E_icode_i,
    input wire [3:0] E_dstE_i,
    
    output reg [3:0] e_dstE_o
    );

    always @(*)
    begin
	    e_dstE_o = (((E_icode_i == `CXX) & !e_Cnd_i) ? `NREG : E_dstE_i);
    end
endmodule
