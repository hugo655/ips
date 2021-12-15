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
logic [7:0] VGA_R;
logic [7:0] VGA_B;
logic [7:0] VGA_G;

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
		reg_VGA_R <= {VGA_R};
		reg_VGA_B <= {VGA_B};
		reg_VGA_G <= {VGA_G};
		reg_VGA_VS <= vsync;
		reg_VGA_HS <= hsync;
		reg_BLANK_N <= de ;
		reg_SYNC_N <= 1'b1; //From ADV7123 DAC datasheet
	end
end


core_480 core_480_1(.i_VGA_CLOCK(i_VGA_CLK),
                  .i_rst_n(i_rst_n),
                  .o_de(de),
                  .o_vsync(vsync),
                  .o_hsync(hsync),
                  .o_Sx(Sx),
                  .o_Sy(Sy));
						
						

// TESTING PATTERNS

/*
////////////////
// TOP SQUARE //
///////////////
assign q_draw = (Sx<10'd100 && Sy<10'd100)?1'b1:1'b0;


// Colours
assign VGA_R = (~de)?8'h0:((q_draw)? 8'hFF :8'h0);
assign VGA_G = (~de)?8'h0:((q_draw)? 8'h88 :8'h88);
assign VGA_B = (~de)?8'h0:((q_draw)? 8'h0 :8'hFF);

*/

/*
///////////////////////////////
// COLOUR-POSITION PATTERN I //
///////////////////////////////


assign VGA_R = (de)?Sy:8'h0;
assign VGA_G = (de)?~Sy:8'h0;
assign VGA_B = (de)?Sx:8'h0;

*/

/*
///////////////////////////////
// COLOUR-POSITION PATTERN II //
///////////////////////////////


assign VGA_R = (de)?Sy:8'h0;
assign VGA_G = (de)?Sy^Sx:8'h0;
assign VGA_B = (de)?Sx:8'h0;
*/

///////////////////////////////
// COLOUR-POSITION PATTERN III //
///////////////////////////////

always_comb begin
if(de) begin
	if(10'h001 & Sy) begin
		VGA_R = Sx;
		VGA_G = 8'b0;
		VGA_B =8'b0;
	end
	
	else if(10'h002 & Sy) begin
		VGA_R = 8'b0;
		VGA_G = Sx;
		VGA_B =8'b0;
	end
	
		else if(10'h004 & Sy) begin
		VGA_R = 8'b0;
		VGA_G = 8'b0;
		VGA_B =Sx;
	end 
	 
	else if(10'h008 & Sy) begin
		VGA_R = Sx;
		VGA_G = Sx;
		VGA_B =8'b0;
	end
	
	else if(10'h010 & Sy) begin
		VGA_R = 8'b0;
		VGA_G = Sx;
		VGA_B = Sx;
	end
	
	else if(10'h020 & Sy) begin
		VGA_R = Sx;
		VGA_G = 8'b0;
		VGA_B = Sx;
	end
	
	else begin
	VGA_R = 8'b0;
	VGA_G = 8'b0;
	VGA_B = 8'b0;
	end
end 
else begin
	VGA_R = 8'b0;
	VGA_G = 8'b0;
	VGA_B = 8'b0;
end
end

endmodule
