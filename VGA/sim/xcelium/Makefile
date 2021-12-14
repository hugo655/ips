RTL_DIR = ../../RTL
TB_DIR = ../tb

RTL_SV = $(RTL_DIR)/*.sv
TB_SV = $(TB_DIR)/*.sv

TIMESCALE = 1ns/1ps

LOGFILE = $(shell date --iso=seconds)
RUN_ARGS_COMMON = -timescale $(TIMESCALE) -access +r -input ./shm.tcl

all: 
	@printf "Run\n\
	 make sim - To simulate with xrun\n\
	 make waves - To view waveforms \n" 


sim: clean shm.tcl
	@printf "\n#### RUNNING XRUN ####\n\n"
	xrun -64bit $(RTL_SV) $(TB_SV) $(RUN_ARGS_COMMON)

waves:
	@if [ -d "waves.shm" ]; then  simvision waves.shm  ; fi &

shm.tcl:
	@printf "\n#### CREATING ./shm.tcl FILE ####\n\n"
	@if [ ! -f shm.tcl ]; then printf \
	   "database -open waves -shm\nprobe -create just_past_top -depth all -all shm -database waves\nrun\nexit" \
            > shm.tcl; fi
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


