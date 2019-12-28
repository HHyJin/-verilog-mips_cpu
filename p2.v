module p2(input clk,
input RegWriteD, MemtoRegD, MemWriteD, input[3:0] ALUControlD, input ALUSrcD, RegDstD, // input control bits
output reg RegWriteE,MemtoRegE, MemWriteE,output reg[3:0] ALUControlE, output reg ALUSrcE,RegDstE,//output control bits
input FlushE,//hazard check bit
input[31:0] RD1D,RD2D,input[4:0] RsD,RtD,RdD,input reg[31:0] SignImmD,
output reg[31:0] RD1E,RD2E,output reg[4:0] RsE,RtE,RdE,output reg[31:0] SignImmE);
always @(posedge clk)
begin
if(!FlushE) begin
	RegWriteE<=RegWriteD;
	MemtoRegE<=MemtoRegD;
	MemWriteE<=MemWriteD;
	ALUControlE<=ALUControlD;
	ALUSrcE<=ALUSrcD;
	RegDstE<=RegDstD;
	RD1E<=RD1D;
	RD2E<=RD2D;
	RsE<=RsD;
	RtE<=RtD;
	RdE<=RdD;
	SignImmE<=SignImmD;
	end
else begin
	RegWriteE<=1'd0;
	MemtoRegE<=1'd0;
	MemWriteE<=1'd0;
	ALUControlE<=3'd0;
	ALUSrcE<=1'd0;
	RegDstE<=1'd0;
	RD1E<=32'd0;
	RD2E<=32'd0;
	RsE<=5'd0;
	RtE<=5'd0;
	RdE<=5'd0;
	SignImmE<=32'd0;
	end
	

end

endmodule

