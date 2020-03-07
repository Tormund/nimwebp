import nimwebp / encoder
import times, streams, os
import nimPNG

echo "webp decoder ", webpDecoderVersion()
echo "webp encoder ", webpEncoderVersion()

const outDir = "test1_out"
if not dirExists(outDir):
    createDir(outDir)

proc convertToWebp(png, webp: string, lossless: bool, q: float) =
    var png = loadPNG32(png)
    assert(not png.isnil, "image not loaded")

    var pngBuff = cast[ptr uint8](addr png.data[0])
    var ct = epochTime()
    var outWep: ptr uint8
    var encres:cint
    if lossless:
        encres = webpEncodeLosslessRGBA(pngBuff, png.width.cint, png.height.cint, (png.width.cint) * 4, addr outWep)
    else:
        encres = webpEncodeRGBA(pngBuff, png.width.cint, png.height.cint, (png.width.cint) * 4, q.float32, addr outWep)
    echo "encoded ", epochTime() - ct, " lossless ", lossless, " q ", q
    var strm = newFileStream(webp, fmWrite)
    strm.writeData(outWep, encres)
    strm.close()
    webpFree(outWep)

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

convertToWebp("Nim-logo.png", outDir/"lossless.webp", true, 100)
convertToPNG(outDir/"lossless.webp", outDir/"Nim-logo-lossless-test.png")

convertToWebp("Nim-logo.png", outDir/"lossy100.webp", false, 100)
convertToPNG(outDir/"lossy100.webp", outDir/"Nim-logo-100-test.png")

convertToWebp("Nim-logo.png", outDir/"lossy40.webp", false, 40)
convertToPNG(outDir/"lossy40.webp", outDir/"Nim-logo-40-test.png")

convertToWebp("sample.png", outDir/"sample_lossy40.webp", false, 40)
