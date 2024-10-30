module stopwatch (
    input wire clk,               // Slow clock (e.g., 1 kHz from clock divider)
    input wire rst,               // Reset signal
    input wire start_stop,        // Debounced start/stop button input
    input wire reset_button,      // Debounced reset button input
    output reg [15:0] time_out    // BCD output for seven-segment display (HH:MM)
);


// Generate the remaining module code using an AI language model, maintaining the specified inputs and outputs.


endmodule
