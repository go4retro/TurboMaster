module IC12(
            input _hiram,
            input phi0,
            input [15:10]address,
            input _loram,
            input _charen,
            input r_w,
            output _rom_oe,
            output _6010X,
            output ic12o4,
            output ic12o5,
            output _ram2_ce
          );

/*
O2 = A14' /LORAM'  
     + A13' A12'  
     + A13' /CHAREN 
     + /HIRAM' A13  
     + R/W'  
     + A15'  
     + PHI0'  
     + A14' A13'  
     + /HIRAM' /LORAM' ;

*/
assign _rom_oe  = (!address[14] & !_loram)
                  | (!address[13] & !address[12])
                  | (!address[13] & _charen)
                  | (address[13] & !_hiram) 
                  | !r_w
                  | !address[15]
                  | !phi0
                  | (!address[14] & !address[13])
                  );
/*
O3 = A15  + A14  + A13  + A12  + A11  + A10  + R/W ;
*/
assign _6010X   = (address[15]
                  | address[14]
                  | address[13]
                  | address[12]
                  | address[11]
                  | address[10]
                  | !r_w
                  );
/*
O4 = /HIRAM' A15 A14 A13' A12 /LORAM'  + A15 A14 A13' A12 /CHAREN' + PHI0'  + R/W ;

*/
assign ic12o4   = (
                   (!_hiram & (address[15:12]=='b1101) & !_loram)
                   | (!charen & (address[15:12] == 'b1101))
                   | r_w
                   | !phi0
                   )
                  );
/*
O5 = /HIRAM' /LORAM'  + /CHAREN' + A12'  + A14'  + A15'  + PHI0'  + A13 ;

*/
assign ic12o5   = (
                   (!_hiram & !_loram)
                   |!_charen & !address[12])
                   | !address[14]
                   | !address[15]
                   | !phi0
                   | address[13]
                  )
/*
O7 = A14 A13' A12 /LORAM /CHAREN + /HIRAM A13 /LORAM R/W  + /HIRAM A14 A13' A12 /CHAREN + A14 A13' A12 /LORAM R/W  + /HIRAM A14 A13 R/W  + /HIRAM A14 A12 R/W  + A15'  + PHI0' ;

*/
assign _ram2_ce = (
                   ((address[14:12] == 'b101) & _loram & _charen)
                   | (address[13] & _hiram & _loram & r_w)
                   | ((address[14:12] == 'b101) & _hiram & _charen)
                   | ((address[14:12] == 'b101) & _loram & r_w)
                   | ((address[14:13] == 'b11) & _hiram & r_w)
                   | (address[14] & address[12] & _hiram & r_w)
                   | !address[15]
                   | !phi0
                  );


endmodule


