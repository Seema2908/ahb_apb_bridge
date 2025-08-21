class apb_driver extends uvm_driver #(apb_trans);

	`uvm_component_utils(apb_driver)

	virtual apb_if.DRV_MP apb_if;

	apb_agent_config apb_cfg;

	// Standard UVM Methods:
	extern function new(string name ="apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(apb_trans trans);

endclass

//-----------------  constructor new() method  -------------------//
function apb_driver::new(string name ="apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build_phase() method  -------------------//
function void apb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
		`uvm_fatal("CONFIG","cannot get() apb_cfg from uvm_config_db. Have you set() it?")
endfunction

//-----------------  connect_phase() method  -------------------//
function void apb_driver::connect_phase(uvm_phase phase);
        apb_if = apb_cfg.apb_if;
endfunction


//-----------------  run_phase() method  -------------------//
task apb_driver::run_phase(uvm_phase phase);

	req = apb_trans::type_id::create("req",this);

	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end

endtask

//-----------------  task send_to_dut method  -------------------//
task apb_driver::send_to_dut(apb_trans trans);

	wait(apb_if.drv_cb.Pselx != 0);
		if(apb_if.drv_cb.Pwrite == 0)
//			apb_if.drv_cb.Prdata <= {$random};
			apb_if.drv_cb.Prdata <= trans.Prdata;

	repeat(2)
	@(apb_if.drv_cb);
	

endtask
