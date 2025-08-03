{.used.}

import std/[os, strutils]
const lib = "../../libwebp/"
const libwebpPath = currentSourcePath().replace("\\", "/").parentDir() / lib

const s = lib & "src/"
const f = "-I" & libWebpPath

{.compile(s & "dec/alpha_dec.c", f).}
{.compile(s & "dec/frame_dec.c", f).}
{.compile(s & "dec/idec_dec.c", f).}
{.compile(s & "dec/io_dec.c", f).}
{.compile(s & "dec/quant_dec.c", f).}
{.compile(s & "dec/tree_dec.c", f).}
{.compile(s & "dec/vp8_dec.c", f).}
{.compile(s & "dec/vp8l_dec.c", f).}
{.compile(s & "dec/webp_dec.c", f).}
{.compile(s & "dec/buffer_dec.c", f).}
{.compile(s & "dsp/alpha_processing.c", f).}
{.compile(s & "dsp/alpha_processing_mips_dsp_r2.c", f).}
{.compile(s & "dsp/alpha_processing_neon.c", f).}
{.compile(s & "dsp/alpha_processing_sse2.c", f).}
{.compile(s & "dsp/alpha_processing_sse41.c", f).}
{.compile(s & "dsp/cpu.c", f).}
{.compile(s & "dsp/dec.c", f).}
{.compile(s & "dsp/dec_clip_tables.c", f).}
{.compile(s & "dsp/dec_mips32.c", f).}
{.compile(s & "dsp/dec_mips_dsp_r2.c", f).}
{.compile(s & "dsp/dec_msa.c", f).}
{.compile(s & "dsp/dec_neon.c", f).}
{.compile(s & "dsp/dec_sse2.c", f).}
{.compile(s & "dsp/dec_sse41.c", f).}
{.compile(s & "dsp/filters.c", f).}
{.compile(s & "dsp/filters_mips_dsp_r2.c", f).}
{.compile(s & "dsp/filters_msa.c", f).}
{.compile(s & "dsp/filters_neon.c", f).}
{.compile(s & "dsp/filters_sse2.c", f).}
{.compile(s & "dsp/lossless.c", f).}
{.compile(s & "dsp/lossless_mips_dsp_r2.c", f).}
{.compile(s & "dsp/lossless_msa.c", f).}
{.compile(s & "dsp/lossless_neon.c", f).}
{.compile(s & "dsp/lossless_sse2.c", f).}
{.compile(s & "dsp/rescaler.c", f).}
{.compile(s & "dsp/rescaler_mips32.c", f).}
{.compile(s & "dsp/rescaler_mips_dsp_r2.c", f).}
{.compile(s & "dsp/rescaler_msa.c", f).}
{.compile(s & "dsp/rescaler_neon.c", f).}
{.compile(s & "dsp/rescaler_sse2.c", f).}
{.compile(s & "dsp/upsampling.c", f).}
{.compile(s & "dsp/upsampling_mips_dsp_r2.c", f).}
{.compile(s & "dsp/upsampling_msa.c", f).}
{.compile(s & "dsp/upsampling_neon.c", f).}
{.compile(s & "dsp/upsampling_sse2.c", f).}
{.compile(s & "dsp/upsampling_sse41.c", f).}
{.compile(s & "dsp/yuv.c", f).}
{.compile(s & "dsp/yuv_mips32.c", f).}
{.compile(s & "dsp/yuv_mips_dsp_r2.c", f).}
{.compile(s & "dsp/yuv_neon.c", f).}
{.compile(s & "dsp/yuv_sse2.c", f).}
{.compile(s & "dsp/yuv_sse41.c", f).}
{.compile(s & "utils/bit_reader_utils.c", f).}
{.compile(s & "utils/color_cache_utils.c", f).}
{.compile(s & "utils/filters_utils.c", f).}
{.compile(s & "utils/huffman_utils.c", f).}
{.compile(s & "utils/quant_levels_dec_utils.c", f).}
{.compile(s & "utils/random_utils.c", f).}
{.compile(s & "utils/rescaler_utils.c", f).}
{.compile(s & "utils/thread_utils.c", f).}
{.compile(s & "utils/utils.c", f).}
