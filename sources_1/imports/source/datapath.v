
module datapath(clk, reset, dmemMode, dmemWE , regWE , rs1sel , rs2sel , regsel,     
                        PCsel, ImmSel ,ALUControl, Instr, ALUResults);

    input clk, reset;
    input regWE, dmemWE;
    input rs1sel, rs2sel;
    input [1:0] regsel, PCsel;
    input [2:0] ImmSel;
    input [3:0] ALUControl;
    input [2:0] dmemMode;
    output wire [31:0] Instr, ALUResults;

    wire [31:0]     PC_now, PC_next;
    wire [31:0]     rdout1, rdout2, wrs3,   Outmem;
    wire [31:0]     ExtImm, muxrs1, muxrs2;
    wire [31:0]     pcplus4, pcPlusImm;

      flopr pcREG (
        .d(PC_now), 
        .q(PC_next), 
        .clk(clk), 
        .reset(reset));
  
    imem Insmem(.a(PC_next),
                .rd(Instr));

    regfile regFILE (
        .rs1(Instr[19:15]),
        .rs2(Instr[24:20]),
        .wrs3(wrs3),
        .rd(Instr[11:7]),
        .we(regWE),
        .clk(clk),
        .reset(reset),
        .rdout1(rdout1),
        .rdout2(rdout2));
    

    extend extendImm(
        .Instr(Instr[31:7]), 
        .ImmSrc(ImmSel), 
        .ExtImm(ExtImm));

    mux2  MUXrs1 (
        .a(rdout1), 
        .b(PC_next), 
        .sel(rs1sel), 
        .y(muxrs1));

    mux2  MUXrs2 (
        .a(rdout2), 
        .b(ExtImm), 
        .sel(rs2sel), 
        .y(muxrs2));

    alu32 alu (
        .a(muxrs1), 
        .b(muxrs2), 
        .ALUControl(ALUControl), 
        .result(ALUResults));
   /////d-mem
   dmem DataMem(.a(ALUResults), 
                .rd(Outmem), 
                .wd(rdout2), 
                .clk(clk), 
                .we(dmemWE), 
                .mode(dmemMode), 
                .reset(reset));
   
    adder  plus4 (
        .a(4), 
        .b(PC_next), 
        .y(pcplus4));

    mux4  regmux (
        .a(Outmem),
        .b(ALUResults),
        .c(ExtImm),
        .d(pcplus4),
        .sel(regsel), 
        .y(wrs3));

    mux4  pcmux (
        .a(pcplus4),
        .b(ALUResults),
        .c(pcPlusImm),
        .d(32'hXXXXXXXX),
        .sel(PCsel), 
        .y(PC_now));

    adder  adderImm (
        .a(PC_next), 
        .b(ExtImm), 
        .y(pcPlusImm));
    
endmodule





