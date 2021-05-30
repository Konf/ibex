module sha256_accelerator (
  input logic        sel_i,
  input logic [4:0]  operator_i,
  input logic [31:0] operand_a_i,
  input logic [31:0] operand_b_i,
  input logic [31:0] operand_c_i,
  
  output logic [31:0] result_o
);


logic [31:0] e0_result;
logic [31:0] e1_result;
logic [31:0] s0_result;
logic [31:0] s1_result;

logic [31:0] ch_result;
logic [31:0] maj_result;

e0 (.m (operand_a_i), 
    .n (e0_result));

e1 (.m(operand_a_i), 
    .n(e1_result));

s0 (.m(operand_a_i),
    .n(s0_result));

s1 (.m(operand_a_i),
    .n(s1_result));

ch (.m(operand_a_i), 
    .n(operand_b_i), 
    .o(operand_c_i), 
    .p(ch_result));

maj (.m(operand_a_i), 
     .n(operand_b_i), 
     .o(operand_c_i), 
     .p(maj_result));




  always_comb begin
    unique case (operator_i)
      5'b00000: result_o = e0_result;
      5'b00001: result_o = e1_result;
      5'b00010: result_o = s0_result;
      5'b00011: result_o = s1_result;
      5'b00100: result_o = ch_result;
      5'b00101: result_o = maj_result;
      default : result_o = 32'd0;
    endcase
  
  end



endmodule : sha256_accelerator


module e0 (m, n);
  input [31:0] m;
  output [31:0] n;
  assign n = {m[1:0],m[31:2]} ^ {m[12:0],m[31:13]} ^ {m[21:0],m[31:22]};
endmodule : e0

module e1 (m, n);
  input [31:0] m;
  output [31:0] n;
  assign n = {m[5:0],m[31:6]} ^ {m[10:0],m[31:11]} ^ {m[24:0],m[31:25]};
endmodule : e1

module ch (m, n, o, p);
  input [31:0] m, n, o;
  output [31:0] p;
  assign p = o ^ (m & (n ^ o));
endmodule : ch

module maj (m, n, o, p);
  input [31:0] m, n, o;
  output [31:0] p;
  assign p = (m & n) | (o & (m | n));
endmodule : maj

module s0 (m, n);
  input [31:0] m;
  output [31:0] n;
  assign n[31:29] = m[6:4] ^ m[17:15];
  assign n[28:0] = {m[3:0], m[31:7]} ^ {m[14:0],m[31:18]} ^ m[31:3];
endmodule : s0

module s1 (m, n);
  input [31:0] m;
  output [31:0] n;
  assign n[31:22] = m[16:7] ^ m[18:9];
  assign n[21:0] = {m[6:0],m[31:17]} ^ {m[8:0],m[31:19]} ^ m[31:10];
endmodule : s1