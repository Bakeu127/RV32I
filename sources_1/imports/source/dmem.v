module dmem(a, rd, wd, clk, we, mode, reset);
	input wire 			clk, we, reset;
	input wire [2:0]	mode;
	input wire [31:0]	a, wd;
	output [31:0]	rd;
	
	reg [31:0] mem [0:31];
	
	integer i;
	initial begin
		for (i = 0; i < 31; i = i + 1) begin
			mem[i] <= 32'b00000000000000000000000000000000;;
		end		
	end
		
	always @(negedge clk) begin
		if (we) begin
			case (mode)
				3'b000:	mem[a] <= wd;	                            // 4 byte mode (32 bit)
				3'b001:	mem[a][15:0] <= wd[15:0];					// 2 byte mode (16 bit)
				3'b101:	mem[a][15:0] <= wd[15:0];					// 2 byte mode (16 bit)
				3'b010: mem[a][7:0] <= wd[7:0];						// 1 byte mode (8 bit)
				3'b110: mem[a][7:0] <= wd[7:0];						// 1 byte mode (8 bit)
				default: mem[a] <= wd;	                            // 4 byte mode (32 bit)
			endcase
		end
	end

	assign rd = (mode == 3'b000 && we == 1'b0) ? mem[a] :                        // 4 byte mode (32 bit)
             (mode == 3'b001 && we == 1'b0) ? {{16{1'b0}}, mem[a][15:0]} :       // 2 byte U
             (mode == 3'b101 && we == 1'b0) ? {{16{mem[a][15]}}, mem[a][15:0]} : // 2 byte 
             (mode == 3'b010 && we == 1'b0) ? {{24{1'b0}}, mem[a][7:0]} :        // 1 byte U
             (mode == 3'b110 && we == 1'b0) ? {{24{mem[a][7]}}, mem[a][7:0]} :   // 1 byte
             32'bz;                                               

	
endmodule
