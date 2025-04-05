module ALU (
    input [3:0] in1, in2, 
    input [3:0] alu_control,
    output reg [3:0] alu_result,
    output reg zero_flag
);
    always @(*)
    begin
        case(alu_control)
            4'b0000: alu_result = in1 & in2;
            4'b0001: alu_result = in1 | in2;
            4'b0010: alu_result = in1 + in2;
            4'b0100: alu_result = in1 - in2;
            4'b1000: alu_result = (in1 < in2) ? 4'b0001 : 4'b0000; // SLT
            4'b0011: alu_result = in1 << in2[1:0]; // SLL (limited shift)
            4'b0101: alu_result = in1 >> in2[1:0]; // SRL (limited shift)
            4'b0110: alu_result = in1 * in2;   // MUL
            4'b0111: alu_result = in1 ^ in2;   // XOR
            default: alu_result = 4'b0000; // Default case
        endcase

        // Setting Zero_flag if ALU_result is zero
        zero_flag = (alu_result == 4'b0000) ? 1'b1 : 1'b0;
    end
endmodule
