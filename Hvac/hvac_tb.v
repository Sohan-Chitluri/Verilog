module hvac_tb;

    // Declare test signals
    reg [7:0] dtemp;  // Desired Temperature (8 bits)
    reg [7:0] atemp;  // Actual Temperature (8 bits)
    wire [1:0] speed;  // Speed (2 bits)
    wire heat;  // Heating Signal
    wire cool;  // Cooling Signal
    wire idle;  // Idle Signal

    // Instantiate the HVAC module
    hvac uut (
        .dtemp(dtemp),
        .atemp(atemp),
        .speed(speed),
        .heat(heat),
        .cool(cool),
        .idle(idle)
    );

    // Test stimulus
    initial begin
        // Open a VCD file to store the waveform
        $dumpfile("hvac_simulation.vcd");  // File name for waveform output
        $dumpvars(0, hvac_tb);  // Dump all variables

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
