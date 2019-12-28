module mux2 #(parameter WIDTH)(input[WIDTH-1:0] a,b,input f,output[WIDTH-1:0] out);
assign out=f?b:a;
endmodule
