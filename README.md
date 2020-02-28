# WebP encoder and decoder bindings for Nim

* Encoding

```nim
import nimwebp / encoder
import nimPNG
import streams, times

echo "webp encoder version ", webpEncoderVersion()
proc convertToWebp(png, webp: string, q: float) =
    var png = loadPNG32(png)
    assert(not png.isnil, "image not loaded")

    var pngBuff = cast[ptr uint8](addr png.data[0])
    var ct = epochTime()
    var outWep: ptr uint8
    var encres = webpEncodeRGBA(pngBuff, png.width.cint, png.height.cint, (png.width.cint) * 4, q.float32, addr outWep)
    echo "encoded ", epochTime() - ct, " lossless ", lossless, " q ", q
    var strm = newFileStream(webp, fmWrite)
    strm.writeData(outWep, encres)
    strm.close()
    webpFree(outWep)

convertToWebp("Nim-logo.png", "lossy100.webp", 100)
```

* Decoding
```nim
import nimwebp / decoder
import streams, times
import nimPNG

echo "webp decoder ", webpDecoderVersion()

proc convertToPNG(webp, png: string) =
    var data = readFile(webp)
    var dataBuff = cast[ptr uint8](addr data[0])

    var ct = epochTime()
    var w, h: cint
    var decoded = webpDecodeRGBA(dataBuff, data.len.cint, addr w, addr h)
    echo "decoded ", epochTime() - ct

    var str = newString(w * h * 4)
    copyMem(addr str[0], decoded, w * h * 4)

    discard savePNG32(png, str, w, h)
    webpFree(decoded)

convertToPNG("lossy100.webp", "Nim-logo-100-test.png")
```
