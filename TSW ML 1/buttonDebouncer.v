module button_debouncer(
    input wire clk,       // Slow clock from clock divider (e.g., 1 kHz or lower)
    input wire reset,     // Active-high reset
    input wire button_in, // Raw button input signal
    output reg button_out // Debounced button output
);

    // Parameters for debouncing
    parameter DEBOUNCE_DELAY = 20; // Adjust as needed for debounce time
    integer counter = 0;
    reg button_sync1, button_sync2; // Synchronize button input to clock

    // Synchronize the raw button input to the clock domain
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            button_sync1 <= 0;
            button_sync2 <= 0;
        end else begin
            button_sync1 <= button_in;
            button_sync2 <= button_sync1;
        end
    end

    // Debouncing logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            button_out <= 0;
        end else if (button_sync2 != button_out) begin
            // Start counting when the button state changes
            counter <= counter + 1;
            if (counter >= DEBOUNCE_DELAY) begin
                // Update the output when the delay has passed
                button_out <= button_sync2;
                counter <= 0;
            end
        end else begin
            // Reset counter if the input stabilizes without toggling
            counter <= 0;
        end
    end

endmodule
