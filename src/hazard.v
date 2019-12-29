module hazard(input BranchD, input[4:0] RsD,RtD,RsE,RtE,input MemtoRegE,RegWriteE,RegWriteM,RegWriteW ,input[4:0] WriteRegE, WriteRegM, WriteRegW,
output reg StallF, StallD, ForwardAD,ForwardBD,FlushE,output reg[1:0] ForwardAE,ForwardBE);
always @(*)
begin
if((RsE!=0) && (RsE==WriteRegM) && RegWriteM)
	ForwardAE=2'b10;
else if((RsE!=0) && (RsE==WriteRegW) && RegWriteW)
	ForwardAE=2'b01;
else
	ForwardAE=2'b00;
end
always @(*)
begin
if((RtE!=0) && (RtE==WriteRegM) && RegWriteM)
	ForwardBE=2'b10;
else if((RtE!=0) && (RtE==WriteRegW) && RegWriteW)
	ForwardBE=2'b01;
else
	ForwardBE=2'b00;
end
wire lwstall, branchstall;
initial
begin
StallF=1'd0;
StallD=1'd0;
ForwardAD=1'd0;
ForwardBD=1'd0;
FlushE=1'd0;
ForwardAE=1'd0;
ForwardBE=1'd0;
end
always @(*)
begin
if((RsD!=1'd0)&&(RsD==WriteRegM) && RegWriteM)
	ForwardAD=1'd1;
else
	ForwardAD=1'd0;
end
always @(*)
begin
if((RtD!=1'd0)&&(RtD==WriteRegM) && RegWriteM)
	ForwardBD=1'd1;
else
	ForwardBD=1'd0;
end

assign lwstall=(((RsD==RtE) || (RtD==RtE)) && MemtoRegE);//lw stall 1
//assign ForwardAD=((RsD!=0)&&(RsD==WriteRegM) && RegWriteM);
//assign ForwardBD=((RtD!=0)&&(RtD==WriteRegM) && RegWriteM);
assign branchstall=((BranchD && RegWriteE && ((WriteRegE==RsD) || (WriteRegE==RtD))) || (BranchD && RegWriteM && ((WriteRegM==RsD) || (WriteRegM==RtD))));
always @(*)
begin
if(lwstall||branchstall) begin
	StallF=1'd1;
	StallD=1'd1;
	FlushE=1'd1;
end
else begin
	StallF=1'd0;
	StallD=1'd0;
	FlushE=1'd0;
end
end

//assign {StallF,StallD,FlushE}={3{lwstall || branchstall}};
endmodule

