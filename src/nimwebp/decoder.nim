import nimwebp / private / decoder_linkage

const h = "src/webp/decode.h"
{.pragma: wpdec, header: h.}

proc webpDecoderVersion*():cint {.wpdec, importc:"WebPGetDecoderVersion".}
proc webpInfo*(d: ptr uint8, s: cint, w: ptr cint, h: ptr cint):cint {.wpdec, importc:"WebPGetInfo".}
proc webpDecodeRGBA*(d: ptr uint8, s: cint, w: ptr cint, h: ptr cint):ptr uint8 {.wpdec, importc:"WebPDecodeRGBA".}
