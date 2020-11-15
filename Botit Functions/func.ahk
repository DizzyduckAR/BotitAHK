
; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK

global truex2 := 0
global truey2 := 0

#Include %A_ScriptDir%\Core\BackgroundScanner.ahk ; bundle the all tools to allow Scan "mode"
#Include %A_ScriptDir%\Core\controlclick.ahk ; controller to window mouse and key
#Include %A_ScriptDir%\Core\Gdip_All.ahk ; image edit tool
#Include %A_ScriptDir%\Core\Gdip_ImageSearch.ahk  ; img scan funcs
#Include %A_ScriptDir%\Core\RandomBezier.ahk ; human Mouse
#Include %A_ScriptDir%\Core\AnimatedGifControl.ahk
#include Core\Includer.ahk


Random, SleepAmount, %SleepAmountA%, %SleepAmountB% ; Random sleep for image scanner




;##### img track test
global Botit1T:= "Botit1T"
global Botit1TN:= 0
global Botit1X:= 0
global Botit1Y:= 0








FailSafe()
{
	GuiControl,,Botittext,Fail Test
	exist:=BotItScanner("Fail1",65,"area","G",0)	
	if exist
	{
		GuiControl,,Botittext,Fail detected
		sleep,5000
		exist:=BotItScanner("Fail1",65,"area","G",0)
		if exist
		{
			Sleep, %SleepAmount%
			WinGet, ClassABC ,ProcessName,%targetwindow%
			ControlSend,,{PgUp},ahk_exe%ClassABC%
			
			loop
			{
				Sleep, %SleepAmount%
				exist:=BotItScanner("Fail2",65,"area","G",1)
				if exist
				{
					break
				}
			}
			
			Loop
			{
				Sleep, %SleepAmount%
				Sleep, %SleepAmount%
				Sleep, %SleepAmount%
				Sleep, %SleepAmount%
				exist:=BotItScanner("Fail3",35,"area","G",1)
				if exist
				{
					break
				}
			}
		}
		
	}
	
	GuiControl,,Botittext,Fail Test
	exist:=BotItScanner("Fail4",65,"Single","G",0)    
	if exist
	{
	}
	
}

BotItTest()
{
	ImageSearch_BotitBGSTest(targetwindow)
	Exist:=BotItScanner("Botit1",55,"Single","G",1)
	if Exist
	{
		msgbox,"Found Botit1 inside mirror"
	}
		
	else
	{
		msgbox,"Error Botit1 Not Detected"
	}
	return
}
	

