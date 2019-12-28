# 5 stage mips cpu(verilog)
{: toc}
### 1. alu.v
###### * branch명령어와 jump명령어는 ALUopcode를 0000으로 setting

	module alu(
		input [3:0] ALUOp,
		input [31:0] a, b,
		output reg [31:0] out);
###### 1. input으로 4bit ALUopcode,  operand A,B를 decode stage로 받는다.
	wire [31:0] sub_ab;
	wire [31:0] add_ab;
	wire [31:0] mult_ab;
	assign sub_ab = a - b;
	assign add_ab = a + b;
	assign mult_ab = a * b;
###### 2. operand A,B의 계산값 sub, add, mult, slt를 조합회로로 구성한다.
	wire oflow_add, oflow_sub, oflow, slt;
	assign oflow_add = (a[31] == b[31] && 	add_ab[31] != a[31]) ? 1 : 0;
	assign oflow_sub = (a[31] == b[31] && 	sub_ab[31] != a[31]) ? 1 : 0;
	assign oflow = (ALUOp == 4'b0010) ? oflow_add : oflow_sub;
	assign slt = oflow_sub ? ~(a[31]) : a[31];
###### 3.  연산 간 overflow를 체크 하는 회로를 구성한다.  A가 양수인 경우 overflow가 나면 A<B이다. A가 음수인 경우 overflow가 안나면 A<B이다.  A가 양수의 경우 sub_overflow시 slt를 1로 set, 음수일 경우 slt를 0으로 set하면 된다.  즉 msb를 이용하면 한줄로 코드를 구성할 수 있다.
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
###### 4.  opcode에 따라 reg output에 값을 할당한다.


### 2. control.v
######
######
######
######
######
######
######
######
######


### 3. dm.v
######
######
######
######
######
######
######
######
######


### 4. ff.v
######
######
######
######
######
######
######
######
######


### 5. hazard.v
######
######
######
######
######
######
######
######
######


### 6. im.v
######
######
######
######
######
######
######
######
######


### 7. mips.v
######
######
######
######
######
######
######
######
######


### 8. mux2.v
######
######
######
######
######
######
######
######
######


### 9. mux3.v
######
######
######
######
######
######
######
######
######


### 10. p1.v
######
######
######
######
######
######
######
######
######


### 11. p2.v
######
######
######
######
######
######
######
######
######


### 12. p3.v
######
######
######
######
######
######
######
######
######

### 13. p4.v
######
######
######
######
######
######
######
######
######


### 14. pcplus4.v
######
######
######
######
######
######
######
######
######


### 15. rf.v
######
######
######
######
######
######
######
######
######


### 16. sl2.v
######
######
######
######
######
######
######
######
######


### 17. testbench.v 
######
######
######
######
######
######
######
######
######
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjYyNjk0MzQ2LDE0MDgxMDkwNzIsMTM3Nj
gwMTY2MCwxNTIxODQxMjIyLDUyMTMyMzc0NSwxNDQ4MTg2MzQ4
LC04MzI5OTIyNjcsMTgxMzQ0OTIxLC0xNTQzMzI2NjUwLDU1Nz
c0Mzk1MCwxMzU3MDI3MDYzLDU3MDQ0ODA3NSw2NDE5Mjc5Mzgs
LTIwNDcwNTI2MjddfQ==
-->