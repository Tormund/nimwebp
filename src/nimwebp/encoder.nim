# when defined(android):
import nimwebp / private / [ encoder_linkage, decoder_linkage ]

    # const h = "src/webp/encode.h"
    # {.pragma: wpenc, header: h.}
    # const h = "src/webp/encode.h"
{.pragma: wpenc.}
proc webpEncoderVersion*(): cint {.wpenc, importc: "WebPGetEncoderVersion".}
proc webpEncodeRGBA*(d: ptr uint8, w, h, stride: cint, q:float, res: ptr ptr uint8): cint {.wpenc, importc: "WebPEncodeRGBA".}
proc webpEncodeLosslessRGBA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint {.wpenc, importc: "WebPEncodeLosslessRGBA".}
# else:
#     proc webpEncoderVersion*(): cint = discard
#     proc webpEncodeRGBA*(d: ptr uint8, w, h, stride: cint, q:float, res: ptr ptr uint8): cint = discard
#     proc webpEncodeLosslessRGBA*(d: ptr uint8, w, h, stride: cint, res: ptr ptr uint8): cint = discard
