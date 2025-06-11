# Cysec
This project is a simplified CPU model built using Bluespec SystemVerilog (BSV). It demonstrates how hardware description languages (HDLs) like BSV differ from traditional programming languages and implements a basic instruction execution pipeline with hashing and verification mechanisms.

📦 Project Structure
```text
├── README.md                # This file     <br>
├── Discussion.md            # Answers to discussion questions  <br>
/logs
     ├── log.txt                  # Testbench log for passed/failed verification  <br>
/src
     ├── Main.bsv                 # Top-level module combining B, C, D  <br>
     ├── Operation.bsv            # Module B: 8-bit opcode-based ALU  <br>
     ├── Hasher.bsv               # Module C: XOR-fold hash logic  <br>
     ├── Signer.bsv               # Module D: XOR with 0xAB for signature  <br>
     └── Testbench.bsv            # Simulates CPU, verifies signature   <br>
```

# Installation SetUp
```bash
git clone https://github.com/B-Lang-org/bsc.git
cd bsc
./configure
make
sudo make install
```

Note: We need to also install all the dependencies mentioned in the README.md file of the Bsc github.

The Testbench.bsv file contains the set of test cases which are passed to the cpu thats our Main.bsv to compute the results of the problem and sign the result and send it back to it. The Testbench.bsv verifies if there was any tampering or not by comparing the hashes.

Command for the execution of the program are
```bash
 bsc -u -sim -g mkTestbench Testbench.bsv

 bsc -sim -e mkTestbench -o sim_testbench

 ./sim_testbench
```

 Sample Output:
![image](https://github.com/user-attachments/assets/15c5a38d-de68-48d4-b362-263ebd5cb123)

Main.bsv receives is not receiving the string as a input as the code needed to be hardcoded that's we would not be able to generalise it for all the inputs. Hence I faced many issues while parsing the input string to give out the numbers from it.

Hence the Testbench.bsv is sending parsed version of the input string thats the 5 integers as input. Main.bsv firstly calculates the result of the input with the help of Operation.bsv and then Hash of the input from Hasher.bsv. The hex_constant = 8'hAB. 

Later the computed result is signed with the hash by appending the hash at the end of result and sent back to Testbench.bsv which verifies it.

log.txt consits of some of the outputs obtained for various cases.

For the parsing of the string I have tried using the BDPI thats performing the entire parsing using a c file and send it back to the bsv file. But these can only be done for simulation purposes and cannot be syntesized. Hence not valid for us.

```bash
bsc -sim -u stringparser2.bsv
```


![image](https://github.com/user-attachments/assets/878f4a02-02d5-4503-b783-4f066c9b9a56)


