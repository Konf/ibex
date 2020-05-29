module custom0_stub (
  input logic        custom0_sel_i,
  input logic [4:0]  custom0_operator_i,
  input logic [31:0] custom0_operand_a_i,
  input logic [31:0] custom0_operand_b_i,
  input logic [31:0] custom0_operand_c_i,
  
  output logic [31:0] custom0_result_o
);


  always_comb begin
    unique case (custom0_operator_i)
      5'b00000: custom0_result_o = custom0_operand_a_i + 4;
      5'b00001: custom0_result_o = custom0_operand_b_i + 10;
      5'b00010: custom0_result_o = custom0_operand_c_i - 10;
      5'b00011: custom0_result_o = custom0_operand_a_i + custom0_operand_b_i;
      default : custom0_result_o = 32'd0;

    endcase 
  
  end


endmodule