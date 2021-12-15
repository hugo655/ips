This synthesis is based on de1-soc Series F development board.

To make the code work properly it is important to setup the MSEL[4:0] switch in the back of the board to either one of the following inputs:

* MSEL[4:0]=5'b01010; if running linux HPS with no framebuffer
* MSEL[4:0]=5'b10010; if not using HPS

When setting up the programmer (.cdf file) it is important to make sure there are the following two devices in series:

(TDI) --> [SOCVHPS]-->[5CSEMA5F31] --> (TDO)
