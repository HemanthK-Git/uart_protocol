# UART Protocol - SystemVerilog Implementation

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-blue.svg)](https://en.wikipedia.org/wiki/SystemVerilog)
[![Status](https://img.shields.io/badge/Status-In%20Development-orange.svg)](https://github.com/HemanthK-Git/uart_protocol)

A comprehensive UART (Universal Asynchronous Receiver-Transmitter) protocol implementation in SystemVerilog, designed for FPGA/ASIC development and verification.

## 📋 Table of Contents

- [About UART](#about-uart)
- [Features](#features)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Simulation](#simulation)
- [Synthesis](#synthesis)
- [Verification](#verification)
- [Development Roadmap](#development-roadmap)
- [Contributing](#contributing)
- [License](#license)

## 🔍 About UART

UART (Universal Asynchronous Receiver-Transmitter) is a hardware communication protocol that uses asynchronous serial communication with configurable speed. It's widely used in embedded systems, microcontrollers, and communication interfaces.

### Key Characteristics:
- **Asynchronous**: No shared clock between transmitter and receiver
- **Serial**: Data transmitted one bit at a time
- **Full-duplex**: Simultaneous bidirectional communication
- **Configurable**: Adjustable baud rate, data bits, parity, and stop bits

## ✨ Features

### Current Implementation
- [x] Project structure and repository setup
- [x] Basic module templates
- [ ] UART Transmitter (TX)
  - [ ] Configurable baud rate generator
  - [ ] Start/stop bit insertion
  - [ ] Parity bit generation (even/odd/none)
  - [ ] Configurable data width (5-9 bits)
- [ ] UART Receiver (RX)
  - [ ] Baud rate synchronization
  - [ ] Start bit detection
  - [ ] Data sampling and recovery
  - [ ] Parity checking
  - [ ] Frame error detection
- [ ] Advanced Features
  - [ ] FIFO buffers for TX/RX
  - [ ] Flow control (RTS/CTS)
  - [ ] Break detection
  - [ ] Overrun error detection

### Testbench Features
- [ ] Comprehensive UVM/SystemVerilog testbench
- [ ] Randomized stimulus generation
- [ ] Functional coverage
- [ ] Assertion-based verification
- [ ] Waveform analysis scripts

## 📁 Project Structure

```
uart_protocol/
├── rtl/
│   ├── uart.sv              # Top-level UART module
│   ├── uart_tx.sv           # Transmitter module (planned)
│   ├── uart_rx.sv           # Receiver module (planned)
│   └── baud_gen.sv          # Baud rate generator (planned)
├── tb/
│   ├── uart_tb.sv           # Main testbench
│   ├── uart_monitor.sv      # Transaction monitor (planned)
│   └── uart_scoreboard.sv   # Verification scoreboard (planned)
├── sim/
│   └── scripts/             # Simulation scripts (planned)
├── docs/
│   └── specifications.md    # Design specifications (planned)
├── uart_protocol.xpr        # Vivado project file
├── .gitignore
└── README.md
```

## 🏗️ Architecture

### UART Frame Format

```
┌─────┬──────┬──────┬─────────┬────────┬──────────┐
│START│ D0   │ D1   │   ...   │ PARITY │   STOP   │
│ (1) │      │      │   D7    │  (opt) │  (1-2)   │
└─────┴──────┴──────┴─────────┴────────┴──────────┘
  Idle                                          Idle
 (High)                                        (High)
```

### Block Diagram

```
┌─────────────────────────────────────────────────┐
│              UART Top Module                    │
│                                                 │
│  ┌──────────────┐         ┌──────────────┐    │
│  │   Baud Rate  │         │   Baud Rate  │    │
│  │  Generator   │         │  Generator   │    │
│  └──────┬───────┘         └──────┬───────┘    │
│         │                        │             │
│  ┌──────▼───────┐         ┌──────▼───────┐    │
│  │     TX       │         │     RX       │    │
│  │  Transmitter │         │   Receiver   │    │
│  │              │         │              │    │
│  │  - FSM       │         │  - FSM       │    │
│  │  - Shift Reg │         │  - Shift Reg │    │
│  │  - Parity    │         │  - Parity    │    │
│  └──────┬───────┘         └──────┬───────┘    │
│         │                        │             │
│      TX_OUT                   RX_IN            │
└─────────┼────────────────────────┼─────────────┘
          │                        │
          └────────────────────────┘
              Serial Connection
```

## 🚀 Getting Started

### Prerequisites

- **Vivado Design Suite** (2020.1 or later) - for simulation and synthesis
- **ModelSim/QuestaSim** (optional) - alternative simulator
- **Git** - for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/HemanthK-Git/uart_protocol.git
   cd uart_protocol
   ```

2. **Open in Vivado**
   ```bash
   vivado uart_protocol.xpr
   ```

3. **Or use command-line simulation** (once implemented)
   ```bash
   cd sim
   make compile
   make simulate
   ```

## ⚙️ Configuration

The UART module will support the following configurable parameters:

| Parameter      | Description                    | Default Value |
|----------------|--------------------------------|---------------|
| `CLK_FREQ`     | System clock frequency (Hz)    | 100_000_000   |
| `BAUD_RATE`    | UART baud rate (bps)          | 9600          |
| `DATA_BITS`    | Number of data bits           | 8             |
| `PARITY_EN`    | Enable parity checking        | 1 (enabled)   |
| `PARITY_TYPE`  | Parity type (0=even, 1=odd)   | 0 (even)      |
| `STOP_BITS`    | Number of stop bits           | 1             |

### Example Instantiation (Planned)

```systemverilog
uart #(
    .CLK_FREQ    (100_000_000),
    .BAUD_RATE   (115200),
    .DATA_BITS   (8),
    .PARITY_EN   (1),
    .PARITY_TYPE (0),
    .STOP_BITS   (1)
) uart_inst (
    .clk        (clk),
    .rst_n      (rst_n),
    .tx_data    (tx_data),
    .tx_valid   (tx_valid),
    .tx_ready   (tx_ready),
    .tx_out     (tx_out),
    .rx_in      (rx_in),
    .rx_data    (rx_data),
    .rx_valid   (rx_valid),
    .rx_error   (rx_error)
);
```

## 🧪 Simulation

### Running Testbench in Vivado

1. Open the project in Vivado
2. Click on **Run Simulation** → **Run Behavioral Simulation**
3. Analyze waveforms in the Vivado simulator

### Expected Test Scenarios (Planned)

- ✅ Basic TX/RX loopback test
- ✅ Different baud rates (9600, 115200, 921600)
- ✅ Parity error injection and detection
- ✅ Frame error scenarios
- ✅ Back-to-back transmission
- ✅ Random data patterns

## 🔨 Synthesis

### Target Devices

- **Xilinx FPGAs**: Artix-7, Spartan-7, Zynq-7000
- **Intel FPGAs**: Cyclone V, MAX 10
- **ASIC**: Synthesizable for standard cell libraries

### Resource Utilization (Estimated)

| Resource | Estimated Count |
|----------|----------------|
| LUTs     | ~150           |
| FFs      | ~100           |
| BRAMs    | 0 (or 1-2 if FIFO enabled) |

## ✅ Verification

### Verification Strategy

- **Directed Tests**: Specific scenarios and corner cases
- **Constrained Random**: Randomized stimulus with constraints
- **Functional Coverage**: Track feature coverage
- **Code Coverage**: Line, branch, and FSM coverage
- **Assertions**: SVA for protocol compliance

## 🗺️ Development Roadmap

### Phase 1: Core Implementation (In Progress)
- [ ] Baud rate generator module
- [ ] UART transmitter FSM
- [ ] UART receiver FSM
- [ ] Basic testbench

### Phase 2: Verification
- [ ] Comprehensive testbench with monitors
- [ ] Scoreboard implementation
- [ ] Functional coverage
- [ ] Assertion-based verification

### Phase 3: Advanced Features
- [ ] FIFO integration
- [ ] Flow control (RTS/CTS)
- [ ] AXI-Stream interface wrapper
- [ ] DMA support

### Phase 4: Documentation & Examples
- [ ] Detailed design documentation
- [ ] Example applications
- [ ] FPGA demo on development board
- [ ] Performance benchmarking

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

**Hemanth Kumar** - [@HemanthK-Git](https://github.com/HemanthK-Git)

Project Link: [https://github.com/HemanthK-Git/uart_protocol](https://github.com/HemanthK-Git/uart_protocol)

---

## 📚 References

- [UART Protocol Specification](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter)
- [SystemVerilog IEEE 1800-2017 Standard](https://ieeexplore.ieee.org/document/8299595)
- [Vivado Design Suite User Guide](https://www.xilinx.com/support/documentation-navigation/design-hubs/dh0010-vivado-simulation-hub.html)

---

⭐ **Star this repository if you find it helpful!**

*Last Updated: January 12, 2026*
