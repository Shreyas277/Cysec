package Operation;

function Bit#(8) compute(Bit#(8) opcode, Bit#(8) op1, Bit#(8) op2);
    Bit#(8) res;

    case (opcode[2:0])
        3'b000: res = op1 + op2;
        3'b001: res = op1 - op2;
        3'b010: res = op1 & op2;
        3'b011: res = op1 | op2;
        3'b100: res = op1 ^ op2;
        3'b101: res = op1 * op2;
        default: res = 8'd0;
    endcase

    return res;
endfunction

endpackage

