# 5 stage mips cpu(verilog)
### 0. 목차  
>#### [1. alu.v](#1)  
#### [2. control.v](#2)  
#### [3. dm.v](#3)  
#### [4. ff.v](#4)  
#### [5. hazard.v](#5)  
#### [6. im.v](#6)  
#### [7. mips.v](#7)  
#### [8. mux2.v](#8)  
#### [9. mux3.v](#9)  
#### [10. p1.v](#10)  
#### [11. p2.v](#11)  
#### [12. p3.v](#12)  
#### [13. p4.v](#13)  
#### [14. pcplus4.v](#14)  
#### [15. rf.v](#15)  
#### [16. signex.v](#16)  
#### [17. sl2.v](#17)  
#### [18. testbench.v](#18)  



<a name="1"></a>
### 1.alu.v
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

<a name="2"></a>
### 2.control.v
######
######
######
######
######
######
######
######
######

<a name="3"></a>
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

<a name="4"></a>
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

<a name="5"></a>
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

<a name="6"></a>
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

<a name="7"></a>
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

<a name="8"></a>
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

<a name="9"></a>
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

<a name="10"></a>
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

<a name="11"></a>
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

<a name="12"></a>
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


<a name="13"></a>
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

<a name="14"></a>
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

<a name="15"></a>
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

<a name="16"></a>
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

<a name="17"></a>
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
eyJoaXN0b3J5IjpbLTY4MDk1ODEyMCwxNjU1MTQ1NzQ2LC0xND
czMjk4ODIyLDE1MDU1NDgyMjgsMTQzNTUyOTEyNiwtMTA3NjE1
ODg4MSwtMjA0MTU5MDMwNSwtMjE3OTE0NDI2LDI2MjY5NDM0Ni
wxNDA4MTA5MDcyLDEzNzY4MDE2NjAsMTUyMTg0MTIyMiw1MjEz
MjM3NDUsMTQ0ODE4NjM0OCwtODMyOTkyMjY3LDE4MTM0NDkyMS
wtMTU0MzMyNjY1MCw1NTc3NDM5NTAsMTM1NzAyNzA2Myw1NzA0
NDgwNzVdfQ==
-->