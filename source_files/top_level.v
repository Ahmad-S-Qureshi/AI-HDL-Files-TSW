// Top-Level Design for Basys 3 Board
// Includes button debouncers, clock divider, seven-segment display, and a placeholder for a stopwatch module.

module top_level (
    input wire clk,               // 100 MHz clock input
    input wire reset,             // Reset input
    input wire button0,           // Button 0 input
    input wire button1,           // Button 1 input
    output wire [3:0] anodes,     // Seven-segment display anodes (active low)
    output wire [6:0] cathodes    // Seven-segment display cathodes (active low)
);

    // Clock Divider Output
    wire slow_clk;

    // Debounced Button Outputs
    wire button0_debounced;
    wire button1_debounced;

    // Placeholder Signals for Stopwatch Module
    wire [15:0] stopwatch_output;

    // Instantiate Clock Divider
    clock_divider #(
        .DIV_FACTOR(50000) // 100 MHz to 2 kHz for display refresh and debouncing
    ) clock_div_inst (
        .clk_in(clk),
        .reset(reset),
        .clk_out(slow_clk)
    );

    // Instantiate Button Debouncers
    button_debouncer #(
        .DEBOUNCE_DELAY(20000) // 10 ms debounce at 2 kHz clock
    ) button0_debounce_inst (
        .clk(slow_clk),
        .reset(reset),
        .button_in(button0),
        .button_out(button0_debounced)
    );

    button_debouncer #(
        .DEBOUNCE_DELAY(20000) // 10 ms debounce at 2 kHz clock
    ) button1_debounce_inst (
        .clk(slow_clk),
        .reset(reset),
        .button_in(button1),
        .button_out(button1_debounced)
    );

    // Instantiate Seven-Segment Display Module
    seven_segment_display seven_seg_inst (
        .clk(slow_clk),
        .reset(reset),
        .digit_data(stopwatch_output), // Placeholder for stopwatch output
        .anodes(anodes),
        .cathodes(cathodes)
    );

    // Placeholder for Stopwatch Module
    // Replace this with actual stopwatch module instantiation in the future.
    // Example: stopwatch_module stopwatch_inst (...);
    assign stopwatch_output = 16'h1234; // Temporary static value for testing

endmodule
