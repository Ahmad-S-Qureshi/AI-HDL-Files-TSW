module top_level(
    input wire clk,               // 100 MHz clock input
    input wire rst,               // Active-high reset (matches testbench)
    input wire button0,           // Button for start/stop (matches testbench)
    input wire button1,           // Button for reset (matches testbench)
    output [3:0] an,              // Anode control for 7-segment display (matches testbench)
    output [6:0] seg              // Segment control for 7-segment display (matches testbench)
);

    // Internal signals
    wire clk_slow;                // Slower clock for debouncing and display
    wire debounced_button0;       // Debounced output for start/stop button
    wire debounced_button1;       // Debounced output for reset button
    wire [15:0] display_number;   // Number to display on 7-segment display

    // Clock Divider: Generates a 10 Hz clock for stopwatch timing (0.1-second increments)
    clock_divider #(.DIVISOR(10_000_000)) clk_div_inst (
        .clk(clk),
        .reset(rst),              // Use `rst` to match testbench
        .clk_out(clk_slow)
    );

    // Button Debouncer for `button0` (start/stop)
    button_debouncer debounce_inst0 (
        .clk(clk_slow),
        .reset(rst),              // Use `rst` to match testbench
        .button_in(button0),      // Use `button0` to match testbench
        .button_out(debounced_button0)
    );

    // Button Debouncer for `button1` (reset)
    button_debouncer debounce_inst1 (
        .clk(clk_slow),
        .reset(rst),              // Use `rst` to match testbench
        .button_in(button1),      // Use `button1` to match testbench
        .button_out(debounced_button1)
    );

    // Stopwatch Module
    stopwatch stopwatch_inst (
        .clk(clk_slow),                // Slow clock input for 0.1-second increments
        .reset(debounced_button1),      // Reset input from debounced reset button
        .start_stop(debounced_button0), // Start/Stop input from debounced button
        .display_number(display_number) // Output to seven-segment display
    );

    // Seven Segment Display
    seven_segment_display display_inst (
        .clk(clk_slow),
        .reset(rst),                   // Use `rst` to match testbench
        .number(display_number),
        .anodes(an),                    // Use `an` to match testbench
        .segments(seg)                  // Use `seg` to match testbench
    );

endmodule
