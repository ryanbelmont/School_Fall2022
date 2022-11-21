#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun Nov 20 20:10:44 CST 2022
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim tb_cpu_p1_behav -key {Behavioral:sim_1:Functional:tb_cpu_p1} -tclbatch tb_cpu_p1.tcl -log simulate.log"
xsim tb_cpu_p1_behav -key {Behavioral:sim_1:Functional:tb_cpu_p1} -tclbatch tb_cpu_p1.tcl -log simulate.log

