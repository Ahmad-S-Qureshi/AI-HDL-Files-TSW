// Clock Divider Module
// Generates a slower clock from the 100 MHz input clock on the Basys 3 board.

module clock_divider #(
    parameter DIV_FACTOR = 50000000 // Divide 100 MHz to 1 Hz by default
)(
    inpu// Button Debouncer Module
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
    t wire clk_in,       // Input clock (100 MHz)
    input wire reset,        // Synchronous reset
    output reg clk_out       // Output divided clock
);

    // Counter to divide the clock
    reg [$clog2(DIV_FACTOR)-1:0] counter = 0;

    always @(posedge clk_in) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == DIV_FACTOR - 1) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
