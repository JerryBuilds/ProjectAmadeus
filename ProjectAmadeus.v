module ProjectAmadeus();

// Hard-Coded input
reg [2399:0] inputSongA;
reg [2399:0] inputSongB;

// Data for Markov Chains
reg [271:0] MarkovChains [0:155];

// I/O for modules
wire [1199:0] fragAA;
wire [1199:0] fragAB;
wire [1199:0] fragBA;
wire [1199:0] fragBB;

MusicInputDecomposition decompA(
  inputSongA, fragAA, fragAB
);

MusicInputDecomposition decompB(
  inputSongB, fragBA, fragBB
);



endmodule