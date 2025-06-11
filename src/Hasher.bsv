package Hasher;
    
function Bit#(8) computeHash(Bit#(8) a, Bit#(8) b, Bit#(8) c, Bit#(8) d, Bit#(8) e);
    Bit#(8) hex_constant = 8'hAB;
    return (a ^ b ^ c ^ d ^ e) ^ hex_constant;
endfunction

endpackage
