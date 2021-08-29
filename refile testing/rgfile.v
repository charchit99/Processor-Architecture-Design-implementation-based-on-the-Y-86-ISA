`include "define.v"
`include "updatereg.v"

module rgfile(rst,clk,W_dstE_i, W_valE_i, W_dstM_i, W_valM_i, d_srcA_i, d_rvalA_o, d_srcB_i, d_rvalB_o, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);

input wire [3:0] W_dstE_i,W_dstM_i,d_srcA_i,d_srcB_i;
input wire [63:0] W_valE_i,W_valM_i;
input wire rst,clk; 

output wire [63:0] d_rvalA_o,d_rvalB_o;
output wire [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi,
r8, r9, r10, r11, r12, r13, r14;


wire [63:0] rax_dat, rcx_dat, rdx_dat, rbx_dat, rsp_dat, rbp_dat, rsi_dat, rdi_dat,
r8_dat, r9_dat, r10_dat, r11_dat, r12_dat, r13_dat, r14_dat;

wire rax_wrt, rcx_wrt, rdx_wrt, rbx_wrt, rsp_wrt, rbp_wrt, rsi_wrt, rdi_wrt,
r8_wrt, r9_wrt, r10_wrt, r11_wrt, r12_wrt, r13_wrt, r14_wrt;


// Implement with clked registers

updatereg rax_reg(rax_dat, rax_wrt, rst, 64'b0, clk, rax);
updatereg rcx_reg(rcx_dat, rcx_wrt, rst, 64'b0, clk, rcx);
updatereg rdx_reg(rdx_dat, rdx_wrt, rst, 64'b0, clk, rdx);
updatereg rbx_reg(rbx_dat, rbx_wrt, rst, 64'b0, clk, rbx);
updatereg rsp_reg(rsp_dat, rsp_wrt, rst, 64'b0, clk, rsp);
updatereg rbp_reg(rbp_dat, rbp_wrt, rst, 64'b0, clk, rbp);
updatereg rsi_reg(rsi_dat, rsi_wrt, rst, 64'b0, clk, rsi);
updatereg rdi_reg(rdi_dat, rdi_wrt, rst, 64'b0, clk, rdi);
updatereg r8_reg(r8_dat, r8_wrt, rst, 64'b0, clk, r8);
updatereg r9_reg(r9_dat, r9_wrt, rst, 64'b0, clk, r9);
updatereg r10_reg(r10_dat, r10_wrt, rst, 64'b0, clk, r10);
updatereg r11_reg(r11_dat, r11_wrt, rst, 64'b0, clk, r11);
updatereg r12_reg(r12_dat, r12_wrt, rst, 64'b0, clk, r12);
updatereg r13_reg(r13_dat, r13_wrt, rst, 64'b0, clk, r13);
updatereg r14_reg(r14_dat, r14_wrt, rst, 64'b0, clk, r14);


// Reads occur like combinational logic

assign d_rvalA_o =
d_srcA_i == `RAX ? rax:
d_srcA_i == `RCX ? rcx:
d_srcA_i == `RDX ? rdx:
d_srcA_i == `RBX ? rbx:
d_srcA_i == `RSP ? rsp:
d_srcA_i == `RBP ? rbp:
d_srcA_i == `RSI ? rsi:
d_srcA_i == `RDI ? rdi:
d_srcA_i == `R8 ? r8:
d_srcA_i == `R9 ? r9:
d_srcA_i == `R10 ? r10:
d_srcA_i == `R11 ? r11:
d_srcA_i == `R12 ? r12:
d_srcA_i == `R13 ? r13:
d_srcA_i == `R14 ? r14:0;

assign d_rvalB_o =
d_srcB_i == `RAX ? rax:
d_srcB_i == `RCX ? rcx:
d_srcB_i == `RDX ? rdx:
d_srcB_i == `RBX ? rbx:
d_srcB_i == `RSP ? rsp:
d_srcB_i == `RBP ? rbp:
d_srcB_i == `RSI ? rsi:
d_srcB_i == `RDI ? rdi :
d_srcB_i == `R8 ? r8:
d_srcB_i == `R9 ? r9:
d_srcB_i == `R10 ? r10:
d_srcB_i == `R11 ? r11:
d_srcB_i == `R12 ? r12:
d_srcB_i == `R13 ? r13:
d_srcB_i == `R14 ? r14:0;



assign rax_dat = W_dstM_i == `RAX ? W_valM_i : W_valE_i;
assign rcx_dat = W_dstM_i == `RCX ? W_valM_i : W_valE_i;
assign rdx_dat = W_dstM_i == `RDX ? W_valM_i : W_valE_i;
assign rbx_dat = W_dstM_i == `RBX ? W_valM_i : W_valE_i;
assign rsp_dat = W_dstM_i == `RSP ? W_valM_i : W_valE_i;
assign rbp_dat = W_dstM_i == `RBP ? W_valM_i : W_valE_i;
assign rsi_dat = W_dstM_i == `RSI ? W_valM_i : W_valE_i;
assign rdi_dat = W_dstM_i == `RDI ? W_valM_i : W_valE_i;
assign r8_dat = W_dstM_i == `R8 ? W_valM_i : W_valE_i;
assign r9_dat = W_dstM_i == `R9 ? W_valM_i : W_valE_i;
assign r10_dat = W_dstM_i == `R10 ? W_valM_i : W_valE_i;
assign r11_dat = W_dstM_i == `R11 ? W_valM_i : W_valE_i;
assign r12_dat = W_dstM_i == `R12 ? W_valM_i : W_valE_i;
assign r13_dat = W_dstM_i == `R13 ? W_valM_i : W_valE_i;
assign r14_dat = W_dstM_i == `R14 ? W_valM_i : W_valE_i;


assign rax_wrt = W_dstM_i == `RAX | W_dstE_i == `RAX;
assign rcx_wrt = W_dstM_i == `RCX | W_dstE_i == `RCX;
assign rdx_wrt = W_dstM_i == `RDX | W_dstE_i == `RDX;
assign rbx_wrt = W_dstM_i == `RBX | W_dstE_i == `RBX;
assign rsp_wrt = W_dstM_i == `RSP | W_dstE_i == `RSP;
assign rbp_wrt = W_dstM_i == `RBP | W_dstE_i == `RBP;
assign rsi_wrt = W_dstM_i == `RSI | W_dstE_i == `RSI;
assign rdi_wrt = W_dstM_i == `RDI | W_dstE_i == `RDI;
assign r8_wrt = W_dstM_i == `R8 | W_dstE_i == `R8;
assign r9_wrt = W_dstM_i == `R9 | W_dstE_i == `R9;
assign r10_wrt = W_dstM_i == `R10 | W_dstE_i == `R10;
assign r11_wrt = W_dstM_i == `R11 | W_dstE_i == `R11;
assign r12_wrt = W_dstM_i == `R12 | W_dstE_i == `R12;
assign r13_wrt = W_dstM_i == `R13 | W_dstE_i == `R13;
assign r14_wrt = W_dstM_i == `R14 | W_dstE_i == `R14;

endmodule
