; Sourse is http://www.autohotkey.com/forum/topic2534.html


;
; HHK's Right <> key
;
;vkffsc079::

;
; Ctrl + ESC + SHIFT
;
^+esc::

;
; keywords
;
applist=
(
bash
excel
explorer
firefox
measure
thunderbird
word
)

;
; launch application by keyword
;
applaunch(keyword)
{
    If keyword = firefox
        browser("")
    Else If keyword = thunderbird
       	Run thunderbird
    Else If keyword = bash
	Run C:\Users\matsuda\Documents\tools\cygwin\cygwin\bin\mintty.exe -i /Cygwin-Terminal.ico -
    Else If keyword = excel
        Run %A_ProgramFiles%\Microsoft Office 15\root\office15\EXCEL.EXE
    Else If keyword = explorer
        Run explorer
    Else If keyword = word
    	Run %A_ProgramFiles%\Microsoft Office 15\root\office15\WINWORD.EXE
    Else If keyword = measure
    	Run C:\cygwin64\home\EPSON-USER\sandbox\NorMea\NorMea.exe
}

browser(url)
{
    If Asc(url)
        Run %url%
    Else IfWinExist, ahk_class MozillaUIWindowClass
        WinActivate
    Else
        Run firefox
}

isprint(c)
{
    If (Chr(32) > c)
    {
        Return 0
    }
    
    If (Chr(122) < c)
    {
        Return 0
    }
    
    Return 1
}
    
;
; ListBox Dialog.
;
Gui, Add, ListBox, vChoice gListBoxClick w300 h100 hscroll vscroll
Gui, Add, Text, x6 y114 w50 h20, Search`:
Gui, Add, Edit, x66 y111 w240 h20

Gosub RefreshListBox

search =   

Loop
{
    Transform, CtrlH, Chr, 8
    Transform, CtrlN, Chr, 14
    Transform, CtrlP, Chr, 16
    
    Input, input, L1 M T2, {enter}{esc}{backspace}{up}{down}{pgup}{pgdn}
    
    If ErrorLevel = Timeout
    {
        search =
        Gui, Destroy
        Return
    }
    
    If ErrorLevel = EndKey:escape
    {
        search =
        Gui, Destroy
        Return
    }

    If ErrorLevel = EndKey:backspace
    {
        Gosub, DeleteSearchChar
        Continue
    }
    
    If ErrorLevel = EndKey:enter
    {
        Gui, Submit
        GuiControlGet, choice
        applaunch(choice)
        search =
        Gui, Destroy
        Return
    }
    
    If ErrorLevel = EndKey:up
    {
        Send, {up}
        Continue
    }
    
    If ErrorLevel = EndKey:down
    {
        Send, {down}
        Continue
    }
    
    If ErrorLevel = EndKey:pgup
    {
        Send, {pgup}
        Continue
    }
    
    If ErrorLevel = EndKey:pgdn
    {
        Send, {pgdn}
        Continue
    }
    
    If ErrorLevel != Max
    {
        Continue
    }
    
    If input = %CtrlH%
    {
        Gosub, DeleteSearchChar
        Continue
    }
    
    If input = %CtrlN%
    {
        Send, {down}
        Continue
    }
    
    If input = %CtrlP%
    {
        Send, {up}
        Continue
    }
    
    If ! isprint(input)
    {
        Send, input
        Continue
    }
    
    search = %search%%input%
    GuiControl,, Edit1, %search%
    StringLen,SearchLength,Search
    Gosub RefreshListBox
    Continue
}

Return


RefreshListBox:
    Wordlist=

    Loop, Parse, applist,`n
    {
        StringLeft, fragment,A_LoopField, %SearchLength%
        IfInString, fragment, %Search%
            Wordlist=%Wordlist%|%A_LoopField%
        Else
            Continue	
    }
    
    If wordlist =
    {
        wordlist = |
    }

    Gui, Show,
    GuiControl,, ListBox1, %wordlist%
    GuiControl, Choose, ListBox1, 1
    Return


DeleteSearchChar:
    If search =
        Return

    StringTrimRight, search, search, 1
    GuiControl,, Edit1, %search%
    GoSub, RefreshListBox

    Return
    

ListBoxClick:
    If A_GuiControlEvent = DoubleClick
        send, {enter}

    Return
