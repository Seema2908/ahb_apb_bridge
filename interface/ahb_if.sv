`timescale 1ns/1ps
interface ahb_if(input logic Hclk);

wire Hresetn;
wire[1:0] Htrans;
wire[31:0] Haddr;
wire Hwrite;
wire[2:0] Hsize;
wire[31:0] Hwdata;
wire[31:0] Hrdata;
wire Hreadyin;
wire[1:0] Hresp;
wire Hreadyout;
wire [2:0] Hburst;

clocking drv_cb @(posedge Hclk);

default input#1 output#0;
output Hresetn;
output Htrans;
output Hwrite;
output Hreadyin;
output Hwdata;
output Haddr;
output Hsize;
output Hburst;

input Hresp;
input Hreadyout;
input Hrdata;

endclocking

clocking mon_cb @(posedge Hclk);

default input #1 output #0;
input Hresetn;
input Htrans;
input Hwrite;
input Hwdata;
input Haddr;
input Hsize;
input Hreadyin;
input Hreadyout;
//input Hrdata;
//input Hresp;
input Hburst;

endclocking

modport DRV_MP(clocking drv_cb);
modport MON_MP(clocking mon_cb);

endinterface

