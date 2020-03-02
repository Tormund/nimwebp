import nimwebp / private / encoder_linkage
import nimwebp / decoder
export decoder

proc webpEncoderVersion*(): cint {.importc: "WebPGetEncoderVersion".}
proc webpEncodeRGBA*(d: ptr uint8, w, h, stride: cint, q:float32, res: ptr ptr uint8): cint {.importc: "WebPEncodeRGBA".}
proc webpEncodeBGRA*(d: ptr uint8, w, h, stride: cint, q:float32, res: ptr ptr uint8): cint {.importc: "WebPEncodeBGRA".}
proc webpEncodeRGB*(d: ptr uint8, w, h, stride: cint, q:float32, res: ptr ptr uint8): cint {.importc: "WebPEncodeRGB".}
proc webpEncodeBGR*(d: ptr uint8, w, h, stride: cint, q:float32, res: ptr ptr uint8): cint {.importc: "WebPEncodeBGR".}

proc webpEncodeLosslessRGBA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.importc: "WebPEncodeLosslessRGBA".}
proc webpEncodeLosslessBGRA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.importc: "WebPEncodeLosslessBGRA".}
proc webpEncodeLosslessRGB*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.importc: "WebPEncodeLosslessRGB".}
proc webpEncodeLosslessBGR*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.importc: "WebPEncodeLosslessBGR".}


type WebPImageHint* = enum
    WEBP_HINT_DEFAULT = 0.cint
    WEBP_HINT_PICTURE
    WEBP_HINT_PHOTO
    WEBP_HINT_GRAPH
    WEBP_HINT_LAST

const
    WebPEncCSP_WEBP_YUV420* = 0.cint
    WebPEncCSP_WEBP_YUV420A* = 4.cint
    WebPEncCSP_WEBP_CSP_UV_MASK* = 3.cint
    WebPEncCSP_WEBP_CSP_ALPHA_BIT* = 4.cint

type WebPEncodingError* = enum
    VP8_ENC_OK = 0.cint
    VP8_ENC_ERROR_OUT_OF_MEMORY
    VP8_ENC_ERROR_BITSTREAM_OUT_OF_MEMORY
    VP8_ENC_ERROR_NULL_PARAMETER
    VP8_ENC_ERROR_INVALID_CONFIGURATION
    VP8_ENC_ERROR_BAD_DIMENSION
    VP8_ENC_ERROR_PARTITION0_OVERFLOW
    VP8_ENC_ERROR_PARTITION_OVERFLOW
    VP8_ENC_ERROR_BAD_WRITE
    VP8_ENC_ERROR_FILE_TOO_BIG
    VP8_ENC_ERROR_USER_ABORT
    VP8_ENC_ERROR_LAST

type WebPPreset* = enum
    WEBP_PRESET_DEFAULT = 0.cint
    WEBP_PRESET_PICTURE
    WEBP_PRESET_PHOTO
    WEBP_PRESET_DRAWING
    WEBP_PRESET_ICON
    WEBP_PRESET_TEXT

type WebPConfig* {.importc.} = object
    lossless*: cint
    quality*: float32
    meth*{.importc:"method".}: cint
    image_hint*: WebPImageHint
    target_size*: cint
    target_PSNR*: cint
    segments*: cint
    sns_strength*: cint
    filter_strength*: cint
    filter_sharpness*: cint
    filter_type*: cint
    autofilter*: cint
    alpha_compression*: cint
    alpha_filtering*: cint
    alpha_quality*: cint
    pass*: cint
    qmin*: cint
    qmax*: cint
    show_compressed*: cint
    preprocessing*: cint
    partitions*: cint
    partition_limit*: cint
    emulate_jpeg_size*: cint
    thread_level*: cint
    low_memory*: cint
    near_lossless*: cint
    exact*: cint
    use_delta_palette*: cint
    use_sharp_yuv*: cint
    pad: array[2, uint32]

type WebPAuxStats* {.importc.} = object
    coded_size*: cint
    PSNR*: array[5, float32]
    block_count*: array[3, cint]
    header_bytes*: array[2, cint]
    residual_bytes*: array[3, array[4, cint]]
    segment_size*: array[4, cint]
    segment_quant*: array[4, cint]
    segment_level*: array[4, cint]

    alpha_data_size*: cint
    layer_data_size*: cint
    lossless_features*: uint32
    histogram_bits*: cint
    transform_bits*: cint
    cache_bits*: cint
    palette_size*: cint
    lossless_size*: cint
    lossless_hdr_size*: cint
    lossless_data_size*: cint

    pad: array[2, uint32]

type WebPMemoryWriter* {.importc.} = object
    mem*: ptr uint8
    size*: cint
    max_size*: cint
    pad: array[1, uint32]

type WebPPicture* {.importc.} = object

type WebPWriterFunction* = proc(data: ptr uint8, size: cint, pic: ptr WebPPicture): cint
type WebPProgressHook* = proc(percent: cint, picture: ptr WebPPicture): cint

proc webpConfigInit*(conf: ptr WebPConfig): cint {.importc:"WebPConfigInit".}
proc webpConfigPreset*(conf: ptr WebPConfig, preset: WebPPreset, quality: float32): cint {.importc:"WebPConfigPreset".}
proc webpConfigLosslessPreset*(conf: ptr WebPConfig, lvl: cint): cint {.importc: "WebPConfigLosslessPreset".}
proc webpValidateConfig*(conf: ptr WebPConfig): cint {.importc: "WebPValidateConfig".}

proc webpMemoryWriterInit*(writer: ptr WebPMemoryWriter) {.importc:"WebPMemoryWriter".}
proc webpMemoryWriterClear*(writer: ptr WebPMemoryWriter) {.importc:"WebPMemoryWriterClear".}
proc webpMemoryWrite*(data: ptr uint8, size: cint, pic: ptr WebPPicture) {.importc:"WebPMemoryWrite".}
