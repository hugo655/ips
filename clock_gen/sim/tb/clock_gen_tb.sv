 `timescale 1ns/1ps
module tb();
  
    
 wire clk_1;
 reg en;
 clock_gen#(.FREQ(25200)) u1(.clk(clk_1),.enable(en));
 

  
  initial begin
    //Reset and set initial conditions
    
    $dumpfile("dump.vcd");
    $dumpvars;
    #10 en <= 1'b0; 

    
    $display("Simuation Begins ... \n\n");
    #10 en <= 1'b1; 
    
    
    
    #1000
    $finish;
  end
  
endmodule