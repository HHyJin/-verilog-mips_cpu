module signex(input[15:0] imm, output[31:0] extended);
assign extended={ {16{imm[15]}}, imm};
endmodule

