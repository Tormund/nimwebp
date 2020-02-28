import macros, os
import clurp

const libwebpPath = currentSourcePath() / "/../../../libwebp" # ;)
{.passC: "-I" & libwebpPath.}


when defined(android):
    import tables
    var emited {.compileTime.} = initTable[string, int]()

    proc entry(n: NimNode): NimNode =
        # if $n in emited:
            # ra /"File already emited ".}
        if $n notin emited:
            let st = staticRead(libwebpPath / $n)
            emited[$n] = 1
            let lit = newLit(st)
            result = quote do:
                {.emit: `lit` .}

else:
    proc entry(n: NimNode): NimNode =
        let lit = newLit(libwebpPath / $n)
        result = quote do:
            {.compile: `lit`.}

macro compileC*(n: untyped): untyped =
    result = newNimNode(nnkStmtList)
    if n.kind == nnkStmtList:
        for ch in n:
            result.add(ch.entry)
    else:
        result.add(n.entry)

    # echo "C ", repr(result)
