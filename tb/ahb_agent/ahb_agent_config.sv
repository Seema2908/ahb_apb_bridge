class ahb_agent_config extends uvm_object;


        // UVM Factory Registration Macro
        `uvm_object_utils(ahb_agent_config)

        virtual ahb_if ahb_if;
        
        uvm_active_passive_enum is_active = UVM_ACTIVE;
        
	extern function new(string name = "ahb_agent_config");

endclass: ahb_agent_config
//-----------------  constructor new method  -------------------//

function ahb_agent_config::new(string name = "ahb_agent_config");
  super.new(name);
endfunction
