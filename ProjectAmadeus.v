`include "Defines.v"

module ProjectAmadeus(
  input clk, reset
);

// Hard-Coded input
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongA;
reg [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)-1:0] inputSongB;

// Data for Markov Chains
reg [SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN-1:0] MarkovChains [0:MARKOV_CHAIN_LEN*4-1];

//*************************************
// I/O for modules
//*************************************

// start
wire markovMerge1Astart, markovMerge1Bstart;
wire markovMerge2start;


// done
wire markovLearnAAdone, markovLearnABdone, markovLearnBAdone, markovLearnBBdone;
wire markovMerge1Adone, markovMerge1Bdone;
wire markovMerge2done;


// wiring previous done's to next start's
assign markovMerge1Astart = markovLearnAAdone && markovLearnABdone;
assign markovMerge1Bstart = markovLearnBAdone && markovLearnBBdone;
assign markovMerge2start = markovMerge1Adone && markovMerge1Bdone;



wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragAB;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBA;
wire [SONG_INPUT_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)/2-1:0] fragBB;

// packed declarations
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovAA;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovAB;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovBA;
wire [(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN)*(MARKOV_CHAIN_LEN)-1:0] markovBB;

// packing
PACK_ARRAY(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN,
            MARKOV_CHAIN_LEN,
            MarkovChains[MARKOV_CHAIN_LEN-1:0],
            markovAA)

PACK_ARRAY(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN,
            MARKOV_CHAIN_LEN,
            MarkovChains[2*MARKOV_CHAIN_LEN-1:MARKOV_CHAIN_LEN],
            markovAB)
            
PACK_ARRAY(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN,
            MARKOV_CHAIN_LEN,
            MarkovChains[3*MARKOV_CHAIN_LEN-1:2*MARKOV_CHAIN_LEN],
            markovBA)
            
PACK_ARRAY(SEQUENCE_LEN*(NOTE_BIT_LEN+DELAY_BIT_LEN)+SEQ_CNT_BIT_LEN,
            MARKOV_CHAIN_LEN,
            MarkovChains[4*MARKOV_CHAIN_LEN-1:3*MARKOV_CHAIN_LEN],
            markovBB)
            

//*************************************
// Module Instantiation
//*************************************

// Decomposition
MusicInputDecomposition decompA(
  inputSongA, fragAA, fragAB
);

MusicInputDecomposition decompB(
  inputSongB, fragBA, fragBB
);


// Machine Learning Markov
MachineLearningMarkov mlkAA(
  clk, reset,
  fragAA,
  markovAA,
  markovLearnAAdone
);

MachineLearningMarkov mlkAB(
  clk, reset,
  fragAB,
  markovAB,
  markovLearnABdone
);


MachineLearningMarkov mlkBA(
  clk, reset,
  fragBA,
  markovBA,
  markovLearnBAdone
);

MachineLearningMarkov mlkBA(
  clk, reset,
  fragBB,
  markovBB,
  markovLearnBBdone
);



// Markov First Merge





endmodule