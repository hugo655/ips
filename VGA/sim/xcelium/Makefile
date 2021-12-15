RTL_DIR = ../../RTL
TB_DIR = ../tb
AUX_MODULES_DIR = ../aux_modules

RTL_LIST = *.sv
AUX_MODULES_LIST = *.sv
TB = tb.sv

TIMESCALE = 1ns/1ps

LOGFILE = $(shell date --iso=seconds)
RUN_ARGS_COMMON = -timescale $(TIMESCALE) -access +r -input ./shm.tcl

all: 
	@printf "Run\n\
	 make sim TB=<tb_name> - To simulate with xrun\n \
	 TB options:\n\
	 \t*core_480 \n\
	 \t*VGA \n\
	\n\
	 make waves -  view waveforms with simvision \n \
	\n\
	 make clean_waves - To delete waveforms \n \
	\n\
	 make clean - To save log files and clean this directory - preserves waveforms \n \
	\n"  

sim: clean shm.tcl
	@printf "\n#### RUNNING XRUN ####\n\n"
	xrun -64bit $(RTL_DIR)/$(RTL_LIST) $(AUX_MODULES_DIR)/$(AUX_MODULES_LIST) $(TB_DIR)/$(TB)_tb.sv $(RUN_ARGS_COMMON)

waves:
	@if [ -d "waves.shm" ]; then  simvision waves.shm  ; fi &

shm.tcl:
	@printf "\n#### CREATING ./shm.tcl FILE ####\n\n"
	@if [ ! -f shm.tcl ]; then printf \
	   "database -open waves -shm\nprobe -create just_past_top -depth all -all shm -database waves\nrun\nexit" \
            > shm.tcl; fi
clean_waves:
	@printf "\n#### DELETING WAVEFORMS !! ####\n\n"
	@if [ -d "waves.shm" ]; then rm -rf waves.shm  ; fi
clean:
	@printf "\n#### COPYING LOGS AND CLEANING DIRECTORY ####\n\n"
	@if [ ! -d "./logs" ]; then printf  'Making  directory  ./logs ... \n' ; mkdir ./logs ; fi	
	@if [ -f xrun.log ] ; then \
	  printf 'Copying xrun.log to ./logs/$(LOGFILE).log ... \n ' ;\
           mv xrun.log logs/$(LOGFILE).log; fi
	@if [ -f xrun.history ] ; then \
           printf 'Copying xrun.history to ./logs/$(LOGFILE).history  ... \n\n\n' ;\
          mv xrun.history logs/$(LOGFILE).history; fi
	@rm -rf xcelium.d
	@if [ -f "xrun.key" ]; then rm xrun.key ; fi


