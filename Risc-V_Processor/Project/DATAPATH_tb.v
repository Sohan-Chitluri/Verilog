`include "DATAPATH.v"

module DATAPATH_tb ();

    reg [1:0] read_reg_num1;  
    reg [1:0] read_reg_num2;
    reg [1:0] write_reg;
    reg [2:0] alu_control;    
    reg regwrite;
    reg clock;
    reg reset;
    wire zero_flag;

    DATAPATH DATAPATH_module( 
        read_reg_num1,
        read_reg_num2,
        write_reg,
        alu_control,
        regwrite,
        clock,
        reset,
        zero_flag
    );

    initial begin
        $dumpfile("output_wave.vcd");
        $dumpvars(0, stimulus);
    end

    initial begin
        reset = 1;
        #20 reset = 0;
    end

    initial begin
        #25 read_reg_num1 = 2'b00; read_reg_num2 = 2'b00;
        #20 read_reg_num1 = 2'b00; read_reg_num2 = 2'b01;
        #20 read_reg_num1 = 2'b00; read_reg_num2 = 2'b01;
        #20 read_reg_num1 = 2'b01; read_reg_num2 = 2'b10;
    end

    initial begin
        regwrite = 0;
        #10 regwrite = 1;
    end

    // ALU control (default to ADD)
    initial begin
        alu_control = 3'b010;  // Modified ALU control to 3-bit
    end

    // Clock signal generation (toggle every 10 time units)
    initial begin
        clock = 0;
        forever #10 clock = ~clock;
    end

    // Simulation stop after 200 time units
    initial
        #200 $finish;

endmodule
