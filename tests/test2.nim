import nimwebp / encoder
import times, streams, os
import nimPNG

const outDir = "test2_out"
if not dirExists(outDir):
    createDir(outDir)

proc setupWriter(pic: var WebPPicture, path: string)=
    pic.writer = proc(data: ptr uint8, size: cint, pic: ptr WebPPicture): cint {.cdecl.} =
        var stream = cast[FileStream](pic.custom_ptr)
        stream.writeData(data, size)
        result = 1
    pic.custom_ptr = cast[pointer](newFileStream(path, fmWrite))

type WebpTestConfig = tuple
    fn: string
    cfg: WebPConfig
    s: float

proc convertToWebp(png: string, configs: openarray[WebpTestConfig]) =
    var png = loadPNG32("tests" / png)
    assert(not png.isnil, "image not loaded")

    var pngBuff = cast[ptr uint8](addr png.data[0])

    var pic: WebPPicture
    if webpPictureInit(addr pic) != 1:
        raise newException(Exception, "WebPPicture is not initialized")

    pic.width = png.width.cint
    pic.height = png.height.cint
    pic.use_argb = 1

    if webpPictureImportRGBA(addr pic, pngBuff, pic.width * 4) != 1:
        raise newException(Exception, "WebPPicture is not imported")

    for c in configs:
        let fn = outDir / c.fn & ".webp"
        if fileExists(fn): continue
        var ct = epochTime()
        var config = c.cfg
        if webPValidateConfig(addr config) != 1:
            raise newException(Exception, "Invalid config " & $config)

        var img0: WebPPicture
        discard webpPictureCopy(addr pic, addr img0)
        img0.setupWriter(fn)

        if abs(c.s - 1.0) > 0.001:
            var width = (img0.width.float32 * c.s).cint
            discard webpPictureRescale(addr img0, width, 0.cint)

        discard webpEncode(addr config, addr img0)
        echo "Done: ", pic.error_code, " ", c.fn, " ", epochTime() - ct
        discard webpPictureFree(addr img0)

    discard webpPictureFree(addr pic)


var configs: seq[WebpTestConfig]

template configPresets(cont: untyped, body: untyped) =
    for p in cont:
        for q in 1..5:
            let quality = q.float32 * 20.0
            var config {.inject.}: WebpTestConfig
            config.s = 1.0
            config.fn = "_q" & $quality & "_" & $p
            discard webpConfigPreset(addr config.cfg, p, quality)
            body
            configs.add(config)

configPresets(low(WebPPreset) .. high(WebPPreset)):
    discard

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.cfg.lossless = 1
    config.fn &= "_lossless"

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.cfg.exact = 1
    config.fn &= "_scale0.25"
    config.s = 0.25

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.cfg.lossless = 1
    config.cfg.meth = 6
    config.fn &= "_lossless_meth6"

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.fn &= "_autofilter"
    config.cfg.meth = 6
    config.cfg.pass = 10
    config.cfg.autofilter = 1

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.cfg.target_size = 398_666
    config.fn &= "_target_size"

configPresets([WebPPreset.WEBP_PRESET_DRAWING]):
    config.cfg.emulate_jpeg_size = 1
    config.fn &= "_jpeg_emu"

convertToWebp("sample.png", configs)
