;Skrommel 2009
;Vitefait 2021

#NoEnv
#Persistent,On
#SingleInstance,Force
SetWinDelay,0
SetControlDelay,0
SetBatchLines,-1
SendMode,Input
;SetKeyDelay,0

hotkeys=a,é,z,`",e,`',r,(,t,-,y,è,u,_,i,ç,o,à,p,),^,=,$,`<,q,w,s,x,d,c,f,v,g,b,h,n,j,k,`;,l,`:,m,`!,ù
Return


TOGGLEHOTKEYS:
If enabled<>On
  enabled=On
Else
  enabled=Off
TOOLTIPON("WriteThere " enabled)
Loop,Parse,hotkeys,`,
{
  Hotkey,$*%A_LoopField%,SEND,%enabled%
  Hotkey,$*%A_LoopField% Up,SEND,%enabled%
}
Hotkey,$*SC032,SEND,%enabled%
Hotkey,$*SC032 up,SEND,%enabled%
Return


SEND:
;TOOLTIPON(A_ThisHotkey)
StringTrimLeft,key,A_ThisHotkey,2
If(InStr(key, "Up") == 0)
	ControlSend,%ctrl%,{%key% down},ahk_id %win%
Else
	ControlSend,%ctrl%,{%key%},ahk_id %win%
Return


!F2::
If enabled=On
If A_PriorHotkey=!F2
If A_TimeSincePriorHotkey<999
{
  Gosub,TOGGLEHOTKEYS
  Return
}

If enabled<>On
  Gosub,TOGGLEHOTKEYS

win:=WinExist("A")
Loop
{
  parent:=DllCall("GetParent",UInt,win)
  If parent=0
    Break
  win:=parent
}

ControlGetFocus,ctrl,ahk_id %win%
winGetClass,class,ahk_id %win%
TOOLTIPON("Keyboard redirected to `n" ctrl " in `n" class)
Return


TOOLTIPON(tip,delay=3)
{
  ToolTip,%tip%
  SetTimer,TOOLTIPOFF,% delay*-1000
}


TOOLTIPOFF:
ToolTip,
Return