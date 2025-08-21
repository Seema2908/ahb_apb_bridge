#Makefile for UVM Testbench
RTL = ../rtl/* +define+WRAPPING_INCR
INF = ../interface/*
INC = +incdir+../test +incdir+../tb/ahb_agent +incdir+../tb/apb_agent  +incdir+../tb/env +incdir+../tb
work= work #library name
SVTB1 =  ../tb/env/ahb_apb_top.sv
SVTB2 = ../test/ahb_apb_test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV = -coverage -sva
VSIMBATCH= -c -do  " log -r /* ; coverage save -onexit coverage; run -all; exit"

	
help:
	@echo =================================================================================
	@echo "! USAGE          --  make target                                                         !"
	@echo "! clean          =>  clean the earlier log and intermediate files.               !"
	@echo "! sv_cmp         =>  Create library and compile the code.                        !"
	@echo "! run_sim    =>  run the simulation in batch mode.                       !"
	@echo "! run_test       =>  clean, compile & run the simulation in batch mode.          !"
	@echo =================================================================================

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INF) $(INC) $(SVTB2) $(SVTB1)

run_sim:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH)  -wlf wave_file1.wlf -l test.log -sv_seed random work.ahb_apb_top +UVM_TESTNAME=ahb_apb_test
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html coverage

clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* coverage* *.wlf modelsim.ini
	clear

run_test: clean sv_cmp run_sim

view_wave1:
	vsim -view wave_file1.wlf

report:
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html coverage

cov:
	firefox covhtmlreport/index.html&
