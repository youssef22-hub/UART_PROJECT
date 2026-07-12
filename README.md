# UART-Based Multi-Clock Digital System

## Overview
This project implements a UART-based multi-clock digital system designed using Verilog HDL. The system receives commands through a UART receiver, performs register file read/write operations or ALU computations, and transmits the results back through a UART transmitter. An asynchronous FIFO is used to safely transfer data between different clock domains.

## Features
- UART Transmitter (TX)
- UART Receiver (RX)
- 16-bit ALU
- Register File
- Asynchronous FIFO
- Clock Divider
- Clock Gating
- Clock Domain Synchronizers
- Main Controller (FSM)
- Multi-clock domain operation
- Self-checking verification environment

## System Architecture

```
          UART RX
             |
             v
      Main Controller
      /             \
Register File      ALU
      \             /
             |
     Asynchronous FIFO
             |
         UART TX
```

## Project Flow
- RTL Design using Verilog HDL
- Functional Simulation
- Self-Checking Testbench Verification
- RTL Synthesis
- Static Timing Analysis (STA)
- Design for Testability (DFT)
- Formal Verification
- ASIC Physical Design Flow
- Post-Layout Verification

## Directory Structure

```
UART_PROJECT/
│
├── RTL/
├── Verification/
├── SYN/
├── DFT/
├── STA/
├── APR/
├── Reports/
└── README.md
```

## Tools Used
- Verilog HDL
- ModelSim / QuestaSim
- Synopsys Design Compiler
- Synopsys Formality
- PrimeTime
- IC Compiler II / Innovus (ASIC Flow)

## Applications
- Digital Communication Systems
- ASIC Design
- FPGA Prototyping
- Embedded Systems
- Multi-Clock Digital Systems

## Author
**Youssef Waleed Fathi**

Electronics & Electrical Communications Engineering  


