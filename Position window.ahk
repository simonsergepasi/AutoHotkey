#Persistent
#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Move window to center
#Numpad5::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := (ScreenWidth - Width) / 2 - 40
    NewY := ((ScreenHeight - Height) / 2) - 35
    WinMove, A, , NewX, NewY
return

; Move window to bottom right
#Numpad3::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := ScreenWidth - Width - 40
    NewY := ScreenHeight - Height - 70 - 40
    WinMove, A, , NewX, NewY
return

; Move window to middle right
#Numpad6::
    ; If the window is maximized (MinMaxState = 1), restore it
    WinGet, MinMaxState, MinMax, A
    if (MinMaxState = 1) {
        ForceCenterWindow()
    }

    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := ScreenWidth - Width - 40
    NewY := (ScreenHeight - Height) / 2 - 35
    WinMove, A, , NewX, NewY
return

; Move window to top right
#Numpad9::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := ScreenWidth - Width - 40
    NewY := 0 + 40
    WinMove, A, , NewX, NewY
return

; Move window to middle top
#Numpad8::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := (ScreenWidth - Width) / 2 - 40
    NewY := 0 + 40
    WinMove, A, , NewX, NewY
return

; Move window to top left
#Numpad7::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := 0 + 40
    NewY := 0 + 40
    WinMove, A, , NewX, NewY
return

; Move window to middle left
#Numpad4::
    ; If the window is maximized (MinMaxState = 1), restore it
    WinGet, MinMaxState, MinMax, A
    if (MinMaxState = 1) {
        ForceCenterWindow()
    }

    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := 0 + 40
    NewY := (ScreenHeight - Height) / 2 - 35
    WinMove, A, , NewX, NewY
return

; Move window to bottom left
#Numpad1::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := 0 + 40
    NewY := ScreenHeight - Height - 70 - 40
    WinMove, A, , NewX, NewY
return

; Move window to bottom middle
#Numpad2::
    WinGetPos, X, Y, Width, Height, A
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79
    NewX := (ScreenWidth - Width) / 2 - 40
    NewY := ScreenHeight - Height - 70 - 40
    WinMove, A, , NewX, NewY
return

; Center and resize window
#^Numpad5::
    ForceCenterWindow()
return

ForceCenterWindow() {
    ; Restore the active window if it is minimized or maximized
    WinRestore, A

    ; Get the position and size of the active window
    WinGetPos, X, Y, Width, Height, A

    ; Get the screen width and height
    SysGet, ScreenWidth, 78
    SysGet, ScreenHeight, 79

    ; Calculate the new dimensions and position
    NewWidth := (ScreenWidth - 40 - 40) / 2
    NewHeight := ScreenHeight - 150
    NewX := (ScreenWidth - NewWidth) / 2 - 40
    NewY :=  40

    ; Move and resize the active window
    WinMove, A, , NewX, NewY, NewWidth, NewHeight
}