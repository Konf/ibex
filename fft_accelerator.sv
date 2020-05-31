module fft_accelerator (
  input logic        fft_sel_i,
  input logic [4:0]  fft_operator_i,
  input logic [31:0] fft_operand_a_i,
  input logic [31:0] fft_operand_b_i,
  input logic [31:0] fft_operand_c_i,
  
  output logic [31:0] fft_result_o
);


  logic [15:0] a_re;
  assign a_re = fft_operand_a_i[15:0];

  logic [15:0] a_im;
  assign a_im = fft_operand_a_i[31:16];

  logic [15:0] b_re;
  assign b_re = fft_operand_b_i[15:0];

  logic [15:0] b_im;
  assign b_im = fft_operand_b_i[31:16];

  logic [15:0] coeff_re;
  assign coeff_re = fft_operand_c_i[15:0];

  logic [15:0] coeff_im;
  assign coeff_im = fft_operand_c_i[31:16];



  logic [15:0] butterfly2_dit_c_re;
  logic [15:0] butterfly2_dit_c_im;

  logic [15:0] butterfly2_dit_d_re;
  logic [15:0] butterfly2_dit_d_im;


  butterfly2_dit
  #(.DATA_WIDTH (16)) 
  butterfly2_dit_inst
  (
  .a_re (a_re),
  .a_im (a_im),
  .b_re (b_re),
  .b_im (b_im),

  .coeff_re (coeff_re),
  .coeff_im (coeff_im),

  .c_re (butterfly2_dit_c_re),
  .c_im (butterfly2_dit_c_im),
  .d_re (butterfly2_dit_d_re),
  .d_im (butterfly2_dit_d_im)
  );



  logic [15:0] butterfly2_dif_c_re;
  logic [15:0] butterfly2_dif_c_im;

  logic [15:0] butterfly2_dif_d_re;
  logic [15:0] butterfly2_dif_d_im;

  butterfly2_dif 
  #(.DATA_WIDTH (16)) 
  butterfly2_dif_inst
  (
  .a_re (a_re),
  .a_im (a_im),
  .b_re (b_re),
  .b_im (b_im),

  .coeff_re (coeff_re),
  .coeff_im (coeff_im),

  .c_re (butterfly2_dif_c_re),
  .c_im (butterfly2_dif_c_im),
  .d_re (butterfly2_dif_d_re),
  .d_im (butterfly2_dif_d_im)
  );



  logic [31:0] fast_abs_result;


  fast_abs
  #(.DATA_WIDTH (16))
  fast_abs_inst
  (
  .data_re (a_re),
  .data_im (a_im),
  .data_abs (fast_abs_result)
  );



  always_comb begin
    unique case (fft_operator_i)
      5'b00000: fft_result_o = {butterfly2_dit_c_im, butterfly2_dit_c_re};
      5'b00001: fft_result_o = {butterfly2_dit_d_im, butterfly2_dit_d_re};
      5'b00010: fft_result_o = {butterfly2_dif_c_im, butterfly2_dif_c_re};
      5'b00011: fft_result_o = {butterfly2_dif_d_im, butterfly2_dif_d_re};
      5'b00100: fft_result_o = fast_abs_result;
      default : fft_result_o = 32'd0;
    endcase
  
  end


endmodule