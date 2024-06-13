
module Processor(clk, reset, Instr, ALUResults, ALUControl, dmemMode, 
                     ImmSel, regsel, PCsel, dmemWE, 
                     regWE, rs1sel, rs2sel);
    input wire clk , reset;
    output wire  [31:0] Instr, ALUResults;
    output wire regWE, dmemWE;
    output wire rs1sel, rs2sel;
    output wire [1:0] regsel, PCsel;
    output wire [2:0] ImmSel;
    output wire [3:0] ALUControl;
    output wire [2:0] dmemMode;
    
    control_logic Control(Instr, ALUResults[0], ALUControl, dmemMode, 
                     ImmSel, regsel, PCsel, dmemWE, 
                     regWE, rs1sel, rs2sel, clk, reset);
                     
    datapath Datapath(clk, reset, dmemMode, dmemWE , regWE , rs1sel , rs2sel , regsel,     
                        PCsel, ImmSel ,ALUControl, Instr, ALUResults);                 
endmodule
