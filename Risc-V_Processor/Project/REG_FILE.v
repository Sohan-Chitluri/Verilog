module REG_FILE(
    input [3:0] read_reg_num1,  
    input [3:0] read_reg_num2,
    input [3:0] write_reg,
    input [3:0] write_data,     
    output [3:0] read_data1,
    output [3:0] read_data2,
    input regwrite,
    input clock,
    input reset
);

    reg [3:0] reg_memory [15:0];
    integer i;

    // Initialize register file on reset
    always @(posedge reset) begin
        for (i = 0; i < 16; i = i + 1)
            reg_memory[i] <= i; 
    end

    // Continuous read
    assign read_data1 = reg_memory[read_reg_num1];
    assign read_data2 = reg_memory[read_reg_num2];

    // Write operation (except register 0)
    always @(posedge clock) begin
        if (regwrite && write_reg != 4'b0000) begin
            reg_memory[write_reg] <= write_data;
        end
    end

endmodule
