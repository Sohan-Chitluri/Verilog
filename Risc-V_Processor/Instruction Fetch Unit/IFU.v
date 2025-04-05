`include "INST_MEM.v"

module IFU(
    input clock, reset,
    output [3:0] Instruction_Code  // 4-bit instruction output
);

reg [3:0] PC = 4'b0000;  // 4-bit Program Counter initialized to zero

// Initializing the instruction memory block
INST_MEM instr_mem(PC, reset, Instruction_Code);

always @(posedge clock or posedge reset)
begin
    if (reset)  
        PC <= 4'b0000;  // Reset program counter
    else
        PC <= PC + 1;  // Increment PC by 1
end

endmodule
