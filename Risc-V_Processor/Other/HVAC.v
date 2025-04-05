// HVAC System with Speed Control in Verilog
module HVAC(
    input wire [7:0] dtemp, // Desired temperature
    input wire [7:0] atemp, // Actual temperature
    output reg [1:0] speed, // Fan speed control
    output reg heat, // Heating signal
    output reg cool, // Cooling signal
    output reg idle  // Idle state signal
);
    always @(*) begin
        if (atemp == dtemp) begin
            heat = 0;
            cool = 0;
            speed = 2'b00;
            idle = 1;
        end else if (atemp < dtemp) begin
            heat = 1;
            cool = 0;
            idle = 0;
            if (dtemp - atemp > 5)
                speed = 2'b10; // High speed heating
            else
                speed = 2'b01; // Low speed heating
        end else begin
            heat = 0;
            cool = 1;
            idle = 0;
            if (atemp - dtemp > 5)
                speed = 2'b10; // High speed cooling
            else
                speed = 2'b01; // Low speed cooling
        end
    end
endmodule

// Testbench
module HVAC_tb;
    reg [7:0] dtemp;  // Desired Temperature (8 bits)
    reg [7:0] atemp;  // Actual Temperature (8 bits)
    wire [1:0] speed;  // Speed (2 bits)
    wire heat;  // Heating Signal
    wire cool;  // Cooling Signal
    wire idle;  // Idle Signal

    // Instantiate the HVAC module
    HVAC uut (
        .dtemp(dtemp),
        .atemp(atemp),
        .speed(speed),
        .heat(heat),
        .cool(cool),
        .idle(idle)
    );

    // Test stimulus
    initial begin
        $dumpfile("hvac_simulation.vcd");  // File name for waveform output
        $dumpvars(0, HVAC_tb);  // Dump all variables

        // Test Case 1: Both temperatures are the same (Idle)
        dtemp = 8'b00011010;  // Desired Temp: 26
        atemp = 8'b00011010;  // Actual Temp: 26
        #10;
        
        // Test Case 2: Small difference, heating needed
        dtemp = 8'b00011010;  // Desired Temp: 26
        atemp = 8'b00011001;  // Actual Temp: 25
        #10;
        
        // Test Case 3: Large difference, heating required
        dtemp = 8'b00011010;  // Desired Temp: 26
        atemp = 8'b00010100;  // Actual Temp: 20
        #10;
        
        // Test Case 4: Small cooling required
        dtemp = 8'b00011010;  // Desired Temp: 26
        atemp = 8'b00011011;  // Actual Temp: 27
        #10;
        
        // Test Case 5: Large cooling required
        dtemp = 8'b00011010;  // Desired Temp: 26
        atemp = 8'b00100000;  // Actual Temp: 32
        #10;
        
        // End of simulation
        $finish;
    end
endmodule
