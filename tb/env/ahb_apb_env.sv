class ahb_apb_env extends uvm_env;

	`uvm_component_utils(ahb_apb_env)

	ahb_agent ahb_agenth;
	apb_agent apb_agenth;
	ahb_apb_scoreboard sb;
	ahb_apb_env_config env_cfg;

	// Standard UVM Methods:
	extern function new(string name = "ahb_apb_env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);


endclass

//-----------------  constructor new method  -------------------//
function ahb_apb_env::new(string name = "ahb_apb_env",uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------  build phase method  -------------------//
function void ahb_apb_env::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(ahb_apb_env_config)::get(this, "", "ahb_apb_env_config", env_cfg))
		`uvm_fatal("env_cfg","cannot get() env_cfg from uvm_config_db. have you set() it?")

	uvm_config_db #(ahb_agent_config)::set(this,"ahb_agenth*","ahb_agent_config",env_cfg.ahb_cfg);
	ahb_agenth=ahb_agent::type_id::create("ahb_agenth",this);

	uvm_config_db #(apb_agent_config)::set(this,"apb_agenth*","apb_agent_config",env_cfg.apb_cfg);
	apb_agenth=apb_agent::type_id::create("apb_agenth",this);

	sb = ahb_apb_scoreboard::type_id::create("sb",this);

endfunction

//-----------------  connect phase method  -------------------//
function void ahb_apb_env::connect_phase(uvm_phase phase);

	ahb_agenth.monh.ap.connect(sb.ahb_fifo.analysis_export);
	apb_agenth.monh.ap.connect(sb.apb_fifo.analysis_export);

endfunction
