// Stopwatch Module
// Implements a basic stopwatch with start/stop and reset functionality,
// displaying time on a seven-segment display.

module stopwatch (
    input wire clk,                // Input clock (e.g., 1 Hz from clock divider)
    input wire reset,              // Reset signal
    input wire button_start_stop,  // Start/Stop button
    input wire button_reset,       // Reset button
    output reg [15:0] time_data    // 4-digit BCD output for seven-segment display
);

    // Internal signals
    reg running = 0;               // Stopwatch running state
    reg [3:0] digits [3:0];        // BCD digits for display

    // Combine digits into a single 16-bit output
    always @(*) begin
        time_data = {digits[3], digits[2], digits[1], digits[0]};
    end

    // Control the start/stop state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            running <= 0;
        end else if (button_start_stop) begin
            running <= ~running; // Toggle running state
        end
    end

    // Count and update time
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digits[0] <= 0; // Units of seconds
            digits[1] <= 0; // Tens of seconds
            digits[2] <= 0; // Units of minutes
            digits[3] <= 0; // Tens of minutes
        end else if (button_reset) begin
            digits[0] <= 0;
            digits[1] <= 0;
            digits[2] <= 0;
            digits[3] <= 0;
        end else if (running) begin
            // Increment time in BCD format
            if (digits[0] == 9) begin
                digits[0] <= 0;
                if (digits[1] == 5) begin
                    digits[1] <= 0;
                    if (digits[2] == 9) begin
                        digits[2] <= 0;
                        if (digits[3] == 5) begin
                            digits[3] <= 0; // Reset after 59:59
                        end else begin
                            digits[3] <= digits[3] + 1;
                        end
                    end else begin
                        digits[2] <= digits[2] + 1;
                    end
                end else begin
                    digits[1] <= digits[1] + 1;
                end
            end else begin
                digits[0] <= digits[0] + 1;
            end
        end
    end

endmodule

