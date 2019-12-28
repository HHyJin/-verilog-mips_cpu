# 5 stage mips cpu(verilog)
#### 1. alu.v
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
	assign oflow_add = (a[31] == b[31] && 	add_ab[31] != a[31]) ? 1 : 0; // overflow
	assign oflow_sub = (a[31] == b[31] && 	sub_ab[31] != a[31]) ? 1 : 0; // overflow, If the 	latter is greater in absolute value, oflow_sub is 1.
assign oflow = (ALUOp == 4'b0010) ? oflow_add : oflow_sub;
	assign slt = oflow_sub ? ~(a[31]) : a[31];
###### 3.  연산 간 overflow를 체크 하는 회로를 구성한다.
###### 
######
######
### 2. control.v
### 3. dm.v
### 4. ff.v
### 5. hazard.v
### 6. im.v
### 7. mips.v
### 8. mux2.v
### 9. mux3.v
### 10. p1.v
### 11. p2.v
### 12. p3.v
### 13. p4.v
### 14. pcplus4.v
### 15. rf.v
### 16. sl2.v
### 17. testbench.v 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4OTMwNTEyMjEsNTcwNDQ4MDc1LDY0MT
kyNzkzOCwtMjA0NzA1MjYyN119
-->