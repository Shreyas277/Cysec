# Cysec
This project is a simplified CPU model built using Bluespec SystemVerilog (BSV). It demonstrates how hardware description languages (HDLs) like BSV differ from traditional programming languages and implements a basic instruction execution pipeline with hashing and verification mechanisms.

📦 Project Structure
├── README.md                # This file
├── Discussion.md            # Answers to discussion questions
├── log.txt                  # Testbench log for passed/failed verification
│── Main.bsv                 # Top-level module combining B, C, D
│── Operation.bsv            # Module B: 8-bit opcode-based ALU
│── Hasher.bsv               # Module C: XOR-fold hash logic
│── Signer.bsv               # Module D: XOR with 0xAB for signature
├── Testbench.bsv            # Simulates CPU, verifies signature

Installation SetUp

git clone https://github.com/B-Lang-org/bsc.git
cd bsc
./configure
make
sudo make install

The Testbench.bsv file contains the set of test cases which are passed to the cpu thats our Main.bsv to compute the results of the problem and sign the result and send it back to it. The Testbench.bsv verifies if there was any tampering or not by comparing the hashes.

