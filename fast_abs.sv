module fast_abs
#(parameter DATA_WIDTH = 16) 
( input logic signed [DATA_WIDTH-1:0] data_re,
  input logic signed [DATA_WIDTH-1:0] data_im,

  output logic [DATA_WIDTH+1:0] data_abs
);

  logic [DATA_WIDTH-1:0] data_re_abs;
  logic [DATA_WIDTH-1:0] data_im_abs;

  assign data_re_abs = data_re[DATA_WIDTH-1] ? -data_re : data_re;
  assign data_im_abs = data_im[DATA_WIDTH-1] ? -data_im : data_im;


  logic a_b_cmp;
  assign a_b_cmp = (data_re_abs > data_im_abs);


  logic [DATA_WIDTH-1:0] max;
  logic [DATA_WIDTH-1:0] min;

  always_comb begin
    if (a_b_cmp) begin
      max = data_re_abs;
      min = data_im_abs;
    end
    else begin
      max = data_im_abs;
      min = data_re_abs;
    end
  end


  logic [DATA_WIDTH:0] max_plus_min_div2;


  // max + min/2
  assign max_plus_min_div2 = max + (min >> 1);

  // (max + min/2) - (1/16)*(max + min/2) = (15/16)*(max + min/2) 
  assign data_abs = max_plus_min_div2 - (max_plus_min_div2 >> 4);

endmodule