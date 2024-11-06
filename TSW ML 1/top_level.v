module top_level(
    input wire clk,              // 100 MHz clock input
    input wire reset,            // Active-high reset
    input wire button,           // Button for start/stop
    input wire button1,          // Button for reset
    output [3:0] anodes,         // Anode control for 7-segment display
    output [6:0] segments        // Segment control for 7-segment display
);

    // Internal signals
    wire clk_slow;               // Slower clock for debouncing and display
    wire debounced_button;       // Debounced output for start/stop button
    wire debounced_button1;      // Debounced output for reset button
    wire [15:0] display_number;  // Number to display on 7-segment display

    // Clock Divider: Generates a 10 Hz clock for stopwatch timing (0.1-second increments)
    clock_divider #(.DIVISOR(10_000_000)) clk_div_inst (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_slow)
    );

    // Button Debouncer for button (start/stop)
    button_debouncer debounce_inst0 (
        .clk(clk_slow),
        .reset(reset),
        .button_in(button),
        .button_out(debounced_button)
    );

    // Button Debouncer for button1 (reset)
    button_debouncer debounce_inst1 (
        .clk(clk_slow),
        .reset(reset),
        .button_in(button1),
        .button_out(debounced_button1)
    );

    // Stopwatch Module
    stopwatch stopwatch_inst (
        .clk(clk_slow),                // Slow clock input for 0.1-second increments
        .reset(debounced_button1),      // Reset input from debounced reset button
        .start_stop(debounced_button),  // Start/Stop input from debounced button
        .display_number(display_number) // Output to seven-segment display
    );

    // Seven Segment Display
    seven_segment_display display_inst (
        .clk(clk_slow),
        .reset(reset),
        .number(display_number),
        .anodes(anodes),
        .segments(segments)
    );

endmodule
