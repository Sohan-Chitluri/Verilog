`include "REG_FILE.v"

module stimulus ();
    reg [3:0] read_reg_num1;  // 4-bit register select
    reg [3:0] read_reg_num2;
    reg [3:0] write_reg;
    reg [3:0] write_data;     // 4-bit write data
    wire [3:0] read_data1;
    wire [3:0] read_data2;
    reg regwrite;
    reg clock;
    reg reset;
    
    // Instantiating register file module
    REG_FILE REG_FILE_module(
        read_reg_num1,
        read_reg_num2,
        write_reg,
        write_data,
        read_data1,
        read_data2,
        regwrite,
        clock,
        reset
    );

    // Generating waveform output
    initial begin
        $dumpfile("output_wave.vcd");
        $dumpvars(0, stimulus);
    end

    // Initializing registers
    initial begin
        reset = 1;
        #10 reset = 0;
    end

    // Writing values to different registers
    initial begin
        regwrite = 0;
        #10 regwrite = 1; write_data = 4'hA; write_reg = 4'd1;
        #10 regwrite = 1; write_data = 4'hB; write_reg = 4'd2;
        #10 regwrite = 1; write_data = 4'hC; write_reg = 4'd3;
        #10 regwrite = 1; write_data = 4'hD; write_reg = 4'd4;
        #10 regwrite = 0;
    end

    // Reading values of different registers
    initial begin
        #10 read_reg_num1 = 4'd1; read_reg_num2 = 4'd2;
        #10 read_reg_num1 = 4'd3; read_reg_num2 = 4'd4;
        #10 read_reg_num1 = 4'd2; read_reg_num2 = 4'd3;
        #10 read_reg_num1 = 4'd1; read_reg_num2 = 4'd4;
    end

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Faster clock
    end

    initial begin
        #100 $finish;
    end

endmodule
