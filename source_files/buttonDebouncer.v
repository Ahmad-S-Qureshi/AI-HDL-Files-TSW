// Button Debouncer Module
// Debounces a push button input to ensure stable signal transitions.

module button_debouncer #(
    parameter DEBOUNCE_DELAY = 100000  // Adjust for debounce time (in clock cycles)
)(
    input wire clk,         // Input clock
    input wire reset,       // Synchronous reset
    input wire button_in,   // Noisy button input
    output reg button_out   // Debounced button output
);

    reg [$clog2(DEBOUNCE_DELAY)-1:0] counter = 0;
    reg button_sync = 0;    // Synchronize the button signal to the clock
    reg button_stable = 0;  // Holds the stable button state

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            button_out <= 0;
            button_sync <= 0;
            button_stable <= 0;
        end else begin
            button_sync <= button_in; // Synchronize input
            if (button_sync == button_stable) begin
                counter <= 0; // Reset counter if no change
            end else begin
                if (counter == DEBOUNCE_DELAY - 1) begin
                    counter <= 0;
                    button_stable <= button_sync; // Accept the new state
                end else begin
                    counter <= counter + 1; // Increment counter
                end
            end
            button_out <= button_stable; // Update output
        end
    end

endmodule
