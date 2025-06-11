package Testbench;
import Main :: *;

typedef enum {
    Test1_Send,
    Test1_Display,
    Test1_Verify,
    Test2_Send,
    Test2_Display,
    Test2_Verify,
    Test3_Send,
    Test3_Display,
    Test3_Verify,
    TestDone
} TestState deriving (Bits, Eq);

// Verification function
function Bool verifySignature(Bit#(8) result, Bit#(16) signature, Bit#(8) val1, Bit#(8) op1, Bit#(8) val2, Bit#(8) op2, Bit#(8) val3);
    // Extract result and hash from signature
    // Assuming signature format: {result[7:0], hash[7:0]} = 16 bits total
    Bit#(8) extracted_result = signature[15:8];  // Upper 8 bits
    Bit#(8) extracted_hash = signature[7:0];    // Lower 8 bits
    
    // Verification constant (can be changed as needed)
    Bit#(8) verification_constant = 8'hAB;  // Example constant
    
    // Verify result matches
    Bool result_valid = (result == extracted_result);
    
    // Compute hash by XORing all 5 input values
    Bit#(8) comp_hash = val1 ^ op1 ^ val2 ^ op2 ^ val3;
    
    // Verify hash: extracted_hash XOR verification_constant should equal comp_hash
    Bool hash_valid = ((extracted_hash ^ verification_constant) == comp_hash);
    
    return (result_valid && hash_valid);
endfunction

module mkTestbench();
    MainIfc main <- mkMain;
    Reg#(TestState) state <- mkReg(Test1_Send);
    
    rule test_fsm;
        case (state)
            Test1_Send: begin
                $display("=== Test 1: Addition and Subtraction ===");
                $display("Sending: val1=10, op1=0(+), val2=5, op2=1(-), val3=3");
                $display("Expected: ((10 + 5) - 3) = 12");
                main.sendFiveInputs(10, 0, 5, 1, 3);
                state <= Test1_Display;
            end
            
            Test1_Display: begin
                $display("Result: %0d", main.getFinalResult());
                $display("Signature: 0x%0h", main.getSignedResult());
                state <= Test1_Verify;
            end
            
            Test1_Verify: begin
                Bool is_valid = verifySignature(main.getFinalResult(), main.getSignedResult(), 
                                               8'd10, 8'd0, 8'd5, 8'd1, 8'd3);
                if (is_valid)
                    $display(" Signature VERIFIED - Test 1 PASSED");
                else
                    $display(" Signature INVALID - Test 1 FAILED");
                $display("");
                state <= Test2_Send;
            end
            
            Test2_Send: begin
                $display("=== Test 2: Multiplication and Division ===");
                $display("Sending: val1=8, op1=2(*), val2=4, op2=3(/), val3=2");
                $display("Expected: ((8 * 4) / 2) = 16");
                main.sendFiveInputs(8, 2, 4, 3, 2);
                state <= Test2_Display;
            end
            
            Test2_Display: begin
                $display("Result: %0d", main.getFinalResult());
                $display("Signature: 0x%0h", main.getSignedResult());
                state <= Test2_Verify;
            end
            
            Test2_Verify: begin
                Bool is_valid = verifySignature(main.getFinalResult(), main.getSignedResult(),
                                               8'd8, 8'd2, 8'd4, 8'd3, 8'd2);
                if (is_valid)
                    $display(" Signature VERIFIED - Test 2 PASSED");
                else
                    $display(" Signature INVALID - Test 2 FAILED");
                $display("");
                state <= Test3_Send;
            end
            
            Test3_Send: begin
                $display("=== Test 3: Bitwise Operations ===");
                $display("Sending: val1=12, op1=4(&), val2=10, op2=5(|), val3=3");
                $display("Expected: ((12 & 10) | 3) = 11");
                main.sendFiveInputs(12, 4, 10, 5, 3);
                state <= Test3_Display;
            end
            
            Test3_Display: begin
                $display("Result: %0d", main.getFinalResult());
                $display("Signature: 0x%0h", main.getSignedResult());
                state <= Test3_Verify;
            end
            
            Test3_Verify: begin
                Bool is_valid = verifySignature(main.getFinalResult(), main.getSignedResult(),
                                               8'd12, 8'd4, 8'd10, 8'd5, 8'd3);
                if (is_valid)
                    $display(" Signature VERIFIED - Test 3 PASSED");
                else
                    $display(" Signature INVALID - Test 3 FAILED");
                $display("");
                state <= TestDone;
            end
            
            TestDone: begin
                $display("=== All Tests Completed ===");
                $display("Verification: Result extraction + Hash validation using XOR with constant");
                $finish;
            end
        endcase
    endrule
endmodule
endpackage
