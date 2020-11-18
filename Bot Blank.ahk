; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK


;Var := "1"
;1()
;{
;	msgbox,hello
;}


;%Var%()
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%\Botit Functions\func.ahk
#Include %A_ScriptDir%\Core\INIReader.ahk  ; Get Image Cords from INI

;Settings detect



#Include %A_ScriptDir%\Core\GUI.ahk

;GUI Call ************* 

;Gui Call *************

return



Start:
;update the gui data
Gui, Submit, NoHide




;Read Images INI
GetCords()

if (targetwindow = "Grab & left Click" )
{
		MsgBox,262144, No selection, No WIndow Targeted! Grab Mirror
		return
}


;read user mode pick
menuChoicetmp := menuChoice
OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes","|")
global BotitINItoDDL:=StrSplit(OutputVar,"|")


;Loop Picked Mode
Loop % BotitINItoDDL.MaxIndex()
{
	if (menuChoicetmp = BotitINItoDDL[A_Index])
	{
		looper := % BotitINItoDDL[A_Index]
		IniRead,INItoDDLsplit,Botit ini\Botit.ini,Botit Modes,%looper%
		BotitiniXYtmp2:=StrSplit(INItoDDLsplit,"|")
		
		Loop % BotitiniXYtmp2.MaxIndex()
		{
			looper1 := % BotitiniXYtmp2[A_Index]
			
			IniRead,INItoDDLsplit,Botit ini\Botit.ini,Botit Calls,%looper1%
			BotitiniXYtmp3:=StrSplit(INItoDDLsplit,"|")
			GuiControl,1:,Botittext,%looper1% ;show "Botit1" on the gui Bar
			Sleep, %SleepAmount% ; sleep before scan
			critical,On
			if (BotitiniXYtmp3[1]="Image")
			{
				BotItScanner(looper1,BotitiniXYtmp3[2],BotitiniXYtmp3[3],BotitiniXYtmp3[4],BotitiniXYtmp3[5])

			}

			if (BotitiniXYtmp3[1]="Func")
			{
				Var := looper1
				%Var%()

			}
			
			
			critical,Off
			GuiControl,, MyProgress, +10
			
		}
		;msgbox,%RandomActiveGate%
		;Botit RND Call every 10 secs above the running 
		if (RandomActiveGate = 0) ; BotitRND Ticker
		{
			;msgbox,activate %RandomActiveGate%
			RandomActiveGate := 1
			GuiControl,,Botittext,RND
			SetTimer, RandomTicker, 10000
			GuiControl,, MyProgress, +10
			GuiControl,,Botittext,
		}

		;BotitRandomlist()
		
	}
	GuiControl,,Botittext,LoopFin
	Sleep, %SleepAmount%
	;TiBIO := QPX( false )
	;timetemp := Round((BioTicker - A_tickcount)/1000)
	;timeBio := (timeBio+timetemp)
	GuiControl,, MyProgress,
	
	;FailSafe()
	;exmple- if you wanna call function on a mode

	;Functions area
	;if (menuChoicetmp = "tower") ; mode need to fit the mode name you set in Botit.ini  Function on Func.ahk
    ;{
        
    ;    YourFunctionName()
    ;}

	;exmple- if you wanna call function on ALL Modes

	;YourFunctionName()


}
;Test Window Capture
if ( menuChoicetmp = "TestBGS")
{	
	Random, SleepAmount, %SleepAmountA%, %SleepAmountB%
	MsgBox, Start TestBGS
	GuiControl,1:,SleepAmountA,%SleepAmountA%
	GuiControl,1:,SleepAmountB,%SleepAmountB%
	GuiControl,1:,Botittext,BotitTest
	BotItTest()
	Sleep, %SleepAmount%
	GuiControl, 1:, MyProgress,%MyProgress%
	
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	Gdip_Shutdown(pToken)
	sleep, 5000
	
}
return


;Label BotitRND list func runner
RandomTicker:
GuiControl,,Botittext,RND
BotitRandomlist()
return	

