`include "IFU.v"
module IFU_tb(

);
    reg CLOCK, RESET;
    wire [3:0] Instruction_Code;

    // Initializing IFU module
    IFU IFU_module(CLOCK, RESET, Instruction_Code);

    // Setting up waveform
    initial
    begin
        $dumpfile("IFU_output_wave.vcd");
        $dumpvars(0,IFU_tb);
    end

    // Monitoring the changes in values
    initial
    $monitor($time, " CLOCK = %b, RESET = %b, Instruction Code = %h", CLOCK, RESET, Instruction_Code);

    // Initializing reset
    initial
    begin
        RESET = 1'b0;
        #20 RESET = 1'b1;
        #200 RESET = 1'b0;
        #100 RESET = 1'b1;
    end

    // Initializing clock
    initial
    begin
        CLOCK = 1;
        forever #20 CLOCK = ~CLOCK;
    end

    initial
    #400 $finish;

endmodule