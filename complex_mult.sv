module complex_mult
#(parameter DATA_WIDTH = 16) 

(
  input logic [DATA_WIDTH-1:0] a_re,
  input logic [DATA_WIDTH-1:0] a_im,
  input logic [DATA_WIDTH-1:0] b_re,
  input logic [DATA_WIDTH-1:0] b_im,

  output logic [DATA_WIDTH-1:0] c_re,
  output logic [DATA_WIDTH-1:0] c_im

);

  logic signed [(2*DATA_WIDTH)-1:0] mult_a_re_b_re; // ac
  assign mult_a_re_b_re = a_re * b_re;

  logic signed [(2*DATA_WIDTH)-1:0] mult_a_im_b_im; // bd
  assign mult_a_im_b_im = a_im * b_im;

  logic signed [(2*DATA_WIDTH)-1:0] mult_a_re_b_im; // ad
  assign mult_a_re_b_im = a_re * b_im;

  logic signed [(2*DATA_WIDTH)-1:0] mult_a_im_b_re; // bc
  assign mult_a_im_b_re = a_im * b_re;



  assign c_re = mult_a_re_b_re[(2*DATA_WIDTH)-1:DATA_WIDTH] - mult_a_im_b_im[(2*DATA_WIDTH)-1:DATA_WIDTH];
  assign c_im = mult_a_re_b_im[(2*DATA_WIDTH)-1:DATA_WIDTH] + mult_a_im_b_re[(2*DATA_WIDTH)-1:DATA_WIDTH];




endmodule