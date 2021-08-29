`include "define.v"

module cond(
    input wire [3:0] E_ifun_i,
    input wire ZF_real_i,
    input wire SF_real_i,
    input wire OF_real_i,
    
    output reg e_Cnd_o
    );

    always @(*)
    begin
	    e_Cnd_o = ((E_ifun_i == `JMP) | 
	(E_ifun_i == `JLE & ((SF_real_i^OF_real_i)|ZF_real_i)) |
	(E_ifun_i == `JL & (SF_real_i^OF_real_i)) |
	(E_ifun_i == `JE & ZF_real_i) |
	(E_ifun_i == `JNE & !ZF_real_i) |
	(E_ifun_i == `JGE & ((!SF_real_i)^OF_real_i)) |
	(E_ifun_i == `JG & ((!SF_real_i)^OF_real_i)&(!ZF_real_i)));

    end
    endmodule
