
module mux4(a, b, c, d, sel, y);
	parameter WIDTH = 32;
	
	input wire [WIDTH - 1:0]	a, b, c, d;
    input wire [1:0]			sel;
	output reg [WIDTH - 1:0]	y;

    always @(*) begin
        case (sel)
            2'b00:  y <= a;
            2'b01:  y <= b;
            2'b10:  y <= c;
            2'b11:  y <= d;
        endcase
    end

endmodule
