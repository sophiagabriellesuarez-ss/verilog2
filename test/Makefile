# Makefile
SIM ?= icarus
TOPLEVEL_LANG = verilog

SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = project.v

ifeq ($(SIM), icarus)
	VERILOG_SOURCES += $(shell find $(SRC_DIR) -name "*.v")
	COMPILE_ARGS += -DSIM
	COMPILE_ARGS += -I$(SRC_DIR)
endif

# top-level RTL module
TOPLEVEL = tt_um_dipswitch_7seg

# cocotb python test module (test.py)
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
