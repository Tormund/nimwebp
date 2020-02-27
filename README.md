# WebP encoder and decoder bindings for Nim

* Encoding

```nim
import nimwebp / [ encoder, free ]
import nimPNG
import os

echo "webp encoder version ", webpEncoderVersion()
proc convertToWebp(png, webp: string, q: float) =
    var png = loadPNG32(png)
    assert(not png.isnil, "PNG not loaded")

    var pngBuff = newSeq[uint8](png.data.len)
    copyMem(addr pngBuff[0], addr png.data[0], png.data.len)

    var encBuff: ptr uint8
    let c = 4.cint #RGBA
    var size = webpEncodeRGBA(addr pngBuff[0], png.width.cint,
        png.height.cint, png.width.cint * c, q, addr encBuff)

    var str = newString(size)
    copyMem(addr str[0], encBuff, size)
    writeFile(webp, str)

    #free buffer allocated by webp
    webpFree(encBuff)

convertToWebp("Nim-logo.png", "lossy100.webp", 100)
```

* Decoding
```nim
import nimwebp / [ decoder, free ]
import os
import nimPNG

echo "webp decoder ", webpDecoderVersion()

proc convertToPNG(webp, png: string) =
    var data = readFile(webp)
    var dataBuff = newSeq[uint8](data.len)
    copyMem(addr dataBuff[0], addr data[0], data.len)

    let c = 4
    var w, h: cint
    var decoded = webpDecodeRGBA(addr dataBuff[0], data.len.cint,
        addr w, addr h)

    var str = newString(w * h * c)
    copyMem(addr str[0], decoded, w * h * c)

    discard savePNG32(png, str, w, h)

    #free buffer allocated by webp
    webpFree(decoded)

convertToPNG("lossy100.webp", "Nim-logo-100-test.png")
```
