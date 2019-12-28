module p1(input clk, 
input[31:0] instrF, PCplus4F,
input StallD, PCSrcD,
output reg[31:0] instrD,PCplus4D);
always @(posedge clk)
begin
if(!StallD && !PCSrcD) begin//not branch
	instrD<=instrF;
	PCplus4D<=PCplus4F;
	end
else if(StallD && !PCSrcD) begin//branch but not jump
	instrD<=instrD;
	PCplus4D<=PCplus4D;
	end
else 
	begin//branch jump
	instrD<=32'd0;
	PCplus4D<=32'd0;
	end
end
endmodule

