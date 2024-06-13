`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2024 02:33:49 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;
    reg clk , reset;
    wire  [31:0] Instr, ALUResults;
    wire regWE, dmemWE;
    wire rs1sel, rs2sel;
    wire [1:0] regsel, PCsel;
    wire [2:0] ImmSel;
    wire [3:0] ALUControl;
    wire [2:0] dmemMode;
    Processor  UNIT(.clk(clk), .reset(reset), .Instr(Instr), 
                    .ALUResults(ALUResults), .ALUControl(ALUControl), 
                    .dmemMode(dmemMode),.ImmSel(ImmSel), 
                    .regsel(regsel), .PCsel(PCsel), .dmemWE(dmemWE), 
                     .regWE(regWE), .rs1sel(rs1sel), .rs2sel(rs2sel));
    always begin
       #10 clk = ~clk;
       end
     initial begin
     clk = 0;
     reset = 1;
     #18
     reset = 0;
     end         
endmodule
