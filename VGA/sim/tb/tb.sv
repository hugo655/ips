module tb();
  
    
  logic clk_1, clk_en;
  logic rst_n, vga_en, vsync, hsync;
  logic [9:0] Sx,Sy;
  clock_gen#(.FREQ(25175)) u1(.clk(clk_1),.enable(clk_en));

core_480 my_vga_core(.i_VGA_CLOCK(clk_1),
                  .i_rst_n(rst_n),
                  .o_de(vga_en),
                  .o_vsync(vsync),
                  .o_hsync(hsync),
                  .o_Sx(Sx),
                  .o_Sy(Sy));
  

  
  initial begin
    //Reset and set initial conditions

    #10 clk_en <= 1'b0;
    rst_n <= 1'b0;

    
    $display("Simuation Begins ... \n\n");
    #10 clk_en <= 1'b1; 
    #50 rst_n <= 1'b1;
    
    
    
    #100_000_000 //(100 ms)
    $finish;
  end
 

///////////////
// CHECKERS // 
///////////////
/*
 The following parameters were checked in simulation using Modelsim: 
  [ok] VGA Frequency: 25.175 MHz (expected) ; 25.126 MHz  (simulation)
  [ok] h_sync lenght: 3.8133 us(expected);3.8208 us (simulation)
  [ok] v_sync lenght: 63.55 ms (expected); 63.68 ms(simulation)
  [ok] h_sync frequency: 31.47 KHz (expected) ; 31.51 KHz (simulation)
  [ok] v_sync frequency: 59.9 Hz (expected); 59.82 Hz (simulation)
  [ok] Range of Sx: 0-799 (expected) ; 0-799 (simulation) 
  [ok] Range of Sy: 0-524 (expected) ; 0-524 (simulation)  
*/
    
  
endmodule
