module control(input[5:0] Op,Funct, output reg RegWriteD, MemtoRegD,MemWriteD,output reg[3:0] ALUControlD, output reg ALUSrcD, RegDstD, BranchD,JToPCD);
always @(*)
begin
	case (Op)
		6'b000000 : begin // R Type - add, sub, and, or, slt
			RegDstD = 1; RegWriteD = 1; ALUSrcD = 0; MemWriteD = 0; MemtoRegD = 0; JToPCD = 0; BranchD = 0;
			if(Funct == 6'b100000)	ALUControlD = 4'b0010; // add
			else if(Funct == 6'b100010) ALUControlD = 4'b0110; // sub
			else if(Funct == 6'b100100) ALUControlD = 4'b0000; // and
			else if(Funct == 6'b100101) ALUControlD = 4'b0001; // or
			else if(Funct == 6'b101010) ALUControlD = 4'b0111; // slt
			else if(Funct == 6'b011000) ALUControlD = 4'b1000; // mult
			else if(Funct == 6'b100110) ALUControlD = 4'b1101; // xor 
			else if(Funct == 6'b100111) ALUControlD = 4'b1100; // nor
			else ALUControlD = 4'b0000; // To avoid creating a latch
		end
		6'b100011 : begin // Load Word
			RegDstD = 0; RegWriteD = 1; ALUSrcD = 1; MemWriteD = 0; MemtoRegD = 1; JToPCD = 0; BranchD = 0;
			ALUControlD = 4'b0010; // add for lw
		end
		6'b101011 : begin // Store Word
			            RegWriteD = 0; ALUSrcD = 1; MemWriteD = 1; JToPCD = 0; BranchD = 0;
			ALUControlD = 4'b0010; // add for sw
			RegDstD = 0; MemtoRegD = 0; // To avoid creating a latch
		end
		6'b000100 : begin // Beq
				    RegWriteD = 0; ALUSrcD = 0; MemWriteD = 0; JToPCD = 0; BranchD = 1;
			ALUControlD = 4'b0110; // sub for beq
			RegDstD = 0; MemtoRegD = 0; // To avoid creating a latch
		end
		6'b000010 : begin// Jump
				    RegWriteD = 0; MemWriteD = 0; JToPCD = 1; BranchD= 0;
			RegDstD = 0; ALUSrcD = 0; MemtoRegD = 0; ALUControlD = 4'b0000; // To avoid creating a latch
		end
		default : begin // To avoid creating a latch
			RegDstD = 0; RegWriteD = 0; ALUSrcD = 0; MemWriteD = 0; MemtoRegD = 0; JToPCD = 0; BranchD = 0;
			ALUControlD = 4'b0000; 
		end
	endcase
end

initial
begin
	RegDstD = 0; RegWriteD = 0; ALUSrcD = 0; MemWriteD = 0; MemtoRegD = 0; JToPCD = 0; BranchD = 0;
	ALUControlD = 4'b0000;
end
endmodule
