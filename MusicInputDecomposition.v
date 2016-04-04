module MusicInputDecomposition(
  input [799:0] InputSong,
  output [399:0] FragmentA,
  output [399:0] FragmentB
);

assign FragmentA = InputSong[799:400];
assign FragmentB = InputSong[399:0];

endmodule