module PasswordLock(
    input clk,
    input rst,
    input [15:0] password_input, 
    input enter,
    input reset_pwd,
    output reg locked
);

    reg [15:0] stored_password = 16'd1234;  
    reg [1:0] attempt_count = 0;           
    reg permanently_locked = 0;            

    always @(posedge clk or posedge rst) begin
    if (rst) begin
        attempt_count <= 0;
        locked <= 1;
        permanently_locked <= 0;
        stored_password <= 16'd1234;
    end else if (!permanently_locked) begin
        if (reset_pwd && !locked) begin
            stored_password <= password_input;
            locked <= 1; // Lock after changing password
            attempt_count <= 0;
        end else if (enter && locked) begin
            if (password_input == stored_password) begin
                locked <= 0;  // Correct password unlocks
                attempt_count <= 0;
            end else begin
                attempt_count <= attempt_count + 1;
                if (attempt_count >= 2) begin
                    locked <= 1;
                    permanently_locked <= 1;
                end
            end
        end
    end
end

endmodule
