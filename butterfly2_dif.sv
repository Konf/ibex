module butterfly2_dif 
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


  logic [DATA_WIDTH-1:0] a_plus_b_re;
  assign a_plus_b_re = a_re + b_re;

  logic [DATA_WIDTH-1:0] a_plus_b_im;
  assign a_plus_b_im = a_im + b_im;


  logic [DATA_WIDTH-1:0] a_minus_b_re;
  assign a_minus_b_re = a_re - b_re;

  logic [DATA_WIDTH-1:0] a_minus_b_im;
  assign a_minus_b_im = a_im - b_im;



  complex_mult
  #(.DATA_WIDTH (DATA_WIDTH)) 
  mult_unit
  (
    .a_re (a_minus_b_re),
    .a_im (a_minus_b_im),
    .b_re (coeff_re),
    .b_im (coeff_im),

    .c_re (d_re),
    .c_im (d_im)

  );


  assign c_re = a_plus_b_re;
  assign c_im = a_plus_b_im;  


endmodule
