`timescale 1ns / 1ps

module top_level_tb;

    reg clk;               // Clock signal (simulated 100 MHz)
    reg rst;               // Reset signal
    reg button0;           // Simulated start/stop button
    reg button1;           // Simulated reset button
    wire [6:0] seg;        // 7-segment display segments
    wire [3:0] an;         // 7-segment display anodes

    // Instantiate the top-level module
    top_level uut (
        .clk(clk),
        .rst(rst),
        .button0(button0),
        .button1(button1),
        .seg(seg),
        .an(an)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period (100 MHz)
    end

    // Stimulus process
    initial begin
        // Initial conditions
        rst = 1;
        button0 = 0;
        button1 = 0;

        // Wait for reset to propagate
        #100;
        rst = 0;

        // Test sequence
        // 1. Press start button (button0)
        #500;
        button0 = 1;  // Simulate press
        #1000;
        button0 = 0;  // Release button

        // Let the stopwatch run for a while
        #10000;

        // 2. Press start button again to stop the stopwatch
        button0 = 1;  // Simulate press
        #1000;
        button0 = 0;  // Release button

        // Wait for a moment while the stopwatch is stopped
        #5000;

        // 3. Press reset button (button1)
        button1 = 1;  // Simulate press
        #1000;
        button1 = 0;  // Release button

        // Let the system idle for a bit before ending the simulation
        #10000;

        // End simulation
        $stop;
    end

endmodule
