module sl2(input[31:0] pc,output[31:0] sl2pc);
assign sl2pc={pc[29:0],2'd0};
endmodule
