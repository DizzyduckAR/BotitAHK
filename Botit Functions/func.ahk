
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




buy()
{
	Random, Sleepfunc, 650,1000
	sleep,%Sleepfunc%
	GuiControl,,Botittext,Buy Chk
	
	exist:=BotItScanner("Buyimg",65,"area","G",0)  ; trigger is the StartFishing
	if exist
	{
		ControlClick, x%ActiveRandomX% y%ActiveRandomY%, %targetwindow%,,Left,1, NA
	}


	exist:=BotItScanner("Buyimg",65,"area","G",0)  ; trigger is the StartFishing
	if exist
	{
		
		Random, Sleepfunc, 400,1000
		sleep,%Sleepfunc%
		BotItScanner("bait",65,"area","G",1)
		Random, Sleepfunc, 450,1000
		sleep,%Sleepfunc%
		BotItScanner("Buyimg",65,"area","G",1)
		Random, Sleepfunc, 400,700
		sleep,%Sleepfunc%

		loop,10
		{
			GuiControl,,Botittext,Looping For plus
			IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,plus
			BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
			activex1 := BotitiniXYtmp[1]
			activey1 := BotitiniXYtmp[2]
			activex2 := BotitiniXYtmp[3]
			activey2 := BotitiniXYtmp[4]
			random, ActiveRandomX,%activex1% ,%activex2%
			random, ActiveRandomY,%activey1% ,%activey2%
			ControlClick, x%ActiveRandomX% y%ActiveRandomY%, %targetwindow%,,Left,1, NA
			Random, Sleepfunc, 250,350
			sleep,%Sleepfunc%
		}
		Random, Sleepfunc, 650,1000
		sleep,%Sleepfunc%
		BotItScanner("2ndBuy",65,"area","G",1)
		Random, Sleepfunc, 650,1000
		sleep,%Sleepfunc%
	}

}

AutoRepEnd()
{
	Random, Sleepfunc, 650,1000
	sleep,%Sleepfunc%
	GuiControl,,Botittext,Auto End

	exist:=BotItScanner("StartFishing",65,"area","G",1)  ; trigger is the StartFishing
	if exist
	{
		;msgbox, Found StartFishing
		loop
			{
				exist:=BotItScanner("active",25,"area","G",0) ;look for active
				if exist
				{
					GuiControl,,Botittext,Start Detected
					sleep,650
					;sleep,%Sleepfunc%
					;exist:=BotItScanner("StartFishing",65,"area","G",0) ;if StartFishing is not on the screen
					;if not exist
					;{
					;msgbox, StartFishing is gone starting loop for trigger
					loop,4000
					{
						GuiControl,,Botittext,Looping For Trigger
						exist:=BotItScanner("AutoFind",5,"area","G",0)	;look for trigger
						if not exist
						{
							GuiControl,,Botittext,Looping For Active
							IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,active
							BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
							activex1 := BotitiniXYtmp[1]
							activey1 := BotitiniXYtmp[2]
							activex2 := BotitiniXYtmp[3]
							activey2 := BotitiniXYtmp[4]
							random, ActiveRandomX,%activex1% ,%activex2%
							random, ActiveRandomY,%activey1% ,%activey2%
							ControlClick, x%ActiveRandomX% y%ActiveRandomY%, %targetwindow%,,Left,1, NA
							sleep,1250
							BotItScanner("Backimg",25,"area","G",1)
							sleep,1250
							return
							
			
							
						}

					
						sleep,30
					}
					;sleep,150
					IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,active
					BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
					activex1 := BotitiniXYtmp[1]
					activey1 := BotitiniXYtmp[2]
					activex2 := BotitiniXYtmp[3]
					activey2 := BotitiniXYtmp[4]
					random, ActiveRandomX,%activex1% ,%activex2%
					random, ActiveRandomY,%activey1% ,%activey2%
					ControlClick, x%ActiveRandomX% y%ActiveRandomY%, %targetwindow%,,Left,1, NA
					
					
					BotItScanner("active",65,"area","G",1)
					sleep,450
					BotItScanner("Backimg",25,"area","G",1)
					sleep,1250

				}

				sleep,50
			}
	}
}





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
	

