// Seven Segment Display Module
// Controls the 4-digit seven-segment display on the Basys 3 Board.

module seven_segment_display (
    input wire clk,                // Input clock
    input wire reset,              // Synchronous reset
    input wire [15:0] digit_data,  // 4 digits, each 4 bits (BCD format or hex)
    output reg [3:0] anodes,       // Anode control signals (active low)
    output reg [6:0] cathodes      // Cathode control signals for segments (active low)
);

    // Segment decoder for 7-segment display
    function [6:0] digit_to_segments;
        input [3:0] digit;
        begin
            case (digit)
                4'h0: digit_to_segments = 7'b0000001;
                4'h1: digit_to_segments = 7'b1001111;
                4'h2: digit_to_segments = 7'b0010010;
                4'h3: digit_to_segments = 7'b0000110;
                4'h4: digit_to_segments = 7'b1001100;
                4'h5: digit_to_segments = 7'b0100100;
                4'h6: digit_to_segments = 7'b0100000;
                4'h7: digit_to_segments = 7'b0001111;
                4'h8: digit_to_segments = 7'b0000000;
                4'h9: digit_to_segments = 7'b0000100;
                4'hA: digit_to_segments = 7'b0001000;
                4'hB: digit_to_segments = 7'b1100000;
                4'hC: digit_to_segments = 7'b0110001;
                4'hD: digit_to_segments = 7'b1000010;
                4'hE: digit_to_segments = 7'b0110000;
                4'hF: digit_to_segments = 7'b0111000;
                default: digit_to_segments = 7'b1111111; // All segments off
            endcase
        end
    endfunction

    reg [1:0] refresh_counter = 0; // Counter for refreshing the 4 digits
    wire [3:0] current_digit;      // Current digit to display

    // Assign the current digit from the input data
    assign current_digit = digit_data[refresh_counter * 4 +: 4];

    // Refresh and update the display
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            refresh_counter <= 0;
            anodes <= 4'b1111; // All digits off
            cathodes <= 7'b1111111; // All segments off
        end else begin
            // Increment the refresh counter
            refresh_counter <= refresh_counter + 1;

            // Activate the current digit's anode
            anodes <= ~(4'b0001 << refresh_counter);

            // Update the cathodes for the current digit
            cathodes <= digit_to_segments(current_digit);
        end
    end

endmodule

