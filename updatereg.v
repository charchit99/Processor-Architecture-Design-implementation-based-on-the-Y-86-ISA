
module updatereg(in,enable,rst,resetval,clk,out);
parameter width = 64;
output reg [width-1:0] out;
input wire [width-1:0] in,resetval;
input wire enable,rst,clk;


always @(posedge clk)
begin
	if (rst)
		out <= resetval;
	else if (enable)
		out <= in;
end

endmodule


