module p4(input clk,
input[31:0] ReadDataM, ALUOutM, input[4:0] WriteRegM,
output reg[31:0] ReadDataW, ALUOutW, output reg[4:0] WriteRegW,
input RegWriteM, MemtoRegM,
output reg RegWriteW, MemtoRegW);
always @(posedge clk)
begin
ReadDataW<=ReadDataM;
ALUOutW<=ALUOutM;
WriteRegW<=WriteRegM;
MemtoRegW<=MemtoRegM;
RegWriteW<=RegWriteM;
end

endmodule
