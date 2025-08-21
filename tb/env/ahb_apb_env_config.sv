class ahb_apb_env_config extends uvm_object;
     `uvm_object_utils(ahb_apb_env_config)

    uvm_active_passive_enum is_active = UVM_ACTIVE;

    ahb_agent_config ahb_cfg;
    apb_agent_config apb_cfg;
    
   extern function new(string name = "ahb_apb_env_config");

endclass: ahb_apb_env_config

function ahb_apb_env_config::new(string name = "ahb_apb_env_config");
     super.new(name);
endfunction
