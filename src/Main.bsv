package Main;

import Operation :: *;
import Hasher :: *;
import Signer :: *;

interface MainIfc;
    method Action sendFiveInputs(Int#(8) val1, Int#(8) op1, Int#(8) val2, Int#(8) op2, Int#(8) val3);
    method Bit#(8) getFinalResult();
    method Bit#(8) getHashResult();
    method Bit#(16) getSignedResult();
endinterface

module mkMain(MainIfc);
    Reg#(Bit#(8)) result <- mkReg(0);
    Reg#(Bit#(8)) hash <- mkReg(0);
    Reg#(Bit#(16)) signedResult <- mkReg(0);
    method Action sendFiveInputs(Int#(8) val1, Int#(8) op1, Int#(8) val2, Int#(8) op2, Int#(8) val3);
        // Convert to Bit#(8) using pack()
        Bit#(8) bval1 = pack(val1);
        Bit#(8) bop1  = pack(op1);
        Bit#(8) bval2 = pack(val2);
        Bit#(8) bop2  = pack(op2);
        Bit#(8) bval3 = pack(val3);

        Bit#(8) temp = compute(bop1, bval1, bval2);
        Bit#(8) result1 = compute(bop2, temp, bval3);
	Bit#(8) computed_hash = computeHash(bval1,bop1,bval2,bop2,bval3);
	Bit#(16) signed_result = signer_append(result1, computed_hash);

        result <= result1;
        hash <= computed_hash;
        signedResult <= signed_result;
    endmethod

    method Bit#(8) getFinalResult();
        return result;
    endmethod

    method Bit#(8) getHashResult();
        return hash;
    endmethod

    method Bit#(16) getSignedResult();
        return signedResult;
    endmethod
endmodule

endpackage

