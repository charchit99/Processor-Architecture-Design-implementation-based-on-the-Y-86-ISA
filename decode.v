`include "define.v"

module decode(
    input wire [`ICODE_BUS]    D_icode_i,
    input wire [`ADDR_BUS]     D_valP_i,
    input wire [`REG_ADDR_BUS] d_srcA_i,
    input wire [`REG_ADDR_BUS] d_srcB_i,
    input wire [`DATA_BUS]     d_rvalA_i,
    input wire [`DATA_BUS]     d_rvalB_i,
    input wire [`REG_ADDR_BUS] e_dstE_i,
    input wire [`DATA_BUS]     e_valE_i,
    input wire [`REG_ADDR_BUS] M_dstE_i,
    input wire [`DATA_BUS]     M_valE_i,
    input wire [`REG_ADDR_BUS] M_dstM_i,
    input wire [`DATA_BUS]     m_valM_i,
    input wire [`REG_ADDR_BUS] W_dstE_i,
    input wire [`DATA_BUS]     W_valE_i,
    input wire [`REG_ADDR_BUS] W_dstM_i,
    input wire [`DATA_BUS]     W_valM_i,
    
    output reg [`DATA_BUS] d_valA_o,
    output reg [`DATA_BUS] d_valB_o
    );
    
    always @(*)
    begin
        case(D_icode_i)
            `CALL:
                begin
                    d_valA_o = D_valP_i;
                    case(d_srcB_i)
                        e_dstE_i:   d_valB_o = e_valE_i;
                        M_dstM_i:   d_valB_o = m_valM_i;
                        M_dstE_i:   d_valB_o = M_valE_i;
                        W_dstE_i:   d_valB_o = W_valE_i;
                        W_dstM_i:   d_valB_o = W_valM_i;
                        default:    d_valB_o = d_rvalB_i;
                    endcase
                end
            `JXX:
                begin
                     d_valA_o = D_valP_i;
                     case(d_srcB_i)
                        e_dstE_i:   d_valB_o = e_valE_i;
                        M_dstM_i:   d_valB_o = m_valM_i;
                        M_dstE_i:   d_valB_o = M_valE_i;
                        W_dstE_i:   d_valB_o = W_valE_i;
                        W_dstM_i:   d_valB_o = W_valM_i;
                        default:    d_valB_o = d_rvalB_i;
                    endcase
                end
            /*`HALT:
                begin
                    d_valA_o = `DATA_ZERO;
                    d_valB_o = `DATA_ZERO;
                end
            `NOP:
                begin
                    d_valA_o = `DATA_ZERO;
                    d_valB_o = `DATA_ZERO;
                end*///comments might have to be removed
            default:
                begin
                    case(d_srcA_i)
                        e_dstE_i:   d_valA_o = e_valE_i;
                        M_dstM_i:   d_valA_o = m_valM_i;
                        M_dstE_i:   d_valA_o = M_valE_i;
                        W_dstE_i:   d_valA_o = W_valE_i;
                        W_dstM_i:   d_valA_o = W_valM_i;
                        default:    d_valA_o = d_rvalA_i;
                    endcase
                                
                    case(d_srcB_i)
                        e_dstE_i:   d_valB_o = e_valE_i;
                        M_dstM_i:   d_valB_o = m_valM_i;
                        M_dstE_i:   d_valB_o = M_valE_i;
                        W_dstE_i:   d_valB_o = W_valE_i;
                        W_dstM_i:   d_valB_o = W_valM_i;
                        default:    d_valB_o = d_rvalB_i;
                    endcase
                end
        endcase
    end 
endmodule
