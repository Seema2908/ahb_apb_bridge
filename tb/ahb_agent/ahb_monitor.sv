class ahb_monitor extends uvm_monitor;

	`uvm_component_utils(ahb_monitor)

	virtual ahb_if.MON_MP ahb_if;

	ahb_agent_config ahb_cfg;
	ahb_trans trans;

	uvm_analysis_port #(ahb_trans) ap;


	// Standard UVM Methods:
	extern function new(string name = "ahb_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();


endclass

//-----------------  constructor new() method  -------------------//
function ahb_monitor::new(string name ="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	ap = new("ap",this);
endfunction

//-----------------  build_phase() method  -------------------//
function void ahb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
		`uvm_fatal("CONFIG","cannot get() ahb_cfg from uvm_config_db. Have you set() it?")
endfunction

//-----------------  connect_phase() method  -------------------//
function void ahb_monitor::connect_phase(uvm_phase phase);
	ahb_if = ahb_cfg.ahb_if;
endfunction

//-----------------  run_phase() method  -------------------//
task ahb_monitor::run_phase(uvm_phase phase);

	forever
		begin
//			wait(ahb_if.mon_cb.Hreadyout && (ahb_if.mon_cb.Htrans == 2'b10 || ahb_if.mon_cb.Htrans == 2'b11))
 			collect_data();
		end

endtask

//-----------------  collect_data() method  -------------------//
task ahb_monitor::collect_data();

	trans = ahb_trans::type_id::create("trans");

			wait(ahb_if.mon_cb.Hreadyout && (ahb_if.mon_cb.Htrans == 2'b10 || ahb_if.mon_cb.Htrans == 2'b11))
	trans.Haddr = ahb_if.mon_cb.Haddr;
	trans.Htrans = ahb_if.mon_cb.Htrans;
	trans.Hwrite = ahb_if.mon_cb.Hwrite;
	trans.Hsize = ahb_if.mon_cb.Hsize;
	trans.Hburst = ahb_if.mon_cb.Hburst;

	@(ahb_if.mon_cb);
	wait(ahb_if.mon_cb.Hreadyout && (ahb_if.mon_cb.Htrans == 2'b10 || ahb_if.mon_cb.Htrans == 2'b11))
		trans.Hwdata = ahb_if.mon_cb.Hwdata;

	trans.print();
	ap.write(trans);

endtask

