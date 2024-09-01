#Persistent
#NoEnv
#SingleInstance Force

; Variables to store window information
OpenedWindows := []
IsMonitoring := false

; Function to get all open windows
GetOpenedWindows() {
    global OpenedWindows
    OpenedWindows := [] ; Reset the array
    WinGet, id, list,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title != "")
        {
            OpenedWindows.Push(this_id)
        }
    }
}

; Function to check for new windows and minimize them
CheckForNewWindows() {
    endWindows := [] ; Reset the array
    WinGet, id, list,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title != "")
        {
            endWindows.Push(this_id)
        }
    }

    global OpenedWindows, IsMonitoring
    for index, id in endWindows
    {
        WinGetTitle, this_title, ahk_id %id%
        if (this_title != "Start menu" && this_title != "Task switching" && this_title != "Run" && HasVal(id, OpenedWindows) < 0) 
        {
            ;WinMinimize, ahk_id %id%

            WinGetPos, X, Y, Width, Height, ahk_id %id%

            ; Get the screen width and height
            SysGet, ScreenWidth, 78
            SysGet, ScreenHeight, 79

            ; Calculate the new dimensions and position
            NewWidth := (ScreenWidth - 40 - 40) / 2
            NewHeight := ScreenHeight - 150
            NewX := (ScreenWidth - NewWidth) / 2 - 40
            NewY :=  40

            ; Move and resize the active window
            WinMove, ahk_id %id%, , NewX, NewY, NewWidth, NewHeight


            IsMonitoring := false
            ;SetTimer, CheckForNewWindows, Off
            ;return
        }
    }
}

HasVal(needle, haystack) {
    for index, value in haystack
    {
        if (value != "" && value == needle)
        {
            return index
        }
    }
    if !(IsObject(haystack))
    {
        throw Exception("Bad haystack!", -1, haystack)
    }
    return -1
}

; Hotkey for the Windows key
~LWin::
    if (IsMonitoring) {
        return
    }
    IsMonitoring := true
    GetOpenedWindows()
    SetTimer, CheckForNewWindows, 300
    SetTimer, StopMonitoring, -20000
return

; Timer to stop monitoring after 7 seconds
StopMonitoring:
    GetOpenedWindows()
    ;ShowOpenWindows()
    IsMonitoring := false
    SetTimer, CheckForNewWindows, Off
return
