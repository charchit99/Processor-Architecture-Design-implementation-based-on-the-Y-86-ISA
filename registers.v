`include "define.v"

module registers(
    input wire clk,
    input wire rst,
    input wire [`REG_ADDR_BUS]W_dstM_i,
    input wire [`REG_ADDR_BUS]W_dstE_i,
    input wire [`DATA_BUS]W_valM_i,
    input wire [`DATA_BUS]W_valE_i,
    input wire [`REG_ADDR_BUS]d_srcA_i,
    input wire [`REG_ADDR_BUS]d_srcB_i,
    
    output reg [`DATA_BUS]d_rvalA_o,
    output reg [`DATA_BUS]d_rvalB_o
    );
    
    reg [`DATA_BUS]registers[0:`NREG];//creating 16 8-byte registers
    
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && W_dstM_i < `NREG)
            begin
                registers[W_dstM_i] <= W_valM_i;
            end
        end
        
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && W_dstE_i < `NREG)
            begin
                registers[W_dstE_i] <= W_valE_i;
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || d_srcA_i >= `NREG)
            begin
                d_rvalA_o = `DATA_ZERO;
            end
            else if(d_srcA_i == W_dstM_i)
            begin
                d_rvalA_o = W_valM_i;
            end
            else if(d_srcA_i == W_dstE_i)
            begin
                 d_rvalA_o = W_valE_i;
            end
            else
            begin
                d_rvalA_o = registers[d_srcA_i];
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || d_srcB_i >= `NREG)
            begin
                d_rvalB_o = `DATA_ZERO;
            end
            else if(d_srcB_i == W_dstM_i)
            begin
                d_rvalB_o = W_valM_i;
            end
            else if(d_srcB_i == W_dstE_i)
            begin
                d_rvalB_o = W_valE_i;
            end
            else
            begin
                d_rvalB_o = registers[d_srcB_i];
            end
        end
endmodule
