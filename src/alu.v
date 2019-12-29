module alu(
		input [3:0] ALUOp,
		input [31:0] a, b,
		output reg [31:0] out);
		//output zero);

wire [31:0] sub_ab;
wire [31:0] add_ab;
wire [31:0] mult_ab;
wire oflow_add, oflow_sub, oflow, slt;
//reg slt;

//assign zero = (0 == out); // true or false
assign sub_ab = a - b;
assign add_ab = a + b;
assign mult_ab = a * b;

// overflow detection
assign oflow_add = (a[31] == b[31] && add_ab[31] != a[31]) ? 1 : 0; // overflow
assign oflow_sub = (a[31] == b[31] && sub_ab[31] != a[31]) ? 1 : 0; // overflow, If the latter is greater in absolute value, oflow_sub is 1.
assign oflow = (ALUOp == 4'b0010) ? oflow_add : oflow_sub;
assign slt = oflow_sub ? ~(a[31]) : a[31];


always @(*) 
begin
	case (ALUOp)
		4'b0010  : out = add_ab;		/* add */
		4'b0000  : out = a & b;			/* and */
		4'b1000  : out = mult_ab;		/* mult */
		4'b1100  : out = ~(a | b);		/* nor */
		4'b0001  : out = a | b;			/* or */
		4'b0111  : out = {31'd0, slt};		/* slt */
		4'b0110  : out = sub_ab;		/* sub */
		4'b1101  : out = a ^ b;			/* xor */
		default  : out = 0;
	endcase
end
endmodule

