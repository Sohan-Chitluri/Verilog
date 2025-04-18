`include "PROCESSOR.v"

module PROCESSOR_tb.v ();
    
    reg clock;
    reg reset;
    wire zero;

    // Instantiating the processor!!!
    PROCESSOR test_processor(clock,reset,zero);

    initial begin
        $dumpfile("output_wave.vcd");
        $dumpvars(0,PROCESSOR_tb.)v;
    end

    initial begin
        reset = 1;
        #50 reset = 0;
    end

    initial begin
        clock = 0;
        forever #20 clock = ~clock;
    end

    initial
    #300 $finish;
    
endmodule