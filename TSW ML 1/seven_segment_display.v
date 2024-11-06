module seven_segment_display(
    input wire clk,                  // Clock input
    input wire reset,                // Active-high reset
    input wire [15:0] number,        // 4-digit BCD input (4 digits, each 4 bits)
    output reg [3:0] anodes,         // Anode signals for 4 digits
    output reg [6:0] segments        // Segment signals for 7 segments
);

    reg [1:0] digit_select = 0;       // Multiplexing digit selector
    reg [3:0] current_digit;          // Current digit to display

    // Segment encoding for hexadecimal values (0-F)
    always @(*) begin
        case (current_digit)
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0010000;
            4'hA: segments = 7'b0001000;
            4'hB: segments = 7'b0000011;
            4'hC: segments = 7'b1000110;
            4'hD: segments = 7'b0100001;
            4'hE: segments = 7'b0000110;
            4'hF: segments = 7'b0001110;
            default: segments = 7'b1111111; // Turn off all segments for undefined
        endcase
    end

    // Multiplexing and anode control
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit_select <= 0;
            anodes <= 4'b1111;
        end else begin
            digit_select <= digit_select + 1;

            // Select the appropriate digit and activate its anode
            case (digit_select)
                2'b00: begin
                    current_digit <= number[3:0];
                    anodes <= 4'b1110; // Enable rightmost digit
                end
                2'b01: begin
                    current_digit <= number[7:4];
                    anodes <= 4'b1101; // Enable second digit from right
                end
                2'b10: begin
                    current_digit <= number[11:8];
                    anodes <= 4'b1011; // Enable third digit from right
                end
                2'b11: begin
                    current_digit <= number[15:12];
                    anodes <= 4'b0111; // Enable leftmost digit
                end
            endcase
        end
    end

endmodule
