//Array packing and unpacking defines
`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

//Degrees of paralelism
'define DEG_INPUT                           2
'define DEG_INPUT_DECOMPOSITION             2
'define DEG_FRAG_DECOMPOSITION              2

//Global Constants
'define SONG_INPUT_LEN                      100
'define SONG_OUTPUT_LEN      SONG_INPUT_LEN*2
'define SEQUENCE_LEN                        11
'define MARKOV_CHAIN_LEN                    39 //SONG_INPUT_LEN/DEG_INPUT_DECOMPOSITION - SEQUENCE_LEN
'define GLUE_LEN                            3 // must be less than SONG_INPUT_LEN/2

//Bit lengths
'define NOTE_BIT_LEN                        8 //up to 256 notes
'define DELAY_BIT_LEN                       16 //up to 65,000 milli-seconds
'define SEQ_CNT_BIT_LEN                     8 // ROUND_UP(LOG2(SONG_INPUT_LEN))