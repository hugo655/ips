module VGA(
	input logic i_VGA_CLK,
	input logic i_rst_n,
	output logic [7:0] o_VGA_R,
	output logic [7:0] o_VGA_G,
	output logic [7:0] o_VGA_B,
	output logic o_SYNC_N,
	output logic o_BLANK_N,
	output logic o_VGA_VS,
	output logic o_VGA_HS
);

// Wires for core_480p
logic de;
logic [9:0] Sx, Sy;
logic vsync;
logic hsync;

logic [7:0] reg_VGA_R;
logic [7:0] reg_VGA_G;
logic [7:0] reg_VGA_B;
logic reg_VGA_VS;
logic reg_VGA_HS;
logic reg_SYNC_N;
logic reg_BLANK_N;

// Wires for colours
logic [3:0] VGA_R;
logic [3:0] VGA_B;
logic [3:0] VGA_G;

// Wires for drawing logic
logic q_draw;

//Output registers
assign o_VGA_R = reg_VGA_R;
assign o_VGA_B = reg_VGA_B;
assign o_VGA_G = reg_VGA_G;
assign o_VGA_VS = reg_VGA_VS;
assign o_VGA_HS = reg_VGA_HS;
assign o_BLANK_N = reg_BLANK_N;
assign o_SYNC_N = reg_SYNC_N;


always_ff @(posedge i_VGA_CLK) begin
	if(~i_rst_n) begin
		reg_VGA_R <= 8'b0;
		reg_VGA_B <= 8'b0;
		reg_VGA_G <= 8'b0;
		reg_VGA_VS <= 1'b0;
		reg_VGA_HS <= 1'b0;
		reg_BLANK_N <= 1'b1;
		reg_SYNC_N <= 1'b1;
	end else begin
		reg_VGA_R <= {4'b0,VGA_R};
		reg_VGA_B <= {4'b0,VGA_B};
		reg_VGA_G <= {4'b0,VGA_G};
		reg_VGA_VS <= vsync;
		reg_VGA_HS <= hsync;
		reg_BLANK_N <= ~de ;
		reg_SYNC_N <= 1'b1; //From ADV7123 DAC datasheet
	end
end

// Drawing logic

//Square
assign q_draw = (Sx<10'd32 && Sy<10'd32)?1'b1:1'b0;


// Colours
assign VGA_R = (de)?4'b0:((q_draw)? 4'hF :4'h0);
assign VGA_B = (de)?4'b0:((q_draw)? 4'h8 :4'h8);
assign VGA_G = (de)?4'b0:((q_draw)? 4'h0 :4'hF);



core_480 core_480_1(.i_VGA_CLOCK(i_VGA_CLK),
                  .i_rst_n(i_rst_n),
                  .o_de(de),
                  .o_vsync(vsync),
                  .o_hsync(hsync),
                  .o_Sx(Sx),
                  .o_Sy(Sy));
endmodule
