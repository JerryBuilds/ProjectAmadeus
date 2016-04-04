`include "Defines.v"

module MusicInputDecomposition(
  input [2399:0] InputSong,
  output [1199:0] FragmentA,
  output [1199:0] FragmentB
);

assign FragmentA = InputSong[2399:1200];
assign FragmentB = InputSong[1199:0];

endmodule