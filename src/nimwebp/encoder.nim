import nimwebp / private / [ encoder_linkage, decoder_linkage ]

const h = "src/webp/encode.h"
{.pragma: wpenc, header: h.}
proc webpEncoderVersion*(): cint {.wpenc, importc: "WebPGetEncoderVersion".}
proc webpEncodeRGBA*(d: ptr uint8, w, h, stride: cint, q:float, res: ptr ptr uint8): cint {.wpenc, importc: "WebPEncodeRGBA".}
proc webpEncodeLosslessRGBA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.wpenc, importc: "WebPEncodeLosslessRGBA".}
