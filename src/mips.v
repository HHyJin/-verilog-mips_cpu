module mips(input clk);
wire[31:0] pcPrime;
wire[31:0] pcF;
wire[31:0] pcPlus4F;
wire[31:0] RDF;
wire[31:0] pcBranchD;
wire[31:0] pcPlus4D;
wire[31:0] instrD;
wire RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, BranchD;
wire[3:0] ALUControlD;
wire[31:0] ResultW,RD1,RD2;
wire RegWriteW;
wire JtoPCD;
wire[4:0] WriteRegW;
wire RegWriteE, MemtoRegE,MemWriteE,ALUSrcE,RegDstE,FlushE;
wire[3:0] ALUControlE;
wire[31:0] RD1E,SignImmE;
wire[4:0] RsE,RtE,RdE;
wire ForwardAD, ForwarddBD;
wire[31:0] ALUOutM;
wire[31:0] muxRD1D,muxRD2D;
wire EqualD;
wire[4:0] RsD,RtD,RdD;
wire[31:0] SignImmD, sl2SignImmD;
wire[1:0] ForwardAE,ForwardBE;
wire[31:0] muxRD1E,muxRD2E;
wire[31:0] SrcBE;
wire[4:0] WriteRegE;
wire[31:0] ALUOutE;
wire[31:0] RD2E;
wire[31:0] WriteDataM;
wire[4:0] WriteRegM;
wire RegWriteM,MemtoRegM,MemWriteM;
wire[31:0] RDM;
wire[31:0] ReadDataW,ALUOutW;
wire MemtoRegW;
wire[31:0] pcNext;
assign pcPlus4F=pcF+32'd4;
assign pcBranchD=sl2SignImmD+pcPlus4D;
assign EqualD=(muxRD1D==muxRD2D);
assign pcSrcD=(BranchD&EqualD);
wire[31:0] pcJumpD;
assign pcJumpD={4'd0,instrD[25:0],2'd0};
wire clear;
assign clear=pcSrcD|JtoPCD;
//Fetch
mux2 #(32)branchpcmux(pcPlus4F,pcBranchD,pcSrcD,pcPrime);
mux2 #(32)Jtopcmux(pcPrime,pcJumpD,JtoPCD,pcNext);
ff pcff(clk,StallF,pcNext,pcF);
im imem(pcF[8:2],RDF);
p1 pipe1(clk,RDF,pcPlus4F,StallD,clear,instrD,pcPlus4D);

//Decode
control c(instrD[31:26], instrD[5:0], RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD,JtoPCD);
rf regsiterFile(instrD[25:21],instrD[20:16],WriteRegW, ResultW,clk,RegWriteW,RD1,RD2);
signex signex(instrD[15:0],SignImmD);
sl2 sl2(SignImmD,sl2SignImmD);
mux2 #(32) famux2(RD1,ALUOutM,ForwardAD,muxRD1D);
mux2 #(32) fbmux2(RD2,ALUOutM,ForwardBD,muxRD2D);
p2 pipe2(clk, RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,
RegWriteE,MemtoRegE,MemWriteE,ALUControlE,ALUSrcE,RegDstE,
FlushE,
RD1,RD2,instrD[25:21],instrD[20:16],instrD[15:11],SignImmD,
muxRD1E,muxRD2E,RsE,RtE,RdE,SignImmE);
//ALU
mux3 #(32)famux3(muxRD1E,ResultW,ALUOutM,ForwardAE,RD1E);
mux3 #(32)fbmux3(muxRD2E,ResultW,ALUOutM,ForwardBE,RD2E);//muxRD2E is WriteDataE if SW
mux2 #(32)alusrcmux(RD2E,SignImmE,ALUSrcE,SrcBE);
mux2 #(5)wrregmux(RtE,RdE,RegDstE,WriteRegE);
alu alu(ALUControlE,RD1E,SrcBE,ALUOutE);
p3 pipe3(clk, ALUOutE,WriteRegE,WriteRegE,ALUOutM,WriteDataM,WriteRegM,RegWriteE,MemtoRegE,MemWriteE,RegWriteM,MemtoRegM,MemWriteM);
//memory
dm datam(clk,MemWriteW,ALUOutM,WriteDataM,RDM);
p4 pipe4(clk,RDM,ALUOutM,WriteRegM,ReadDataW,ALUOutW,WriteRegW,RegWriteM,MemtoRegM,RegWriteW,MemtoRegW);
//WB
mux2 #(32)WBmux(ALUOutW,ReadDataW,MemtoRegW,ResultW);
//hazard
hazard h(BranchD,instrD[25:21],instrD[20:16],RsE,RtE,MemtoRegE,RegWriteE,RegWriteM,RegWriteW,WriteRegE,WriteRegM,WriteRegW,StallF,StallD,ForwardAD,ForwardBD,FlushE,ForwardAE,ForwardBE);
endmodule
