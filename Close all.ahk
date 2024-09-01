#Persistent
#NoEnv
#SingleInstance Force

^F4::
{
    Goto, CloseAll
    return
}
#Numpad0::
{
    Goto, CloseAll
    return
}

CloseAll:
{
    ; Move cursor to center
    ; Get the screen resolution
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79

    ; Calculate the center position
    CenterX := ScreenWidth * .66
    CenterY := ScreenHeight * .66

    ; Move the mouse cursor to the center
    DllCall("SetCursorPos", "int", CenterX, "int", CenterY)


    SetTitleMatchMode, 2  ; Allows matching anywhere in the title
    WinGet, id, list
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title != "" and this_title != "Program Manager")  ; Ensure the title is not empty
        {
            WinActivate, ahk_id %this_id%
            WinClose, ahk_id %this_id%
        }
    }

    return
}

; Close all but this
+F4::
{
    MouseGetPos, , , id
    IfWinExist, ahk_id %id%
    {
        ; Get the executable name
        WinGet, ProcessName, ProcessName, ahk_id %id%
        ; Remove ".exe" if present
        If (SubStr(ProcessName, -3) = ".exe")
            StringTrimRight, ProcessName, ProcessName, 4
        WinGet, allWindows, List
        Loop, %allWindows%
        {
            this_id := allWindows%A_Index%
            WinGetTitle, this_title, ahk_id %this_id%
            If (this_title != ""  and this_id != id and this_title != "Program Manager")
            {
                ; Maximize the window before closing
                WinActivate, ahk_id %this_id%
                WinClose, ahk_id %this_id%
            }
        }
    }
    return
}
