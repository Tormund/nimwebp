import nimwebp / private / encoder_linkage
import nimwebp / decoder
export decoder

proc webpEncoderVersion*(): cint {.importc: "WebPGetEncoderVersion".}
proc webpEncodeRGBA*(d: ptr uint8, w, h, stride: cint, q:float32, res: ptr ptr uint8): cint {.importc: "WebPEncodeRGBA".}
proc webpEncodeLosslessRGBA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.importc: "WebPEncodeLosslessRGBA".}
