class ahb_driver extends uvm_driver #(ahb_trans);

	`uvm_component_utils(ahb_driver)

	virtual ahb_if.DRV_MP ahb_if;

	ahb_agent_config ahb_cfg;


	// Standard UVM Methods:
	extern function new(string name ="ahb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(ahb_trans trans);


endclass

//-----------------  constructor new() method  -------------------//
function ahb_driver::new(string name ="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build_phase() method  -------------------//
function void ahb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
		`uvm_fatal("CONFIG","cannot get() ahb_cfg from uvm_config_db. Have you set() it?")
endfunction

//-----------------  connect_phase() method  -------------------//
function void ahb_driver::connect_phase(uvm_phase phase);
	ahb_if = ahb_cfg.ahb_if;
endfunction


//-----------------  run_phase() method  -------------------//
task ahb_driver::run_phase(uvm_phase phase);

	@(ahb_if.drv_cb);
	ahb_if.drv_cb.Hresetn <= 1'b0;

	repeat(2)
	@(ahb_if.drv_cb);
	ahb_if.drv_cb.Hresetn <= 1'b1;

	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end

endtask

//-----------------  task send_to_dut method  -------------------//
task ahb_driver::send_to_dut(ahb_trans trans);

	ahb_if.drv_cb.Haddr <= trans.Haddr;
	ahb_if.drv_cb.Htrans <= trans.Htrans;
	ahb_if.drv_cb.Hwrite <= trans.Hwrite;
	ahb_if.drv_cb.Hsize <= trans.Hsize;
//	ahb_if.drv_cb.Hburst <= trans.Hburst;
	ahb_if.drv_cb.Hreadyin <= 1'b1;

	@(ahb_if.drv_cb);
	wait(ahb_if.drv_cb.Hreadyout)
		ahb_if.drv_cb.Hwdata <= trans.Hwdata;

endtask


