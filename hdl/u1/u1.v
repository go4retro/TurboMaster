module ic13(
            input a15,
            input a14,
            input a13,
            input a1,
            input a0,
            input phi0,
            input _reset,
            input _disable
            input sel_rom,
            input _eq1402x
            output clk_write_$0000,
            output _en_$0001,
            output clk_write_$0001,
            output _ram1_ce,
            output _so,
            output _rdy,
            output rom_a13,
            output rom_a14
            );

/*O0 = /RESET'  + PHI0'  + A1  + A0  + /eq000X;*/
assign clk_write_$0000  = !_reset | !phi0 | a1 | a0 | _eq1402x;
/*O1 = /RESET'  + PHI0'  + /eq000X;*/
assign _en_$0001        =!_reset | !phi0 | _eq1402x;
/*O2 = /RESET'  + PHI0'  + A0'  + A1  + /eq000X;*/
assign clk_write_$0001  = !_reset | !phi0 | !a0 | a1 | _eq1402x;
/*O3 = PHI0'  + A15 ;*/
assign _ram1_ce         = a15 | !phi0
/*O4 = 1;*/
assign _so              = 1;
/*O5 = /DISABLE' ;*/
assign _rdy             = !_disable;
/*O6 = A14 SEL_ROM'  + A14 A13' ;*/
assign rom_a13          = (a14 & sel_rom) | (a14 & !a13);
/*O7 = A14 A13 ;*/
assign rom_a14          = a14 & a13;

endmodule

