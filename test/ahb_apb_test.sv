class ahb_apb_test extends uvm_test;

	`uvm_component_utils(ahb_apb_test)

	ahb_apb_env env;
	ahb_apb_env_config env_cfg;

	ahb_agent_config ahb_cfg;
	apb_agent_config apb_cfg;

	ahb_seqs ahb_seqh;
	apb_sequence apb_seqh;

	// Standard UVM Methods:
	extern function new(string name = "ahb_apb_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//-----------------  constructor new method  -------------------//
function ahb_apb_test::new(string name = "ahb_apb_test" , uvm_component parent);
	super.new(name,parent);
endfunction


//-----------------  build_phase() method  -------------------//
function void ahb_apb_test::build_phase(uvm_phase phase);

	super.build_phase(phase);

	env_cfg = ahb_apb_env_config::type_id::create("env_cfg");

	ahb_cfg = ahb_agent_config::type_id::create("ahb_cfg");
	ahb_cfg.is_active=UVM_ACTIVE;
	if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg.ahb_if ))
		`uvm_fatal("V_AHB_IF CONFIG","cannot get()interface ahb_if from uvm_config_db. Have you set() it?")
	env_cfg.ahb_cfg = ahb_cfg;

	apb_cfg = apb_agent_config::type_id::create("apb_cfg");
	apb_cfg.is_active=UVM_ACTIVE;
	if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_if",apb_cfg.apb_if ))
		`uvm_fatal("V_APB_IF CONFIG","cannot get()interface apb_if from uvm_config_db. Have you set() it?")
	env_cfg.apb_cfg = apb_cfg;

	env = ahb_apb_env::type_id::create("env",this);

	uvm_config_db #(ahb_apb_env_config)::set(this,"*","ahb_apb_env_config", env_cfg);

endfunction

function void ahb_apb_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

//-----------------  run_phase() method  -------------------//
task ahb_apb_test::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	ahb_seqh=ahb_seqs::type_id::create("ahb_seqh",this);
//	ahb_seqh.start(env.ahb_agenth.seqrh);
	apb_seqh=apb_sequence::type_id::create("apb_seqh",this);
	ahb_seqh.start(env.ahb_agenth.seqrh);
	apb_seqh.start(env.apb_agenth.seqrh);
	phase.drop_objection(this);
endtask
