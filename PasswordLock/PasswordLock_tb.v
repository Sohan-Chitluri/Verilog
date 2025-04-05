`timescale 1ns / 1ps

module PasswordLock_tb;
    reg clk, rst, enter, reset_pwd;
    reg [15:0] password_input;
    wire locked;

    PasswordLock uut (
        .clk(clk),
        .rst(rst),
        .password_input(password_input),
        .enter(enter),
        .reset_pwd(reset_pwd),
        .locked(locked)
    );

    always #5 clk = ~clk; // Toggle clock every 5ns

    initial begin
        $dumpfile("PasswordLock_tb.vcd");
        $dumpvars(0, PasswordLock_tb);

        clk = 0; rst = 1; enter = 0; reset_pwd = 0; password_input = 16'd0;
        #10 rst = 0;

        //(Attempt 1)
        #10 password_input = 16'd1111; enter = 1;
        #10 enter = 0;
        #20; 

        // (Attempt 2)
        #10 password_input = 16'd2222; enter = 1;
        #10 enter = 0;
        #20;

        // (Attempt 3)
        #10 password_input = 16'd3333; enter = 1;
        #10 enter = 0;
        #20;

        // (4th attmept wont open as max attemp 3)
        #10 password_input = 16'd1234; enter = 1;
        #10 enter = 0;
        #20;

        #10 rst = 1;
        #10 rst = 0;

        #10 password_input = 16'd1215; enter = 1;
        #10 enter = 0;
        #20;

        #10 password_input = 16'd1234; enter = 1;
        #10 enter = 0;
        #20;

        // Change password to 5678
        #10 password_input = 16'd5678; reset_pwd = 1;
        #10 reset_pwd = 0;
        #20;

        // Try old password — should fail
        #10 password_input = 16'd1234; enter = 1;
        #10 enter = 0;
        #20;

        // Try new password — should work
        #10 password_input = 16'd5678; enter = 1;
        #10 enter = 0;
        #20;
        #50 $finish;
    end
endmodule
