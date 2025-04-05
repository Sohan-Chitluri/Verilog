`include "INST_MEM.v"

module IFU(
    input clock, reset,
    output [3:0] Instruction_Code  
);

reg [3:0] PC = 4'b0000;  

INST_MEM instr_mem(PC, reset, Instruction_Code);

always @(posedge clock or posedge reset)
begin
    if (reset)  
        PC <= 4'b0000;  // Reset program counter
    else
        PC <= PC + 1;  // Increment PC by 1
end

endmodule
