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

type WebPConfig* = object
    lossless*: cint
    quality*: float32
    meth*: cint
    image_hint*: WebPImageHint
    target_size*: cint
    target_PSNR*: float32
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

type WebPAuxStats* = object
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

type WebPMemoryWriter* = object
    mem*: ptr uint8
    size*: cint
    max_size*: cint
    pad: array[1, uint32]

type
    WebPWriterFunction* = proc(data: ptr uint8, size: cint, pic: ptr WebPPicture): cint {.cdecl.}
    WebPProgressHook* = proc(percent: cint, picture: ptr WebPPicture): cint {.cdecl.}

    WebPPicture* = object
        use_argb*: cint

        colorspace*: cint #WebPEncCSP
        width*: cint
        height*: cint
        y*: ptr uint8
        u*: ptr uint8
        v*: ptr uint8
        y_stride*: cint
        uv_stride*: cint
        a*: ptr uint8
        a_stride*: cint
        pad1: array[2, uint32]

        argb*: ptr uint32
        argb_stride*: cint
        pad2: array[3, uint32]

        writer*: WebPWriterFunction
        custom_ptr*: pointer

        extra_info_type*: cint
        extra_info*: ptr uint8

        stats*: ptr WebPAuxStats
        error_code*: WebPEncodingError
        progress_hook*: ptr WebPProgressHook

        user_data*: pointer
        pad3: array[3, uint32]
        pad4, pad5: ptr uint8
        pad6: array[8, uint32]

        memory: pointer
        memory_argb: pointer
        pad7: array[2, pointer]

        # WebPConfigInitInternal

const WEBP_ENCODER_ABI_VERSION = 0x0210.cint
proc webpConfigInitInternal(conf: ptr WebPConfig, preset: WebPPreset,q: float32, abiVersion: cint): cint {.importc: "WebPConfigInitInternal".}

proc webpConfigInit*(conf: ptr WebPConfig): cint =
    result = conf.webpConfigInitInternal(WebPPreset.WEBP_PRESET_DEFAULT, 75.0, WEBP_ENCODER_ABI_VERSION)

proc webpConfigPreset*(conf: ptr WebPConfig, preset: WebPPreset, quality: float32): cint =
    conf.webpConfigInitInternal(preset, quality, WEBP_ENCODER_ABI_VERSION)

proc webpConfigLosslessPreset*(conf: ptr WebPConfig, lvl: cint): cint {.importc: "WebPConfigLosslessPreset".}
proc webpValidateConfig*(conf: ptr WebPConfig): cint {.importc: "WebPValidateConfig".}

proc webpMemoryWriterInit*(writer: ptr WebPMemoryWriter) {.importc:"WebPMemoryWriterInit".}
proc webpMemoryWriterClear*(writer: ptr WebPMemoryWriter) {.importc:"WebPMemoryWriterClear".}
proc webpMemoryWrite*(data: ptr uint8, size: cint, pic: ptr WebPPicture) {.cdecl, importc:"WebPMemoryWrite".}


proc webpPictureInitInternal(pic: ptr WebPPicture, abiVersion: cint): cint {.importc:"WebPPictureInitInternal".}
proc webpPictureInit*(picture: ptr WebPPicture): cint =
    result = picture.webpPictureInitInternal(WEBP_ENCODER_ABI_VERSION)

proc webpPictureAlloc*(picture: ptr WebPPicture): cint {.importc: "WebPPictureAlloc".}
proc webpPictureFree*(picture: ptr WebPPicture): cint {.importc: "WebPPictureFree".}
proc webpPictureCopy*(src: ptr WebPPicture, dst: ptr WebPPicture): cint {.importc: "WebPPictureCopy".}

type WebPPictureDistorsion* {.pure.} = enum
    PSNR = 0.cint
    SSIM
    LSIM

proc webpPlaneDistortion*(src: ptr uint8, src_stride: cint, reff: ptr uint8,
    ref_stride: cint, width, height: cint, x_step: cint, typ: WebPPictureDistorsion,
    distortion: ptr float32, res: ptr float32): cint {.importc: "WebPPlaneDistortion".}
proc webpPictureDistortion*(src, reff: ptr WebPPicture, typ: WebPPictureDistorsion, res: array[5, float32]): cint  {.importc: "WebPPictureDistortion".}
proc webpPictureCrop*(pic: WebPPicture, left, top, width, height: cint): cint {.importc: "WebPPictureCrop".}
proc webpPictureView*(src: ptr WebPPicture, left, top,
    width, height: cint, dst: ptr WebPPicture) : cint {.importc: "WebPPictureView".}

proc webpPictureIsView*(picture: ptr WebPPicture): cint {.importc: "WebPPictureIsView".}
proc webpPictureRescale*(pic: ptr WebPPicture, width, height: cint): cint {.importc: "WebPPictureRescale".}
proc webpPictureImportRGB*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportRGB".}
proc webpPictureImportRGBA*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportRGBA".}
proc webpPictureImportRGBX*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportRGBX".}

proc webpPictureImportBGR*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportBGR".}
proc webpPictureImportBGRA*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportBGRA".}
proc webpPictureImportBGRX*(pic: ptr WebPPicture, buff: ptr uint8, stride: cint): cint {.importc: "WebPPictureImportBGRX".}

proc webpPictureARGBToYUVA*(pic: ptr WebPPicture, colorspace: cint): cint  {.importc: "WebPPictureARGBToYUVA".}
proc webpPictureARGBToYUVADithered*(pic: ptr WebPPicture, colorspace: cint, dithering: float32): cint {.importc: "WebPPictureARGBToYUVADithered".}
proc webpPictureSharpARGBToYUVA*(pic: ptr WebPPicture): cint {.importc: "WebPPictureSharpARGBToYUVA".}
proc webpPictureYUVAToARGB*(pic: ptr WebPPicture): cint {.importc: "WebPPictureYUVAToARGB".}
proc webpCleanupTransparentArea*(pic: ptr WebPPicture): cint {.importc: "WebPCleanupTransparentArea".}
proc webpPictureHasTransparency*(pic: ptr WebPPicture): cint {.importc: " WebPPictureHasTransparency".}
proc webpBlendAlpha*(pic: ptr WebPPicture, background: uint32): cint {.importc: "WebPBlendAlpha".}
proc webpEncode*(conf: ptr WebPConfig, pic: ptr WebPPicture): cint {.importc: "WebPEncode".}
