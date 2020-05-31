module butterfly2_dit
  #(parameter DATA_WIDTH = 16) 

(
  input logic [DATA_WIDTH-1:0] a_re,
  input logic [DATA_WIDTH-1:0] a_im,
  input logic [DATA_WIDTH-1:0] b_re,
  input logic [DATA_WIDTH-1:0] b_im,

  input logic [DATA_WIDTH-1:0] coeff_re,
  input logic [DATA_WIDTH-1:0] coeff_im,

  output logic [DATA_WIDTH-1:0] c_re,
  output logic [DATA_WIDTH-1:0] c_im,
  output logic [DATA_WIDTH-1:0] d_re,
  output logic [DATA_WIDTH-1:0] d_im
  );



  logic [DATA_WIDTH-1:0] mult_result_re; 
  logic [DATA_WIDTH-1:0] mult_result_im; 


  complex_mult
  #(.DATA_WIDTH (DATA_WIDTH)) 
  mult_unit
  (
    .a_re (b_re),
    .a_im (b_im),
    .b_re (coeff_re),
    .b_im (coeff_im),

    .c_re (mult_result_re),
    .c_im (mult_result_im)

  );



  logic [DATA_WIDTH-1:0] a_re_plus_mult_result_re;
  assign a_re_plus_mult_result_re = a_re + mult_result_re;

  logic [DATA_WIDTH-1:0] a_im_plus_mult_result_im;
  assign a_im_plus_mult_result_im = a_im + mult_result_im;

  logic [DATA_WIDTH-1:0] a_re_minus_mult_result_re;
  assign a_re_minus_mult_result_re = a_re - mult_result_re;

  logic [DATA_WIDTH-1:0] a_im_minus_mult_result_im;
  assign a_im_minus_mult_result_im = a_im - mult_result_im;



  assign c_re = a_re_plus_mult_result_re;
  assign c_im = a_im_plus_mult_result_im;  

  assign d_re = a_re_minus_mult_result_re;
  assign d_im = a_im_minus_mult_result_im;
 
endmodule
