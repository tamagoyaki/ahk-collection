;
; https://github.com/rcmdnk/windows/blob/master/AutoHotkey.ahk
;

#InstallKeybdHook
#UseHook

; Virtual desktop
^+b::Send, #^{Left}
^+f::Send, #^{Right}
^+Tab::Send, #+{Tab}
