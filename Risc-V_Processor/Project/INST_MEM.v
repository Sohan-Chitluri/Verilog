module INST_MEM(
    input [3:0] PC,      
    input reset,
    output reg [3:0] Instruction_Code  
);

    reg [3:0] Memory [15:0];

    // Assign instruction based on PC value
    always @(*) begin
        Instruction_Code = Memory[PC];  
    end

    // Initialize memory when reset is 1
    always @(posedge reset) begin
        if (reset) begin
            Memory[0]  = 4'b0001;  
            Memory[1]  = 4'b0010;  
            Memory[2]  = 4'b0100;  
            Memory[3]  = 4'b0110;  
            Memory[4]  = 4'b1000;  
            Memory[5]  = 4'b1010;  
            Memory[6]  = 4'b1100;  
            Memory[7]  = 4'b1111; 
            
        end
    end

endmodule
