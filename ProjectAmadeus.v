`include "Defines.v"

module ProjectAmadeus();

// Hard-Coded input
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongA;
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongB;

// Data for Markov Chains
reg [SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN-1:0] MarkovChains [0:MARKOV_CHAIN_LEN*4-1];


/**************************************
// I/O for modules
**************************************/

// start
wire m1mAstart, m1mBstart;
wire m2mstart;


// done
wire mlmAAdone, mlmABdone, mlmBAdone, mlmBBdone;
wire m1mAdone, m1mBdone;
wire m2mdone;


//
assign m1mAstart = mlmAAdone && mlmABdone;
assign m1mBstart = mlmBAdone && mlmBBdone;
assign m2mstart = m1mAdone && m1mBdone;



wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAB;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBB;


wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovAA;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovAB;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovBA;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovBB;


/**************************************
// Module Instantiation
**************************************/

// Decomposition
MusicInputDecomposition decompA(
  inputSongA, fragAA, fragAB
);

MusicInputDecomposition decompB(
  inputSongB, fragBA, fragBB
);


// Machine Learning Markov
MachineLearningMarkov mlkAA(
  
);



// Markov First Merge





endmodule