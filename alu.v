`include "define.v"

module alu(
    input wire [`DATA_BUS] aluA_i,
    input wire [`DATA_BUS] aluB_i,
    input wire [`IFUN_BUS] fun_i,
    
    output reg [`DATA_BUS] e_valE_o,
    output reg ZF_o,
    output reg SF_o,
    output reg OF_o
    );
    
    always @(*)
    begin
        case(fun_i)
            `ADDQ:
                begin
                    e_valE_o = aluA_i + aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[63];
                    OF_o = (aluA_i[63] == aluB_i[63]) && (aluA_i[63] != e_valE_o[63]);
                end
            `SUBQ:
                begin
                    e_valE_o = aluB_i - aluA_i;//aluA_i - aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[63];
                    OF_o = (aluA_i[63] != aluB_i[63]) && (aluB_i[63] != e_valE_o[63]);
		//(aluA_i[63] != aluB_i[63]) && (aluA_i[63] != e_valE_o[63]);		
                end
            `ANDQ:
                begin
                    e_valE_o = aluA_i & aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[63];
                    OF_o = 1'b0;
                end
            `XORQ:
                begin
                    e_valE_o = aluA_i ^ aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[63];
                    OF_o = 1'b0;
                end
            default:
                begin
                    e_valE_o = `DATA_ZERO;
                    ZF_o = 1'b1;
                    SF_o = 1'b0;
                    OF_o = 1'b0;
                end
        endcase
    end
    
endmodule
