`include "define.v"

module alu_args(
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
            case(E_icode_i)
                `CXX:
                    begin
                        aluA_o = E_valA_i;
                        aluB_o = `DATA_ZERO;
                        fun_o = `ADDQ;
                    end
                `IXX:
                    begin
			aluA_o = E_valC_i; //line added
                        aluB_o = `DATA_ZERO;//E_valC_i; //line changed
			fun_o = `ADDQ;                        
			/*if(E_ifun_i == `IRMOVQ)
                        begin
                            aluA_o = `DATA_ZERO;
                            fun_o = `ADDQ;
                        end
                        else
                        begin
                            aluA_o = E_valB_i;
                            fun_o = E_ifun_i - 1;
                        end*/
                    end
                `OPQ:
                    begin
                        aluA_o = E_valA_i;//E_valB_i;
                        aluB_o = E_valB_i;//E_valA_i;
                        fun_o = E_ifun_i;
                    end
                `RMMOVQ:
                    begin
                        aluA_o = E_valC_i;//E_valB_i;
                        aluB_o = E_valB_i;//E_valC_i;
                        fun_o = `ADDQ;
                    end
                `MRMOVQ:
                    begin
                        aluA_o = E_valC_i;//E_valA_i;
                        aluB_o = E_valB_i;//E_valC_i;
                        fun_o = `ADDQ;
                    end
                /*`JXX://this instruction doesn't need ALU
                    begin
                        aluA_o = `DATA_ZERO;
                        aluB_o = `DATA_ZERO;
                        fun_o = `NOPQ;
                    end*/
                `CALL://here we wanna do aluA + aluB = (-8) + (E_valB) = (E_valB) - (+8)
                    begin   
                        aluA_o = E_valB_i;
                        aluB_o = `DATA_WIDTH'H8;
                        fun_o = `SUBQ;
                    end
                `RET:
                    begin
                        aluA_o = `DATA_WIDTH'H8;//E_valB_i;
                        aluB_o = E_valB_i//`DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                `PUSHQ://again we wanna do aluA + aluB = (-8) + (E_valB) = (E_valB) - (+8)
                    begin   
                        aluA_o = E_valB_i;
                        aluB_o = `DATA_WIDTH'H8;
                        fun_o = `SUBQ;
                    end
                `POPQ:
                    begin
                        aluA_o = `DATA_WIDTH'H8;//E_valB_i;
                        aluB_o = E_valB_i;//`DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                default:
                    begin
                        aluA_o = `DATA_ZERO;
                        aluB_o = `DATA_ZERO;
                        fun_o = `NOPQ;
                    end
            endcase
        end
    
endmodule