;Function BotitRND
BotitRandomlist()
{
	
	GuiControl,,Botittext,BotitRND Scan
	;msgbox,rnd
	if (Scanchoice = "Color")
	{
		critical,On
		BotItFolderScanner(65,"C")
		critical,Off
		GuiControl,,Botittext,
		Return
		
	}
	
	if (Scanchoice = "GrayScale")
		
	{
		critical,On
		BotItFolderScanner(65,"G")
		critical,Off
		GuiControl,,Botittext,
		Return
	}
	GuiControl,,Botittext,
}



;Function Human Bio Break
BioBreaker()
{
	;msgbox,%TotalTime2%
	
	GuiControl,,Botittext5,Break Counter %BreakerBlock% / 9
	 ;*[Calibria]
	if (BreakerBlock > 9)
	{
		msgbox,,Warning,BotIt Runs Over 6 Hours! Account Risk
	}
	random,breakerstart,-2280,-2700
	
	if (timeBio < breakerstart)
	{
		BreakerBlock := BreakerBlock+1
		TiBIO := QPX( false )
		GuiControl,1:,Botittext,Building Sleep
		GuiControl,1:,Botittext,Bio break Sleep
		Random,RandomBioSleeper,7,12
	;Random,RandomBioSleeper,1,2
		RandomBioSleeper2 := ((RandomBioSleeper*60)*1000)
	;msgbox, %RandomBioSleeper% %RandomBioSleeper2%
		sleep,%RandomBioSleeper2%
		GuiControl,1:,Botittext,
		timeBio := 0
	;msgbox, %timeBio% %breakerstart%
	}
	return
}
 


;Label Skip
Skip:
gosub,buttonClosegui ; call main GUI
gosub,guimain1 ; call main GUI
return

;pause button labels
IsPaused := false
ButtonPause:
if IsPaused
{
		Pause off
		IsPaused := false
		GuiControl,, PauseButton, Pause
}
	else
		SetTimer, Pause, 10
	return

Pause:
	SetTimer, Pause, off
	IsPaused := true
	GuiControl,, PauseButton, Unpause
	Pause, on
	return
	
ButtonSave:
Gui, Submit, NoHide
;msgbox,%testgate%
;click read
if (controller1=1)
{
	IniWrite,Auto-Mirror,Botit ini/Settings.ini,Botit Settings,ControlPick
}
if (controller2=1)
{
	IniWrite,PC/Emulator,Botit ini/Settings.ini,Botit Settings,ControlPick
}
if (controller3=1)
{
	IniWrite,HumanMouse,Botit ini/Settings.ini,Botit Settings,ControlPick
}

;rnd scan read
if (RndScan1=1)
{
	IniWrite,GrayScale,Botit ini/Settings.ini,Botit Settings,ScanPick
}
Else
{
	IniWrite,Color,Botit ini/Settings.ini,Botit Settings,ScanPick
}

;biobreaker
if (biobrk1=1)
{
	IniWrite,1,Botit ini/Settings.ini,Botit Settings,biobreaker
}
Else
{
	IniWrite,0,Botit ini/Settings.ini,Botit Settings,biobreaker
}
	
IniWrite,%SleepAmountA%,Botit ini\Settings.ini,Botit Settings,SleepAmountA
IniWrite,%SleepAmountB%,Botit ini\Settings.ini,Botit Settings,SleepAmountB
IniWrite,%SleepAmountC%,Botit ini\Settings.ini,Botit Settings,SleepAmountC
IniWrite,%SleepAmountD%,Botit ini\Settings.ini,Botit Settings,SleepAmountD


msgbox,,,Save Fin,1
if (testgate=1)
{
	reload
}
guiiniread()

gui,Destroy
return
	
ButtonRestart:
Reload
return
	
Close:
Gui 2: Destroy
return

Titletracker:
MouseGetPos,,,guideUnderCursor
WinGetTitle, Title, ahk_id %guideUnderCursor%
targetwindow:=Title
;MouseGetPos, MouseX, MouseY
;PixelGetColor, color, %MouseX%, %MouseY%
ToolTip, %Title% left mouse Click on Title
return

