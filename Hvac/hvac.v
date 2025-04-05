module hvac (
    input [7:0] dtemp,  // Desired Temperature (8 bits)
    input [7:0] atemp,  // Actual Temperature (8 bits)
    output reg [1:0] speed,  // Speed (2 bits)
    output reg heat,  // Heating Signal
    output reg cool,  // Cooling Signal
    output reg idle   // Idle Signal
);
    // Signed variables to hold the temperatures
    reg signed [7:0] dsigned;
    reg signed [7:0] asigned;
    reg signed [7:0] difference;
    
    always @ (dtemp, atemp) begin
        // Convert temperatures to signed values
        dsigned = dtemp;
        asigned = atemp;
        difference = asigned - dsigned;
        
        // Determine the HVAC control signals based on the temperature difference
        if (difference < -9) begin
            speed = 2'b11;
            heat = 1'b1;
            cool = 1'b0;
            idle = 1'b0;
        end
        else if (difference < -5) begin
            speed = 2'b10;
            heat = 1'b1;
            cool = 1'b0;
            idle = 1'b0;
        end
        else if (difference < -2) begin
            speed = 2'b01;
            heat = 1'b1;
            cool = 1'b0;
            idle = 1'b0;
        end
        else if (difference <= 2) begin
            speed = 2'b00;
            heat = 1'b0;
            cool = 1'b0;
            idle = 1'b1;
        end
        else if (difference <= 5) begin
            speed = 2'b01;
            heat = 1'b0;
            cool = 1'b1;
            idle = 1'b0;
        end
        else if (difference <= 9) begin
            speed = 2'b10;
            heat = 1'b0;
            cool = 1'b1;
            idle = 1'b0;
        end
        else begin
            speed = 2'b11;
            heat = 1'b0;
            cool = 1'b1;
            idle = 1'b0;
        end
    end
endmodule
