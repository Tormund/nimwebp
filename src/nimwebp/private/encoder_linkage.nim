{.used.}

import clurp, os
const lib = "../../libwebp/"
const libwebpPath = currentSourcePath().replace("\\", "/").parentDir() / lib

{.passC: "-I" & libwebpPath.}

const sources = @[
    lib & "src/dsp/cost.c",
    lib & "src/dsp/cost_mips32.c",
    lib & "src/dsp/cost_mips_dsp_r2.c",
    lib & "src/dsp/cost_neon.c",
    lib & "src/dsp/cost_sse2.c",
    lib & "src/dsp/enc.c",
    lib & "src/dsp/enc_mips32.c",
    lib & "src/dsp/enc_mips_dsp_r2.c",
    lib & "src/dsp/enc_msa.c",
    lib & "src/dsp/enc_neon.c",
    lib & "src/dsp/enc_sse2.c",
    lib & "src/dsp/enc_sse41.c",
    lib & "src/dsp/lossless_enc.c",
    lib & "src/dsp/lossless_enc_mips32.c",
    lib & "src/dsp/lossless_enc_mips_dsp_r2.c",
    lib & "src/dsp/lossless_enc_msa.c",
    lib & "src/dsp/lossless_enc_neon.c",
    lib & "src/dsp/lossless_enc_sse2.c",
    lib & "src/dsp/lossless_enc_sse41.c",
    lib & "src/dsp/ssim.c",
    lib & "src/dsp/ssim_sse2.c",
    lib & "src/enc/alpha_enc.c",
    lib & "src/enc/analysis_enc.c",
    lib & "src/enc/backward_references_cost_enc.c",
    lib & "src/enc/backward_references_enc.c",
    lib & "src/enc/config_enc.c",
    lib & "src/enc/cost_enc.c",
    lib & "src/enc/filter_enc.c",
    lib & "src/enc/frame_enc.c",
    lib & "src/enc/histogram_enc.c",
    lib & "src/enc/iterator_enc.c",
    lib & "src/enc/near_lossless_enc.c",
    lib & "src/enc/picture_enc.c",
    lib & "src/enc/picture_csp_enc.c",
    lib & "src/enc/picture_psnr_enc.c",
    lib & "src/enc/picture_rescale_enc.c",
    lib & "src/enc/picture_tools_enc.c",
    lib & "src/enc/predictor_enc.c",
    lib & "src/enc/quant_enc.c",
    lib & "src/enc/syntax_enc.c",
    lib & "src/enc/token_enc.c",
    lib & "src/enc/tree_enc.c",
    lib & "src/enc/vp8l_enc.c",
    lib & "src/enc/webp_enc.c",
    lib & "src/utils/bit_writer_utils.c",
    lib & "src/utils/huffman_encode_utils.c",
    lib & "src/utils/quant_levels_utils.c"
]

clurp(sources, includeDirs = [libwebpPath])
