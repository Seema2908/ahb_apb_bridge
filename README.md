The AHB to APB Bridge is a protocol converter module that interfaces a high-performance AHB (Advanced High-performance Bus) master with low-power APB (Advanced Peripheral Bus) slaves.
This design is fully synthesizable and verified using a self-checking Verilog testbench.
Key features include:

FSM-based APB controller ensuring AMBA-compliant timing

One-hot slave selection for up to 4 APB peripherals

Parameterized 512-bit data and address width

Supports read/write, burst-like, and wait-state transfers

Verified using Cadence Xcelium and SimVision


The project demonstrates complete RTL design, verification, and synthesis flow, suitable for SoC integration or academic study.
