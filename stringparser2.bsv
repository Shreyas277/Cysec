
// BDPI imports
import "BDPI" function ActionValue#(int) parseExpr(String str);
import "BDPI" function ActionValue#(int) getVal0();
import "BDPI" function ActionValue#(int) getVal1();
import "BDPI" function ActionValue#(int) getVal2();
import "BDPI" function ActionValue#(int) getVal3();
import "BDPI" function ActionValue#(int) getVal4();

(* synthesize *)
module mkTest2 (Empty);
   Reg#(Bool) started <- mkReg(False);

   rule go (!started);
      started <= True;
      String expr = "12+4-23";
      let ok <- parseExpr(expr);
      if (ok == 1) begin
         let v0 <- getVal0();
         let v1 <- getVal1();
         let v2 <- getVal2();
         let v3 <- getVal3();
         let v4 <- getVal4();
         $display("Parsed Expression: %s", expr);
         $display("Output: %0d, %0d, %0d, %0d, %0d", v0, v1, v2, v3, v4);
      end else begin
         $display("Error parsing expression!");
      end
      $finish;
   endrule
endmodule