Grab:
settimer,Titletracker,100
sleep,150
KeyWait, LButton, D
{
	MouseGetPos,,,guideUnderCursor
	WinGetTitle, Title, ahk_id %guideUnderCursor%
	targetwindow := Title
	settimer,Titletracker,off
	ToolTip,
	GuiControl,,targetwindow, %Title%
	IniWrite,%targetwindow%,Botit ini\Settings.ini,Botit Settings,MemberBerries
	;global targetwindow := %Title%
	Gosub,submit_all
	
}
return

Grab2:
sleep,1000
;msgbox,,Click on target,Left Click on Target Window,2
KeyWait, LButton, D
{
	MouseGetPos,,,guideUnderCursor
	WinGetTitle, Title, ahk_id %guideUnderCursor%
	targetwindow:=Title
	GuiControl,,targetwindow, %Title%
	IniWrite,%targetwindow%,Botit ini\Settings.ini,Botit Settings,MemberBerries
	;global targetwindow := %Title%
	Gosub,submit_all
	
}
Return
	
	
ButtonInstaller:
;Run,  ImageTool.ahk
Run, ImageTool.exe
return
	
	
submit_all:
Gui, Submit, Nohide
return
	
F8::ExitApp
	
;*/*/*/*/*/*/*/*/*/*/*/
; Do Not Touch Core item

;Close gui label
buttonClosegui:
gui Destroy
return

;Restart label
Restart:
Reload
return

;app exit label	
GuiEscape:
GuiClose:
ExitApp

;our Epic prograss bar	
MyProgress:
MyProgress ++


Choose:
Gui,Submit, Nohide
return
	

;Call Botit rnd image tool
ButtonBotitRND:
;Run,  Core\BotItRND.ahk
Run,  Core\BotItRND.exe
return


;Button Toggle systems
Toggle_Switch2:
If Toggle2=2
	{
	

		GuiControl, Hide, State2
		GuiControl, Show, State3
		Toggle2=3
	}
	Else {
		GuiControl, Hide, State3
		GuiControl, Show, State2
		Toggle2=2
		
	}
	Return


Toggle_Switch:
If Toggle=0

	{
		GuiControl, Hide, State0
		GuiControl, Show, State1
		Toggle=1
	}
Else {
		GuiControl, Hide, State1
		GuiControl, Show, State0
		Toggle=0
	}
Return
	
	
SubRoutine1:
GoSub,Toggle_Switch
GoSub,ButtonPause
Return
	
SubRoutine2:
GoSub,Toggle_Switch2
Loop
{
	If Toggle2=2
	{		
		break
		return
	}
	GoSub,Start	
}
Return

	
	
	
	
Discord:
run,%discord%
return
	
Check:
Gui, Submit, Nohide
If (A_GuiControl="SingleM")
	GuiControl,,CoopM,0
Else
	GuiControl,,SingleM,0
return
	
menuItm2:
Gui, Submit, NoHide
return
	
submit_all3:
Gui, Submit, NoHide
return
	
submit_all2:
Gui, Submit, NoHide
return
	
WM_MOUSEMOVE(wParam,lParam) 
{ 
	static CurrControl, PrevControl, _TT  ; _TT is kept blank for use by the ToolTip command below.
	CurrControl := A_GuiControl
	If (CurrControl <> PrevControl and not InStr(CurrControl, " "))
	{
		ToolTip  ; Turn off any previous tooltip.
		SetTimer, DisplayToolTip, 1000
		PrevControl := CurrControl
	}
	return
		
	DisplayToolTip:
	SetTimer, DisplayToolTip, Off
	ToolTip % %CurrControl%_TT  ; The leading percent sign tell it to use an expression.
	SetTimer, RemoveToolTip, 3000
	return
		
	RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
	return
		
	Global hCurs 
	MouseGetPos,,,,ctrl 
  ;Only change over certain controls, use Windows Spy to find them. 
	IfInString ctrl, Static1
	DllCall("SetCursor","UInt",hCurs) 
	Return 
}
	
Return
	
	
	
	
	
	
	
	
	
	
	
