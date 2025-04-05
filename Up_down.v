module UP_DOWN_COUNTER(COUNT, CLK, UP_DOWN, RESET);
input CLK, UP_DOWN, RESET;
output reg [3:0] COUNT;

always @(posedge CLK or posedge RESET)
begin
    if (RESET)
        COUNT <= 0;
    else if (UP_DOWN) begin // Up mode
        if (COUNT == 15)
            COUNT <= 0;
        else
            COUNT <= COUNT + 1;
    end else begin // Down mode
        if (COUNT == 0)
            COUNT <= 15;
        else
            COUNT <= COUNT - 1;
    end
end
endmodule

module UP_DOWN_COUNTER_TB;
reg CLK, RESET, UP_DOWN;
wire [3:0] COUNT;

// Instantiate the Unit Under Test (UUT)
UP_DOWN_COUNTER uut (
    .COUNT(COUNT),
    .CLK(CLK),
    .UP_DOWN(UP_DOWN),
    .RESET(RESET)
);

initial begin
    CLK = 0;
    RESET = 1; // Apply reset
    #20 RESET = 0; // Release reset
    UP_DOWN = 1; // Count Up
    #400;
    UP_DOWN = 0; // Count Down
    #400;
    $stop; // Stop simulation
end

always #10 CLK = ~CLK; // Clock toggles every 10 time units

initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0, UP_DOWN_COUNTER_TB);
end

endmodule
