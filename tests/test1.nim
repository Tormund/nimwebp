import nimwebp / [ decoder, encoder, free ]
import os, times
import nimPNG

echo "webp decoder ", webpDecoderVersion()
echo "webp encoder ", webpEncoderVersion()

proc convertToWebp(png, webp: string, lossless: bool, q: float) =
    var png = loadPNG32(png)
    assert(not png.isnil, "image not loaded")

    var pngBuff = newSeq[uint8](png.data.len)
    copyMem(addr pngBuff[0], addr png.data[0], png.data.len)

    var ct = epochTime()
    var outWep: ptr uint8
    var encres:cint
    if lossless:
        encres = webpEncodeLosslessRGBA(addr pngBuff[0], png.width.cint, png.height.cint, (png.width.cint) * 4, addr outWep)
    else:
        encres = webpEncodeRGBA(addr pngBuff[0], png.width.cint, png.height.cint, (png.width.cint) * 4, q, addr outWep)
    echo "encoded ", epochTime() - ct, " lossless ", lossless, " q ", q

    var str = newString(encres)
    copyMem(addr str[0], outWep, encres)
    writeFile(webp, str)
    webpFree(outWep)

proc convertToPNG(webp, png: string) =
    var data = readFile(webp)
    var dataBuff = newSeq[uint8](data.len)
    copyMem(addr dataBuff[0], addr data[0], data.len)

    var ct = epochTime()
    var w, h: cint
    var decoded = webpDecodeRGBA(addr dataBuff[0], data.len.cint, addr w, addr h)
    echo "decoded ", epochTime() - ct

    var str = newString(w * h * 4)
    copyMem(addr str[0], decoded, w * h * 4)

    discard savePNG32(png, str, w, h)
    webpFree(decoded)

convertToWebp("Nim-logo.png", "lossless.webp", true, 100)
convertToPNG("lossless.webp", "Nim-logo-lossless-test.png")

convertToWebp("Nim-logo.png", "lossy100.webp", false, 100)
convertToPNG("lossy100.webp", "Nim-logo-100-test.png")

convertToWebp("Nim-logo.png", "lossy60.webp", false, 60)
convertToPNG("lossy60.webp", "Nim-logo-60-test.png")
