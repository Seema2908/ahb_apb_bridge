`timescale 1ns/1ps
module ahb_apb_top;

	import ahb_apb_test_pkg::*;
        import uvm_pkg::*;

        `include "uvm_macros.svh"

        // Generate clock signal
        bit clock = 0;

        always
                #10 clock = ~clock;

        ahb_if ahbif(clock);
        apb_if apbif(clock);

	rtl_top DUV(
		.Hclk(clock),
		.Hresetn(ahbif.Hresetn),
		.Htrans(ahbif.Htrans),
		.Hsize(ahbif.Hsize),
		.Hreadyin(ahbif.Hreadyin),
		.Hwdata(ahbif.Hwdata),
		.Haddr(ahbif.Haddr),
		.Hwrite(ahbif.Hwrite),
		.Prdata(apbif.Prdata),
		.Hrdata(ahbif.Hrdata),
		.Hresp(ahbif.Hresp),
		.Hreadyout(ahbif.Hreadyout),
		.Pselx(apbif.Pselx),
		.Pwrite(apbif.Pwrite),
		.Penable(apbif.Penable),
		.Paddr(apbif.Paddr),
		.Pwdata(apbif.Pwdata)
			) ;

        initial
                begin
                        uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_if",ahbif);
                        uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",apbif);


                        run_test();
                end

endmodule

