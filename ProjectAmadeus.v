`include "Defines.v"

module ProjectAmadeus();

reg [DEG_INPUT-1:0][DEG_INPUT_DECOMP-1:0][SONG_INPUT_LEN/DEG_INPUT_DECOMP-1:0][SONG_DIM-1:0][BIT_LEN-1:0] InputSong;
wire [DEG_INPUT-1:0][DEG_INPUT_DECOMP-1:0][MARKOV_CHAIN_LEN-1:0][SEQ_LEN-1:0][SONG_DIM-1:0][BIT_LEN-1:0] MarkovChain1;
wire [DEG_INPUT-1:0][DEG_INPUT_DECOMP-1:0][BIT_LEN-1:0] MarkovLen1;
wire [DEG_INPUT_DECOMP-1:0][MARKOV_CHAIN_LEN*2-1:0][SEQ_LEN-1:0][BIT_LEN-1:0] MarkovChain2;
wire [DEG_INPUT_DECOMP-1:0][BIT_LEN-1:0] MarkovLen2;
wire [MARKOV_CHAIN_LEN*4-1:0][SEQ_LEN-1:0][BIT_LEN-1:0] MarkovChain3;
wire [BIT_LEN-1:0] MarkovLen3;
wire [MARKOV_CHAIN_LEN*4-1:0][SEQ_LEN-1:0][BIT_LEN-1:0] MarkovChain4;
wire [BIT_LEN-1:0] MarkovLen4;
wire [DEG_FRAG_DECOMP-1:0][BIT_LEN] GlueStart;
wire [DEG_FRAG_DECOMP-1:0][BIT_LEN] GlueEnd;
wire [DEG_FRAG_DECOMP-1:0][BIT_LEN] GlueSize;
wire [DEG_FRAG_DECOMP-1:0][SONG_OUTPUT_LEN/DEG_FRAG_DECOMP-1:0][SONG_DIM-1:0][BIT_LEN-1:0] Fragment;
wire [DEG_FRAG_DECOMP-1:0][BIT_LEN-1:0] FragmentLen;
reg [SONG_OUTPUT_LEN-1:0][SONG_DIM-1:0][BIT_LEN-1:0] OutputSong;

genvar i;
generate
    for (i=0; i<DEG_INPUT; i=i+1) begin
        genvar j;
				generate
						for (j=0; i<DEG_INPUT_DECOMP; j=j+1) begin
								MachineLearningMarkov Markov(
									InputSong[i][j], MarkovChain1, MarkovLen
								);
						end
				endgenerate
    end
endgenerate

MachineLearningMarkov Markov[DEG_INPUT_DECOMP*DEG_INPUT-1:0](
	InputSong[DEG_INPUT_DECOMP*DEG_INPUT-1:0], fragAA, fragAB
);

MarkovFirstMerge MarkovMerge1[DEG_INPUT_DECOMP-1:0](
	inputSongA, fragAA, fragAB
);

MarkovSecondMerge MarkovMerge2(
	inputSongA, fragAA, fragAB
);

MusicFragmentDecomposition FragDecomp(
	inputSongA, fragAA, fragAB
);

MusicGenerateFragment FragGen[DEG_INPUT_DECOMP-1:0](
	inputSongA, fragAA, fragAB
);

MusicMergeFragments FragMerge(
	inputSongA, fragAA, fragAB
);

endmodule