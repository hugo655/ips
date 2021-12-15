module core_480(
  input logic i_VGA_CLOCK,
  input logic i_rst_n,
  output logic o_de,
  output logic o_vsync,
  output logic o_hsync,
  output logic  [9:0] o_Sx,
  output logic  [9:0] o_Sy  
); 
  
  localparam H_LENGTH		=800;
  localparam H_BACK_PORCH	=48;// 48=0x30
  localparam H_ACTIVE_REGION	=H_BACK_PORCH+640;//688 = 0x2B0 
  localparam H_FRONT_PORCH	=H_ACTIVE_REGION+16;// 704 = 0x2C0
  localparam H_SYNC		=H_FRONT_PORCH+96;// 800 = 0x320
  
  localparam V_LENGTH		=525;
  localparam V_BACK_PORCH	=33;// 33 = 0x21
  localparam V_ACTIVE_REGION	=V_BACK_PORCH + 480;// 513 = 0x201
  localparam V_FRONT_PORCH	=V_ACTIVE_REGION+10;// 523 = 0x20B 
  localparam V_SYNC		=V_FRONT_PORCH+2;// 525 = 0x20D
  
  logic x_active;
  logic y_active;
  
// Sx and Sy update
  always_ff@(posedge i_VGA_CLOCK) begin
    if(~i_rst_n) begin
      o_Sx <= 10'b0;
      o_Sy <= 10'b0;
    end
    else begin
      if(o_Sx==H_LENGTH-1) begin
        o_Sx <= 10'b0;
        o_Sy <= (o_Sy==V_LENGTH-1)?10'b0:o_Sy+1'b1;	
      end else 
        o_Sx <= o_Sx + 1'b1;
    end
  end
// SYNC logic
    always_comb begin
      // hsync = 1 when 0x2C0 <= o_Sx < H_SYNC
      o_hsync = ~((o_Sx> H_FRONT_PORCH-1  && o_Sx<=H_SYNC-1)? 1'b1: 1'b0);
      o_vsync = ~((o_Sy>V_FRONT_PORCH-1 && o_Sy<=V_SYNC-1)? 1'b1: 1'b0);     
    end
    
// Draw-enable logic (Active Region)
    always_comb begin
      x_active = (o_Sx>=H_BACK_PORCH-1&&o_Sx<H_ACTIVE_REGION-1)? 1'b1: 1'b0;
      y_active = (o_Sy>=V_BACK_PORCH-1&&o_Sy<V_ACTIVE_REGION-1)? 1'b1: 1'b0;
      o_de = x_active & y_active; 
    end
    

 
endmodule
