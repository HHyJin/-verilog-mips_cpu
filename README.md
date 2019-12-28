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
###### 2. operand A,B의 계산값 sub, add, mult를 조합회로로 구성한다.
	wire oflow_add, oflow_sub, oflow, slt;
###### 3.  ㅇ
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
eyJoaXN0b3J5IjpbLTExMzM5MjMyNDMsNTcwNDQ4MDc1LDY0MT
kyNzkzOCwtMjA0NzA1MjYyN119
-->