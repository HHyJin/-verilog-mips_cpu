module dm(input clk, WE, input[31:0] A, WD, output [31:0] RD);
reg[31:0] mem[0:31];
integer i;

initial begin
mem[0] = 32'd1; // for s0 = 1
for(i=1;i<10;i=i+1)
begin
mem[i]=32'd0;
end
mem[10] = 32'b0101_0101_1010_1010_0101_0101_1010_1010; // 0x55aa_55aa
mem[11] = 32'b0111_0111_1000_1000_0111_0111_1000_1000; // 0x7788_7788
end

always @(posedge clk)
begin
if(WE)
	mem[A]<=WD;
else
	mem[0]<=mem[0];
end
assign RD=mem[A];

endmodule
