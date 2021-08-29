`include "define.v"

module cc(
    input wire clk,
    input wire rst,
    input wire ZF_i,
    input wire SF_i,
    input wire OF_i,
    input wire set_cc_i,
    output reg ZF_real_o,
    output reg SF_real_o,
    output reg OF_real_o
    );
	
    //“Set CC,”which determines whether or not to update the condition codes, has signals m_stat and W_stat as inputs. These signals are used to detect cases where an instruction causing an exception is passing through later pipeline stages, and therefore any updating of the condition codes should be suppressed. This has been taken care of by the controller module.


    initial
    begin
	    ZF_real_o <= 1'B1;
	    SF_real_o <= 1'B0;
	    OF_real_o <= 1'B0;
    end

    always @(posedge clk)
    begin
	    if(rst)
	    begin
		    ZF_real_o <= 1'B1;
		    SF_real_o <= 1'B0;
		    OF_real_o <= 1'B0;
	    end
	    else if(set_cc_i)
	    begin
		    ZF_real_o <= ZF_i;
                    SF_real_o <= SF_i;
                    OF_real_o <= OF_i;
	    end
    end
    
endmodule
