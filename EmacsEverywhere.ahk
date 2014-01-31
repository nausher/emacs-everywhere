; >>> transpose characters Emacs style <<<<
; using Ctrl+q as Ctrl+t is used for a bunch of things already 'New tab' etc
<^q::
SetTitleMatchMode, 2
IfWinActive, - Microsoft Outlook  ; Escaping this shortcut for Microsoft Outlook
 {
	Send, ^q  ; marks email as read
 } else{
    ; save the old clipboard
    ClipboardOld := ClipboardAll    
    Send, +{right}
    Send, ^x
    Send, {right}
    Send, ^v
    ; Restore the old clipboard
    Clipboard := ClipboardOld
    ClipboardOld := ""
  }
 return 

 }
 return 

;>>>>>>>>>>>>>>>>>>> Multiclipboard handling functionality <<<<<<<<<<<<<<
;>>>>>>>>>>>>>>>>>>>>>> EMACS kill ring <<<<<<<<<<<<<<<<<<<<<<<<
handleClip(action)
{
    global static AddNextNum
    global static GetNextNum
    global static HighestNum
    global static getprevnum
    global static ClipArray
    global static ClipArray1
    global static ClipArray2
    global static ClipArray3
    global static ClipArray4
    global static ClipArray5
    global static ClipArray6
    global static ClipArray7
    global static ClipArray8
    global static ClipArray9
    global static ClipArray10
    ; Increase the number of clip array objects if you want a longer kill ring
    if (action = "save")
    {
    if (AddNextNum < 10) ; increase this for a longer kill ring
    {
        AddNextNum += 1 ;
    }
    else
    {
        AddNextNum := 1 ;
    }
    
    
    if (HighestNum < 10) ; increase this for a longer kill ring
    {
        HighestNum += 1 ;
    }
    
        GetNextNum := AddNextNum ;
        ClipArray%AddNextNum% := Clipboard
        highest1 := highestnum + 1
        getprevnum := 1
    
    }
    else if ((action = "get") OR (action = "roll"))
    {
    if (GetNextNum != 0)
    {
        if (action = "roll")
        {
            Send, ^z
        }
        Clipboard := ClipArray%GetNextNum%
        if (GetNextNum > 1)
        {
            GetNextNum -= 1 ;
            getprevnum++
        }
        else
        {
            getprevnum := 1
            GetNextNum := HighestNum
        
        }
        Send, ^v
        }
        }
        else if (action = "get-reverse")
        {
            if (GetNextNum != 0)
        {
        
        Clipboard := ClipArray%getprevnum%
        if (GetNextNum > 1)
        {
            GetNextNum -= 1 ;
            getprevnum++
        }
        else
        {
            getprevnum := 1
            GetNextNum := HighestNum
        }
        Send, ^v
        }
    }
    
    
    else if (action = "rollforward")
    {
        if (GetNextNum != 0)
        {
        Send, ^z
        if (GetNextNum < HighestNum)
        {
        GetNextNum += 1 ;
        }
        else
        {
            GetNextNum := 1
        }
            Clipboard := ClipArray%GetNextNum%
            Send, ^v
        }
    }
    else if (action = "clear")
    {
        GetNextNum := 0
        AddNextNum := 0
        HighestNum := 0
        getprevnum := 0
    
        Loop, 30
        {
            ClipArray%A_Index% :=
        }
        MsgBox, ClipboardQueue Cleared!
    }
}
;===================end of main area ========

; Keyboard shortcuts follow

#0::
    handleClip("clear")
return

; over-writing Ctrl+C for copy shortcut to add kill-ring functionality
^c::
    suspend on
    Send, ^c
    suspend off
    handleClip("save")

return

; Shortcuts for pasting Windows Key + V  to paste the recent copy, pressing again will get the older one in the stack
#v::
    handleClip("get")
return

; Ctrl + Windows Key + V - Pastes the last item in the Kill-ring stack (bottom most)
^#v::
    handleClip("get-reverse")
return

; Windows Key + \ -> pastes the most recent item from the kill rings stack and repeatedly pressing this will
; cycle through all the different items in the stack
#\::
    handleClip("roll")
return

