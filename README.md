# ips
This repo aims to store basic IPs to be used in FPGA designs. It is a collection of designs.

I decided to break the ips into synthesible and non-synthesible. All non-synthesible are under vips. Their main purpose is to serve as tools for building testbenches and other types of simulations for the synthesible ones.

Synthesible modules are within this root directory. Here is a quick descripton of them:

- VGA: Simple VGA controler designed to work ad 480x640@60Hz VGA format targeting specifically DE1-soc board. This project is based on the  [FPGA Graphics Series of Posts](https://projectf.io/posts/fpga-graphics/).
