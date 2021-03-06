`include "define.v"

module controller(
    input wire [`ICODE_BUS] D_icode_i,
    input wire [`REG_ADDR_BUS] d_srcA_i,//D_rA_i,
    input wire [`REG_ADDR_BUS] d_srcB_i,//D_rB_i,
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`REG_ADDR_BUS] E_dstM_i,
    input wire e_Cnd_i,
    input wire [`ICODE_BUS] M_icode_i,
    input wire [`STAT_BUS] m_stat_i,
    input wire [`STAT_BUS] W_stat_i,

    output reg F_stall_o,
    output reg D_bubble_o,
    output reg D_stall_o,
    output reg E_bubble_o,
    output reg set_cc_o,
    output reg M_bubble_o,
    output reg W_stall_o
    );

    initial
        begin
            F_stall_o = 1'B0;
            D_bubble_o = 1'B0;
            D_stall_o = 1'B0;
            E_bubble_o = 1'B0;
            set_cc_o = 1'B1;
            M_bubble_o = 1'B0;
            W_stall_o = 1'B0;
        end

    always @(*)
        begin
            /* deal with exceptions */
            if(m_stat_i != `SAOK || W_stat_i != `SAOK)
                begin
                    F_stall_o = 1'B1;
                    D_stall_o = 1'B1;
                    set_cc_o = 1'B0;
                    M_bubble_o = 1'B1;
                    if(W_stat_i != `SAOK)
                        begin
                            W_stall_o = 1'B1;
                        end
                end
            /* deal with return */
            else if(M_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                    D_bubble_o = 1'B1;
                end
            /* deal with load/use risks */
            /*else if((E_icode_i == `MRMOVQ || E_icode_i == `POPQ) &&
                    E_dstM_i != `NREG && (D_rA_i == E_dstM_i || D_rB_i == E_dstM_i))*/
	   else if((E_icode_i == `MRMOVQ || E_icode_i == `POPQ) &&
                    ((E_dstM_i == d_srcB_i) ||((E_dstM_i == d_srcA_i) && !(D_icode_i == `RMMOVQ || D_icode_i == `PUSHQ))))
                begin
                    F_stall_o = 1'B1;
                    D_stall_o = 1'B1;
                    E_bubble_o = 1'B1;
                end
            /* deal with wrong predictions */
            else if(E_icode_i == `JXX && e_Cnd_i == 1'B0)
                begin
                    D_bubble_o = 1'B1;
                    E_bubble_o = 1'B1;
                end
            /* deal with return */
            else if(E_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                    D_bubble_o = 1'B1;
                end
            /* deal with return */
            else if(D_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                    D_bubble_o = 1'B1;
                end
            /* if every thing is ok */
            else
                begin
                    F_stall_o = 1'B0;
                    D_bubble_o = 1'B0;
                    D_stall_o = 1'B0;
                    E_bubble_o = 1'B0;
                    M_bubble_o = 1'B0;
                    W_stall_o = 1'B0;
		    if(D_icode_i == `OPQ)
		    begin
		    set_cc_o = 1'B1;
		    end
		    else
		    begin 
		    set_cc_o = 1'B0;
		    end
                end
        end

endmodule
