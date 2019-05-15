; http://nanabit.net/blog/2008/07/16/ahk-window-move/

; Window Move
WinMoveStep(XD,YD)
{
    WinGet,win_id,ID,A
    WinGetPos,x,y,,,ahk_id %win_id%
    Step := 24
    x := x + (XD * Step)
    y := y + (YD * Step)
    WinMove,ahk_id %win_id%,,%x%,%y%
}

^Left::WinMoveStep(-1,0)
^Right::WinMoveStep(1,0)
^Up::WinMoveStep(0,-1)
^Down::WinMoveStep(0,1)


; Window Size
WinSizeStep(XD,YD)
{
    WinGet,win_id,ID,A
    WinGetPos,,,w,h,ahk_id %win_id%
    Step := 24
    w := w + (XD * Step)
    h := h + (YD * Step)
    WinMove,ahk_id %win_id%,,,,%w%,%h%
}

+^Left::WinSizeStep(-1,0)
+^Right::WinSizeStep(1,0)
+^Up::WinSizeStep(0,-1)
+^Down::WinSizeStep(0,1)
