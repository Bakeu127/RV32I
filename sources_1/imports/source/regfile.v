module regfile(rs1, rs2, wrs3, rd, we, clk, reset, rdout1, rdout2);
	input wire 				clk, we, reset;
	input wire [4:0]		rs1, rs2, rd;
	input wire [31:0]		wrs3;
	output wire [31:0]		rdout1, rdout2;
	
	reg [31:0] x [31:0];
	integer i;
	initial begin
		for (i = 0; i < 31; i = i + 1) begin
			x[i] <= 32'b00000000000000000000000000000000;;
		end		
	end
	assign rdout1 = x[rs1];
	assign rdout2 = x[rs2];
	
	always @(negedge clk) begin
		 if (we) begin			// Write enable and can not overwrite x0
			x[rd] <= wrs3;						// Store wrs3 to rd register
		end 
	
	end
	
endmodule




