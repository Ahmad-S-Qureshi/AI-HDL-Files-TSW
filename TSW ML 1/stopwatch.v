module stopwatch(
    input wire clk,               // Slow clock input (e.g., 10 Hz for 0.1s increments)
    input wire reset,             // Reset button input
    input wire start_stop,        // Start/stop button input
    output reg [15:0] display_number // Output to display (4 BCD digits)
);

    // State variables
    reg running = 0;              // Tracks whether the stopwatch is running
    reg [3:0] tenths = 0;         // Tenths of seconds (0-9)
    reg [3:0] seconds_ones = 0;   // Seconds (ones place, 0-9)
    reg [3:0] seconds_tens = 0;   // Seconds (tens place, 0-9)

    // Start/Stop logic
    always @(posedge start_stop or posedge reset) begin
        if (reset) begin
            running <= 0; // Stop the stopwatch on reset
        end else begin
            running <= ~running; // Toggle running state on each start_stop press
        end
    end

    // Stopwatch counting logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all counters
            tenths <= 0;
            seconds_ones <= 0;
            seconds_tens <= 0;
        end else if (running) begin
            // Increment the stopwatch
            if (tenths == 9) begin
                tenths <= 0;
                if (seconds_ones == 9) begin
                    seconds_ones <= 0;
                    if (seconds_tens == 9) begin
                        seconds_tens <= 0; // Reset after 99.9 seconds
                    end else begin
                        seconds_tens <= seconds_tens + 1;
                    end
                end else begin
                    seconds_ones <= seconds_ones + 1;
                end
            end else begin
                tenths <= tenths + 1;
            end
        end
    end

    // Update display output (4 BCD digits)
    always @(*) begin
        display_number = {seconds_tens, seconds_ones, 4'hA, tenths}; // Display format: XX.Y
    end

endmodule
