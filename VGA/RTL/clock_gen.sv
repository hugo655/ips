/*
 This is a clock generator for simulation purposes
 
 To instantiate it use:
 
 wire clk_1;
 reg en;
 clock_gen#(.FREQ(25200)) u1(.clk(clk_1),.enable(en));
 
 [...]
 en <= 1'b0;
 [...]
 en <= 1'b1;

 
 `timescale 1ns/1ps


*/
 `timescale 1ns/1ps
module clock_gen(
	input  enable,
	output reg clk);
	
parameter FREQ = 100000; // in KHz
parameter PHASE = 0; // in degrees
parameter DUTY = 50; // in percentage

real clk_pd = 1.0/(FREQ*1e3)*1e9; //Convert to ns
real clk_on = DUTY/100.0 * clk_pd;
real clk_off = (100.0 -DUTY)/100.0 * clk_pd;
real quarter = clk_pd/4; 
real start_delay = quarter * PHASE/90;

reg start_clk;

initial begin
	$display(" ---- Initializing CLK ----\n");
	$display("FREQ: %0d KHz",FREQ);
	$display("PHASE: %0d degrees",PHASE);
	$display("DUTY: %0d duty cycle",DUTY);
	
	$display("PERIOD: %2f ns", clk_pd);
	$display("CLK_ON: %2f ns",clk_on);
	$display("CLK_OFF: %2f ns",clk_off);
	$display("QUARTER: %2f ns",quarter);
	$display("START_DELAY: %2f ns",start_delay);
	$display(" -------------------\n");
end	

// Initialize variables to zero
initial begin
	clk <=0;
	start_clk <=0;
end

always @(posedge enable or negedge enable) begin
	if(enable)	
	 #(start_delay) start_clk = 1;
	else
	 #(start_delay) start_clk = 0;
end

always @(posedge start_clk) begin
	if(start_clk)
	  clk = 1;
	  
	 while (start_clk) begin
	  #(clk_on) clk = 0;
  	  #(clk_on) clk = 1;
	 end
	 
	 clk = 0; 
end
	
endmodule 