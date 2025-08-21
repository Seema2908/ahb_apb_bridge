`timescale 1ns/1ps
interface apb_if(input logic Hclk);

wire Penable;
wire Pwrite;
wire[31:0] Pwdata;
wire[31:0] Prdata;
wire[31:0] Paddr;
wire[3:0] Pselx;

clocking drv_cb @(posedge Hclk);
output Prdata;
input Pwdata;
input Penable;
input Pwrite;
input Paddr;
input Pselx;

endclocking

clocking mon_cb @(posedge Hclk);
input Pwdata;
input Penable;
input Prdata;
input Pwrite;
input Paddr;
input Pselx;

endclocking 

modport DRV_MP(clocking drv_cb);
modport MON_MP(clocking mon_cb);

endinterface
