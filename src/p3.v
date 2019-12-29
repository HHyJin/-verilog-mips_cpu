module p3(input clk,
input[31:0] ALUOutE, WriteDataE, input[4:0] WriteRegE,//input data
output reg[31:0] ALUOutM, WriteDataM, output reg[4:0] WriteRegM,//output data
input RegWriteE, MemtoRegE, MemWriteE,//input control
output reg RegWriteM, MemtoRegM,MemWriteM);//output control
always @(posedge clk)
begin
ALUOutM<=ALUOutE;
WriteDataM<=WriteDataE;
WriteRegM<=WriteRegE;
RegWriteM<=RegWriteE;
MemtoRegM<=MemtoRegE;
MemWriteM<=MemWriteE;
end
endmodule
