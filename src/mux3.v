module mux3 #(parameter WIDTH)(input[WIDTH-1:0] a,b,c, input[1:0] f,output reg[WIDTH-1:0] out);
always @(*)
begin
if(f==2'b00)
	out=a;
else if(f==2'b01)
	out=b;
else//2'b10
	out=c;
end
endmodule
