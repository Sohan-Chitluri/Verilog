`include "CONTROL.v"
`include "DATAPATH.v"
`include "IFU.v"

module PROCESSOR( 
    input clock, 
    input reset,
    output zero
);

    wire [3:0] instruction_code;  
    wire [1:0] alu_control;       
    wire regwrite;

    IFU IFU_module(clock, reset, instruction_code);
	
    CONTROL control_module(instruction_code[3:2], instruction_code[1], instruction_code[0], alu_control, regwrite);
	
    DATAPATH datapath_module(instruction_code[2:1], instruction_code[3:2], instruction_code[1:0], alu_control, regwrite, clock, reset, zero);

endmodule
