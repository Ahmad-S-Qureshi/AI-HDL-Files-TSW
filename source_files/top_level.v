// Top-Level Design for Basys 3 Board
// Includes button debouncers, clock divider, seven-segment display, and stopwatch module.

module top_level (
    input wire clk,               // 100 MHz clock input
    input wire reset,             // Reset input
    input wire button0,           // Button 0 input (Start/Stop)
    input wire button1,           // Button 1 input (Reset)
    output wire [3:0] anodes,     // Seven-segment display anodes (active low)
    output wire [6:0] cathodes    // Seven-segment display cathodes (active low)
);

    // Clock Divider Output
    wire slow_clk;

    // Debounced Button Outputs
    wire button_start_stop_debounced;
    wire button_reset_debounced;

    // Stopwatch Output (16-bit BCD for 4 digits)
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
    ) button_start_stop_debounce_inst (
        .clk(slow_clk),
        .reset(reset),
        .button_in(button0),
        .button_out(button_start_stop_debounced)
    );

    button_debouncer #(
        .DEBOUNCE_DELAY(20000) // 10 ms debounce at 2 kHz clock
    ) button_reset_debounce_inst (
        .clk(slow_clk),
        .reset(reset),
        .button_in(button1),
        .button_out(button_reset_debounced)
    );

    // Instantiate Stopwatch Module
    stopwatch stopwatch_inst (
        .clk(slow_clk),
        .reset(reset),
        .button_start_stop(button_start_stop_debounced),
        .button_reset(button_reset_debounced),
        .time_data(stopwatch_output)
    );

    // Instantiate Seven-Segment Display Module
    seven_segment_display seven_seg_inst (
        .clk(slow_clk),
        .reset(reset),
        .digit_data(stopwatch_output), // Pass the stopwatch output
        .anodes(anodes),
        .cathodes(cathodes)
    );

endmodule
