import macros, os

const libwebpPath = currentSourcePath() / "/../../../libwebp" # ;)
{.passC: "-I" & libwebpPath.}

macro compileC*(n: untyped): untyped =
    result = newNimNode(nnkStmtList)
    if n.kind == nnkStmtList:
        for ch in n:
            let chlit = newLit(libwebpPath / $ch)
            result.add quote do:
                {.compile: `chlit`.}
    else:
        let lit = newLit(libwebpPath / $n)
        result.add quote do:
            {.compile: `lit`.}
