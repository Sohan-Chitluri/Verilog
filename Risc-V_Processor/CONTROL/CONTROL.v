module CONTROL(
    input [3:0] funct,    // Reduced funct field for 4-bit processor
    input [3:0] opcode,   // Reduced opcode
    output reg [2:0] alu_control, // Smaller control signal
    output reg regwrite_control
);
    always @(*)
    begin
        if (opcode == 4'b1100) begin // Example R-type opcode

            regwrite_control = 1;

            case (funct)
                4'b0000: alu_control = 3'b010; // ADD
                4'b0001: alu_control = 3'b100; // SUB
                4'b0010: alu_control = 3'b001; // OR
                4'b0011: alu_control = 3'b000; // AND
                4'b0100: alu_control = 3'b011; // SLL
                4'b0101: alu_control = 3'b101; // SRL
                4'b0110: alu_control = 3'b110; // MUL
                4'b0111: alu_control = 3'b111; // XOR
            endcase
        end
    end
endmodule
\