{.used.}

import std/[os, strutils]
const lib = "../../libwebp/"
const libwebpPath = currentSourcePath().replace("\\", "/").parentDir() / lib

const s = lib & "src/"
const f = "-I" & libWebpPath

{.compile(s & "dsp/cost.c", f).}
{.compile(s & "dsp/cost_mips32.c", f).}
{.compile(s & "dsp/cost_mips_dsp_r2.c", f).}
{.compile(s & "dsp/cost_neon.c", f).}
{.compile(s & "dsp/cost_sse2.c", f).}
{.compile(s & "dsp/enc.c", f).}
{.compile(s & "dsp/enc_mips32.c", f).}
{.compile(s & "dsp/enc_mips_dsp_r2.c", f).}
{.compile(s & "dsp/enc_msa.c", f).}
{.compile(s & "dsp/enc_neon.c", f).}
{.compile(s & "dsp/enc_sse2.c", f).}
{.compile(s & "dsp/enc_sse41.c", f).}
{.compile(s & "dsp/lossless_enc.c", f).}
{.compile(s & "dsp/lossless_enc_mips32.c", f).}
{.compile(s & "dsp/lossless_enc_mips_dsp_r2.c", f).}
{.compile(s & "dsp/lossless_enc_msa.c", f).}
{.compile(s & "dsp/lossless_enc_neon.c", f).}
{.compile(s & "dsp/lossless_enc_sse2.c", f).}
{.compile(s & "dsp/lossless_enc_sse41.c", f).}
{.compile(s & "dsp/ssim.c", f).}
{.compile(s & "dsp/ssim_sse2.c", f).}
{.compile(s & "enc/alpha_enc.c", f).}
{.compile(s & "enc/analysis_enc.c", f).}
{.compile(s & "enc/backward_references_cost_enc.c", f).}
{.compile(s & "enc/backward_references_enc.c", f).}
{.compile(s & "enc/config_enc.c", f).}
{.compile(s & "enc/cost_enc.c", f).}
{.compile(s & "enc/filter_enc.c", f).}
{.compile(s & "enc/frame_enc.c", f).}
{.compile(s & "enc/histogram_enc.c", f).}
{.compile(s & "enc/iterator_enc.c", f).}
{.compile(s & "enc/near_lossless_enc.c", f).}
{.compile(s & "enc/picture_enc.c", f).}
{.compile(s & "enc/picture_csp_enc.c", f).}
{.compile(s & "enc/picture_psnr_enc.c", f).}
{.compile(s & "enc/picture_rescale_enc.c", f).}
{.compile(s & "enc/picture_tools_enc.c", f).}
{.compile(s & "enc/predictor_enc.c", f).}
{.compile(s & "enc/quant_enc.c", f).}
{.compile(s & "enc/syntax_enc.c", f).}
{.compile(s & "enc/token_enc.c", f).}
{.compile(s & "enc/tree_enc.c", f).}
{.compile(s & "enc/vp8l_enc.c", f).}
{.compile(s & "enc/webp_enc.c", f).}
{.compile(s & "utils/bit_writer_utils.c", f).}
{.compile(s & "utils/huffman_encode_utils.c", f).}
{.compile(s & "utils/quant_levels_utils.c", f).}
