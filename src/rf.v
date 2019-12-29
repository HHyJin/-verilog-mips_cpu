module rf(input[4:0] A1,A2,A3,input[31:0] WD3,input clk,RegWriteW,
output reg[31:0] RD1,RD2);
reg[31:0] mem[0:31];
initial
begin
mem[0]=32'd0;
end
//only read not forwarding
//assign RD1=mem[A1];
//assign RD2=mem[A2];

always @(posedge clk)
begin
if(RegWriteW && A3!=5'd0)
	mem[A3]<=WD3;
else
	mem[0]<=32'd0; 
end
//write back add forwarding
always @(*)
begin
if(RegWriteW && A1==A3)begin
	RD1=WD3;
	RD2=mem[A2];	
	end
else if(RegWriteW && A2==A3)begin
	RD1=mem[A1];
	RD2=WD3;
	end
else begin
	RD1=mem[A1];
	RD2=mem[A2];
	end
end

endmodule
