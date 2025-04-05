module ALU_testbench ();
    reg [3:0] A, B;
    reg [3:0] ALUControl;
    wire ZERO;
    wire [3:0] ALUResult;

    // Instantiating ALU module
    ALU ALU_module(.in1(A), .in2(B), .alu_control(ALUControl), .zero_flag(ZERO), .alu_result(ALUResult));

    // Setting up waveform
    initial
    begin
        $dumpfile("output_wave.vcd");
        $dumpvars(0, ALU_testbench);
    end
    

    // Monitoring changing values
    initial
    $monitor($time, "\nInput_1 = %b, \nInput_2 = %b,\nALU_control = %b,\n ALU_result = %b, Zero_flag = %b\n", A, B, ALUControl, ALUResult, ZERO);

    // Test conditions
    initial
    begin
        A = 4'b0011; B = 4'b1010; ALUControl = 4'b0000;
    #20 A = 4'b0011; B = 4'b1010; ALUControl = 4'b0001;
    #20 A = 4'b0011; B = 4'b0001; ALUControl = 4'b0010;
    #20 A = 4'b1010; B = 4'b0011; ALUControl = 4'b0100;
    #20 A = 4'b0011; B = 4'b0110; ALUControl = 4'b1000;
    #20 A = 4'b0110; B = 4'b0010; ALUControl = 4'b0011;
    #20 A = 4'b0110; B = 4'b0010; ALUControl = 4'b0101;
    #20 A = 4'b0011; B = 4'b0001; ALUControl = 4'b0110;
    #20 A = 4'b1010; B = 4'b0101; ALUControl = 4'b0111;
    end

    // Finish after 180 time units
    initial
    #180 $finish;

endmodule
