import nimwebp / private / decoder_linkage

proc webpDecoderVersion*():cint {.importc:"WebPGetDecoderVersion".}
proc webpInfo*(d: ptr uint8, s: cint, w: ptr cint, h: ptr cint):cint {.importc:"WebPGetInfo".}
proc webpDecodeRGBA*(d: ptr uint8, s: cint, w: ptr cint, h: ptr cint):ptr uint8 {.importc:"WebPDecodeRGBA".}
proc webpFree*(d: pointer) {.importc:"WebPFree".}
