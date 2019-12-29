`timescale 1ns/1ns

module testbench;
reg CLK;

mips mips(CLK);

initial
begin
	CLK = 1'b0;
end

always
begin
	#50 CLK = ~CLK;
end
/*wire[31:0] a,b,out;
wire f;
assign a=32'd0;
assign b=32'd1;
assign f=1'd1;
mux2 #(32)m(a,b,f,out);*/
endmodule

