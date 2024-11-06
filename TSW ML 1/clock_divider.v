module clock_divider(
    input wire clk,       // 100 MHz clock input
    input wire reset,     // Active-high reset
    output reg clk_out    // Divided clock output
);

    parameter DIVISOR = 100_000_000;  // Divide 100 MHz to 1 Hz (100,000,000 cycles)
    integer counter = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end
        else begin
            if (counter == DIVISOR/2 - 1) begin
                counter <= 0;
                clk_out <= ~clk_out;  // Toggle output clock
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
