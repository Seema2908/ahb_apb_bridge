class apb_agent_config extends uvm_object;


        // UVM Factory Registration Macro
        `uvm_object_utils(apb_agent_config)
          
        virtual apb_if apb_if;

        //Declare parameter is_active of type uvm_active_passive_enum and assign it to UVM_ACTIVE
        uvm_active_passive_enum is_active = UVM_ACTIVE;


        //------------------------------------------
        // Methods
        //------------------------------------------
        // Standard UVM Methods:
        extern function new(string name = "apb_agent_config");

endclass: apb_agent_config
//-----------------  constructor new method  -------------------//

function apb_agent_config::new(string name = "apb_agent_config");
  super.new(name);
endfunction
