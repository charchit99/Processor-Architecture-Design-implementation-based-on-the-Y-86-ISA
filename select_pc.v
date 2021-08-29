`include "define.v"

module select_pc(
    input wire M_Cnd_i,
    input wire [`ICODE_BUS] M_icode_i,
    input wire [`ICODE_BUS] W_icode_i,
    input wire [`ADDR_BUS] M_valA_i,
    input wire [`ADDR_BUS] W_valM_i,
    input wire [`ADDR_BUS] F_predPC_i,
    
    output reg [`ADDR_BUS] f_pc_o
    );
/*The PC selection logic chooses between three program counter sources. As amispredicted branch enters the memory stage, the value ofvalPfor this instruction(indicating the address of the following instruction) is read from pipeline registerM (signalM_valA). When aretinstruction enters the write-back stage, the returnaddress is read from pipeline register W (signalW_valM). All other cases use thepredicted value of the PC, stored in pipeline register F (signalF_predPC)*/    
    
always @(*)
        begin
            if(M_icode_i == `JXX && !M_Cnd_i)
            begin
                f_pc_o = M_valA_i;
            end
            else if(W_icode_i == `RET)
            begin
                f_pc_o = W_valM_i;
            end
            else
            begin
                f_pc_o = F_predPC_i;
            end
        end

endmodule
