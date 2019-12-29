module ff(input clk, input StallF,input[31:0] nextpc,output reg[31:0] pc);
always @(posedge clk)
begin
if(!StallF)
	pc<=nextpc;
else
	pc<=pc;
end

initial
begin
pc=32'd0;
end

endmodule
