`include "Defines.v"

module ProjectAmadeus();

// Hard-Coded input
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongA;
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongB;

// Data for Markov Chains
reg [SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN-1:0] MarkovChains [0:MARKOV_CHAIN_LEN*4-1];

// I/O for modules
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAB;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBB;

// Decomposition
MusicInputDecomposition decompA(
  inputSongA, fragAA, fragAB
);

MusicInputDecomposition decompB(
  inputSongB, fragBA, fragBB
);





endmodule