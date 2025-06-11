package Signer;

// Define a type alias for the return type
typedef Bit#(TAdd#(n, 8)) SignedResult#(numeric type n);

function SignedResult#(n) signer_append
  (Bit#(n) result,
   Bit#(8) hash)
  provisos (Add#(n, 8, TAdd#(n, 8)));
   Bit#(TAdd#(n, 8)) extended_result = extend(result);
   return (extended_result << 8) | extend(hash);
endfunction

endpackage
