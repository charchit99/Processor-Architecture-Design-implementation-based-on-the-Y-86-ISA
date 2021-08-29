`include "define.v"

module prealu(    
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`IFUN_BUS] E_ifun_i,
    input wire [`DATA_BUS] E_valC_i,
    input wire [`DATA_BUS] E_valA_i,
    input wire [`DATA_BUS] E_valB_i,
    
    output reg [`DATA_BUS] aluA_o,
    output reg [`DATA_BUS] aluB_o,
    output reg [`IFUN_BUS] fun_o
    );
    
    always @(*)
        begin
		aluA_o = ((E_icode_i == `CXX | E_icode_i == `OPQ) ? E_valA_i :
		       	(E_icode_i == `IXX | E_icode_i == `RMMOVQ | E_icode_i == `MRMOVQ) ? E_valC_i : 
			(E_icode_i == `CALL | E_icode_i == `PUSHQ) ? -8 : 
			(E_icode_i == `RET | E_icode_i == `POPQ) ? 8 : 0);
		
		alu_o = ((E_icode_i == `RMMOVQ | E_icode_i == `MRMOVQ | E_icode_i == `OPQ | E_icode_i == `CALL | E_icode_i == `PUSHQ | E_icode_i == `RET | E_icode_i == `POPQ) ? E_valB_i :
		       	(E_icode_i == `CXX | E_icode_i == `IXX) ? 0 : 0);
		
		fun_o = ((E_icode_i == `OPQ) ? E_ifun_i : `ADDQ);
	end

endmodule
