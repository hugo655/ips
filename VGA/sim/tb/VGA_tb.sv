/*

This testbench tests the module VGA Drawind a square in the top-left corner of the display.
It is not selfchecking.
It is recommended that user check the following frequencies in the waveform viewer:

The expetected output in the display: is https://projectf.io/img/posts/fpga-graphics/vga-square.png

-If BLANK_N = 1'b0, then ALL RGB's must output 8'b0
-If VGA_R !=, either Sx or Sy is less than 32
-If VGA_R !=, is right after hsync=1
-If VGA_R !=, is right after Sy increment


Recommended timescale: 1ns/1ps


*/
module tb();
  
    
  logic clk_1, clk_en, rst_n;

  logic [7:0] VGA_R;
  logic [7:0] VGA_G;
  logic [7:0] VGA_B;
  logic VGA_VS;
  logic VGA_HS;
  logic BLANK_N;
  logic SYNC_N;

  clock_gen#(.FREQ(25175)) u1(.clk(clk_1),.enable(clk_en));

VGA my_VGA(
	.i_VGA_CLK(clk_1),
	.i_rst_n(rst_n),
	.o_VGA_R(VGA_R),
	.o_VGA_G(VGA_G),
	.o_VGA_B(VGA_B),
	.o_SYNC_N(SYNC_N),
	.o_BLANK_N(BLANK_N),
	.o_VGA_VS(VGA_VS),
	.o_VGA_HS(VGA_HS));

  
  initial begin
    //Reset and set initial conditions

    #10 clk_en <= 1'b0;
    rst_n <= 1'b0;

    
    $display("Simulation Begins ... \n\n");
    #10 clk_en <= 1'b1; 
    #50 rst_n <= 1'b1;
    
    
    #100_000_000 //(100 ms)
    $display("End of simulation  ... \n\n");
    $finish;
  end


endmodule
