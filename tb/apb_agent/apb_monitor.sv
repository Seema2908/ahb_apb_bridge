class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

	virtual apb_if.MON_MP apb_if;

	apb_agent_config apb_cfg;
	apb_trans trans;

	uvm_analysis_port #(apb_trans) ap;

	// Standard UVM Methods:
	extern function new(string name = "apb_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass

//-----------------  constructor new() method  -------------------//
function apb_monitor::new(string name ="apb_monitor",uvm_component parent);
	super.new(name,parent);
	ap = new("ap",this);
endfunction

//-----------------  build_phase() method  -------------------//
function void apb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
		`uvm_fatal("CONFIG","cannot get() apb_cfg from uvm_config_db. Have you set() it?")
endfunction

//-----------------  connect_phase() method  -------------------//
function void apb_monitor::connect_phase(uvm_phase phase);
	apb_if = apb_cfg.apb_if;
endfunction

//-----------------  run_phase() method  -------------------//
task apb_monitor::run_phase(uvm_phase phase);

	@(apb_if.mon_cb);
	forever
		begin
			collect_data();
		end

endtask

//-----------------  collect_data() method  -------------------//
task apb_monitor::collect_data();

	apb_trans trans;
	trans = apb_trans::type_id::create("trans");

	wait(apb_if.mon_cb.Penable)
	trans.Pselx = apb_if.mon_cb.Pselx;
	trans.Pwrite = apb_if.mon_cb.Pwrite;
	trans.Paddr = apb_if.mon_cb.Paddr;

	if(apb_if.mon_cb.Pwrite==1)
		trans.Pwdata = apb_if.mon_cb.Pwdata;
	else
		trans.Prdata = apb_if.mon_cb.Prdata;

	@(apb_if.mon_cb);
	trans.print();
	ap.write(trans);

endtask