; Ctrl + Windows Key + \ -> pastes the last item from the kill rings stack and repeatedly pressing this will
; cycle through all the different items in the stack
#^\::
    handleClip("rollforward")
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>> EMACS Style Select till end of sentence <<<<<<<<<<<<<<<<<<<<
; Left Alt + / -> Selects from current cursor position till it encounters a '/' or 15 words whichever comes first
<!/::
	ClipboardOld := ClipboardAll
	Clipboard := ""
	InsertPoint := 0
	InsertPoint2 := 0
	ClipboardFirst := ""
    Length := 0
	Loop
	{
		Send, ^+{Right}
		A_Index2 := A_Index
		Send, ^c
		Sleep, 20
		Length := StrLen(Clipboard)
		InsertPoint := RegExMatch(Clipboard,"[\\\/]")
        ;MsgBox, InsertPoint %InsertPoint% ; for debugging
		If (InsertPoint = 0) 
        {
            If (A_Index2 >= 15)
            {
                break
            }
            continue
        }
        else
        {
			break
        }
	}
    ; Since we may overshoot the . or other special character by use of Ctrl + -> in Windows
    ; we have to Shift + <- back by how much we overshot
    If(InsertPoint > 0 && InsertPoint <> Length)
    {
     GoLeftBy := Length - InsertPoint
     Loop %GoLeftBy%
     {
        Send, +{Left}
     }
    }
	Clipboard := ClipboardOld
	ClipboardOld := ""
return

; Left Alt + ' -> Selects from current cursor position till it encounters a single quote ' or double " or 15 words whichever comes first
<!'::
	ClipboardOld := ClipboardAll
	Clipboard := ""
	InsertPoint := 0
	InsertPoint2 := 0
	ClipboardFirst := ""
    Length := 0
	Loop
	{
		Send, ^+{Right}
		A_Index2 := A_Index
		Send, ^c
		Sleep, 20
		Length := StrLen(Clipboard)
		InsertPoint := RegExMatch(Clipboard,"[""\']")
        ;MsgBox, InsertPoint %InsertPoint% ; for debugging
		If (InsertPoint = 0) 
        {
            If (A_Index2 >= 15)
            {
                break
            }
            continue
        }
        else
        {
			break
        }
	}
    ; Since we may overshoot the . or other special character by use of Ctrl + -> in Windows
    ; we have to Shift + <- back by how much we overshot
    If(InsertPoint > 0 && InsertPoint <> Length)
    {
     GoLeftBy := Length - InsertPoint
     Loop %GoLeftBy%
     {
        Send, +{Left}
     }
    }
	Clipboard := ClipboardOld
	ClipboardOld := ""
return

; Left Alt + . -> Selects from current cursor position till it encounters a period '.' (i.e. end of sentence) or 15 words whichever comes first
<!.::
	ClipboardOld := ClipboardAll
	Clipboard := ""
	InsertPoint := 0
	InsertPoint2 := 0
	ClipboardFirst := ""
    Length := 0
	Loop
	{
		Send, ^+{Right}
		A_Index2 := A_Index
		Send, ^c
		Sleep, 20
		Length := StrLen(Clipboard)
		InsertPoint := RegExMatch(Clipboard,"[\.]")
        ;MsgBox, InsertPoint %InsertPoint% ; for debugging
		If (InsertPoint = 0) 
        {
            If (A_Index2 >= 15)
            {
                break
            }
            continue
        }
        else
        {
			break
        }
	}
    ; Since we may overshoot the . or other special character by use of Ctrl + -> in Windows
    ; we have to Shift + <- back by how much we overshot
    If(InsertPoint > 0 && InsertPoint <> Length)
    {
     GoLeftBy := Length - InsertPoint
     Loop %GoLeftBy%
     {
        Send, +{Left}
     }
    }
	Clipboard := ClipboardOld
	ClipboardOld := ""
return

; >>>>>>>>>> Mac style cycle/switch through windows of current application 
;(i.e. Win equivalent of Macs -> Cmd+`   <<<<
; Left Alt + ` (Backtick)
<!`::    ; Next window
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
WinActivate, ahk_class %ActiveClass%
return
; Ctrl + Left Alt + ` (Backtick)
<!^`::    ; Last window
WinGetClass, ActiveClass, A
WinActivateBottom, ahk_class %ActiveClass%
return
