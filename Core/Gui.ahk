; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK

;********* Buttons ;gui's
guimain1:
critical,off
global Controlchoice
global targetwindow
global SleepAmountA
global SleepAmountB
global SleepAmountC
global SleepAmountD
global Scanchoice
global bioGate
guiiniread()
IfnotExist,Botit ini\Settings.ini
{
	testgate:=1
	gosub,SettingsMenu
	return
}

; global controller1
; IniRead,controller1ini,Botit ini/Settings.ini,Botit Settings,Controlchoice
; {

; 	controller1 := controller1ini
; }
; IfEqual controller1ini ,ERROR
; {
; 	controller1 = Auto-Mirror||PC/Emulator|HumanMouse|
; }

; global controller2
; IniRead,controller2ini,Botit ini/Settings.ini,Botit Settings,Botitrnd
; {

; 	controller2 := controller2ini

; }

; IfEqual controller2ini ,ERROR
; {
; 	controller2 = Color|GrayScale||
	
; }	



	

global TotalTime2 := 0
global timeBio := 0
global RandomActiveGate := 0
global BreakerBlock := 0
global tempvictory 
tempvictory := 0
global Vt1 := 350
global Vt2 := 1000



;Build Setting importer
IniRead,botname,Botit ini\Build.ini,Botit Build,botname
IniRead,botver,Botit ini\Build.ini,Botit Build,botver
IniRead,buildername,Botit ini\Build.ini,Botit Build,buildername
IniRead,discord,Botit ini\Build.ini,Botit Build,discord


SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode Input
;SetTitleMatchMode 2
SetDefaultMouseSpeed, 35
SetTitleMatchMode Fast
#WinActivateForce
SetControlDelay 1
SetWinDelay 1
SetKeyDelay -1
SetMouseDelay -1
;DetectHiddenWindows,On
;#SingleInstance force
;#SingleInstance ignore
#SingleInstance off
#NoTrayIcon

IfExist,Gui\favicon.png
{
	Menu, Tray, Icon, Gui\favicon.png
}

;# Gui Main
{
	Random, SleepAmount, %SleepAmountA%, %SleepAmountB%
	Gui, Color, 24292E
	Gui Add, Picture, x20 y20 w64 h64, Gui\game2.png
	Gui Font, Bold s10
	Gui Add, Text, x+20 y41 h20 cwhite , Target Window:
	Gui Font, Bold
	Gui, Add, Edit, x+20 y40 w150 h20 +0x200 vtargetwindow gsubmit_all, %targetwindow%
	targetwindow_TT := "Target Window/Window Name For botit to scan"
	Gui Add, Picture, x+15 y28 w35 h40 gGrab vGrabber, Gui\GrabBotit.png
	Grabber_TT := "Left Click on Target Window After MSG Gone"
	Gui Font, Bold s10
	Gui Add, Text, x10 y+40 cwhite h20 +0x200 , Mode:
	Gui Add, DropDownList, x+20  w190 vmenuChoice gsubmit_all2,
	INItoDDL2("menuChoice","Botit ini\Botit.ini", "Botit Modes")
	Gui Add, Text, x10 y+20 cwhite h20 +0x200 , Mode2:
	Gui Add, DropDownList, x+13  w190 Disabled vmenuChoice2 gsubmit_all2,
	menuChoice_TT := "Pick Mode for botit to run"
	Gui Font, Bold s10
	Gui, Add , Picture, x290 y100 w45 h45  vState2  gSubRoutine2, Gui\StartBotit.png
	State2_TT := "Start Botit After Window | Mode | Difficulty Picked"
	Gui, Add , Picture, x292 y100  w45 h45 E0x200 vState3   gSubRoutine2, Gui\StartBotit.png
	State3_TT := "Kill Running Script"
	GoSub, Toggle_Switch2
	
	Gui, Add , Picture, x+2 y100 w45 h45  vState0  gSubRoutine1, Gui\StopBotit.png
	State0_TT := "Pause Botit"
	Gui, Add , Picture, x340 y100  w45 h45 E0x200 vState1  gSubRoutine1, Gui\StopBotit.png
	State1_TT := "Release Paused Botit"
	GoSub, Toggle_Switch
	
	Gui Add, Picture, x390 y100  w45 h45 gRestart vResetTip +BackgroundTrans, Gui\ResetBotit.png
	ResetTip_TT := "Restart Botit"
	Gui Add, Text, x10 y+145 cwhite h20, More Options:
	;Gui Add,Button,x10 y+10 gtest1 , test
	
	Gui Add, Picture, x30 y400 w45 h45 gButtonBotitRND vBotitRNDTip, Gui\BotitProc.png
	BotitRNDTip_TT := "Allow snap with Auto import to script Running \img\random\"
	Gui Add, Text,x0 y+10 cwhite center h20 w100 , BotitRND
	Gui Add, Picture, x+20 y400 w60 h60 gButtonInstaller vInstallerTip, Gui\SetupBotit.png
	InstallerTip_TT := "Call Botit Image Installer GUI"
	Gui Add, Text, x100 y455 cwhite center h20 w100 , Image Tool
	
	Gui Add, Picture, x+30 y400 w42 h42 +BackgroundTrans gHelpMenu vHelpTip, Gui\Botit Help.png
	HelpTip_TT := "Open Help GUI with Q&A and Gifs"
	
	Gui Add, Picture, x+20 y400 w50 h50 gSettingsMenu vSettingTip +BackgroundTrans, Gui\SettingsBotit.png
	SettingTip_TT := "Open Botit Settings GUI Allow change Control|Sleeps|Scan Modes"
	Gui Add, Picture, x+20 y400 w48 h48 gDiscord vDiscordtip +BackgroundTrans, Gui\discordlogo.png
	Discordtip_TT := "Open a Discord Invite to Botit Server"
	Gui Add, Text, x232 y455 cwhite center h20  , Help
	Gui Add, Text, x+25 cwhite h20 , Settings
	Gui Add, Text, x+15 cwhite h20 , Discord
	
	Gui Add, Picture, x280 y160 w150 h210 vBoxTip +BackgroundTrans, Gui\BotitBox.png
	Gui Add, Progress, vMyProgress x1 y480 w449 cB2AF52 h20  -Smooth 
	MyProgress_TT := "Botit Scan Info Bar. Show Image|Case Scanned. Show Image Found and Timers"
	Gui Add, Text, x10 y482 w80 h23 cBlack +BackgroundTrans vBotittext , image scan
	;GuiControl,  +Redraw, Botittext
	Gui Font
	Gui Add, Text, x+15 y483 w330 h20 cBlack  vBotittext2 +BackgroundTrans, found image info
	;GuiControl,  +Redraw, Botittext2
	Gui Font, Bold s10
	Gui Add, Text, x280 y160 w150 h20  cFBEAEB center +BackgroundTrans +0x200 vBox , Info Panel:
	Gui Add, Text, cFBEAEB x280 y+5 w150 h20 center +BackgroundTrans vBotittext5, ;info1
	Gui Add, Text, cFBEAEB  y+5 w150 h20 center +BackgroundTrans vBotittext3, ;difficulty
	Gui Add, Text, cFBEAEB   y+5 w150 h20  center +BackgroundTrans vBotittext4, ;sleeping


	Gui Add, Text, cFBEAEB   y+60 w150 h20  c00474a49 center +BackgroundTrans vBotittTime, ;TimeRunning
	Gui Add, Text, cFBEAEB   y+10 w150 h20  c00474a49 center +BackgroundTrans vBotitExtra, ;Extra Data
	Gui Add, Picture, x0 y390 w450 h2  , Gui\Backgroundmanager.png ;local image

	Gui Add, Picture, x10 y200 w250 h2  , Gui\Backgroundmanager.png ;local image
	Gui Add, Picture, x10 y+80 w252 h2  , Gui\Backgroundmanager.png ;local image
	Gui Add, Picture, x10 y200 w2 h80  , Gui\Backgroundmanager.png ;local image
	Gui Add, Picture, x260 y200 w2 h83  , Gui\Backgroundmanager.png ;local image

	Gui Add, Text, x120 y210 cwhite h20 +BackgroundTrans, Developer:
	Gui Font, Bold s12
	Gui Add, Text, x85 y+10 cwhite h20 w160 center +BackgroundTrans, %buildername%
	Gui Add, Picture, x20 y207 w70 h-1 +BackgroundTrans , Gui\DeveloperIcon.png ;local image

	Gui Show, w450 h500, %botname% v%botver%
	Menu, Tray, Icon, Gui\favicon.png
	
	hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND 
	OnMessage(0x200,"WM_MOUSEMOVE")
	GetCordsPixels()
	
}

return

guiiniread()
{
	global targetwindow
	IniRead,MemberBerriesini,Botit ini/Settings.ini,Botit Settings,MemberBerries
	{
		targetwindow := MemberBerriesini
	}
	IfEqual MemberBerriesini ,ERROR
	{
		targetwindow := "Grab & left Click" ;Window name	
	}


	global SleepAmountA
	IniRead,SleepAmountAini,Botit ini/Settings.ini,Botit Settings,SleepAmountA
	{
		SleepAmountA := SleepAmountAini
	}
	IfEqual SleepAmountAini ,ERROR
	{
		SleepAmountA := 110	
	}

	global SleepAmountB
	IniRead,SleepAmountBini,Botit ini/Settings.ini,Botit Settings,SleepAmountB
	{

		SleepAmountB := SleepAmountBini
	}
	IfEqual SleepAmountBini ,ERROR
	{
		SleepAmountB := 215	
	}

	global SleepAmountC
	IniRead,SleepAmountCini,Botit ini/Settings.ini,Botit Settings,SleepAmountC
	{

		SleepAmountC := SleepAmountCini

	}
	IfEqual SleepAmountCini ,ERROR
	{
		SleepAmountC := 2750	
	}


	global SleepAmountD
	IniRead,SleepAmountDini,Botit ini/Settings.ini,Botit Settings,SleepAmountD
	{
		SleepAmountD := SleepAmountDini
	}
	IfEqual SleepAmountDini ,ERROR
	{
		SleepAmountD := 3750	
	}
	
	global Controlchoice
	IniRead,controlPickini,Botit ini/Settings.ini,Botit Settings,ControlPick
	{
		
		Controlchoice := controlPickini
		if (controlPickini="Auto-Mirror")
		{
			;msgbox,%Controlchoice%
			GuiControl,, controller1, 1
			GuiControl,, controller2, 0
			GuiControl,, controller3, 0
		}
		if (controlPickini="PC/Emulator")
		{
			;msgbox,%Controlchoice%
			GuiControl,, controller1, 0
			GuiControl,, controller2, 1
			GuiControl,, controller3, 0
		}
		if (controlPickini="HumanMouse")
		{
			;msgbox,%Controlchoice%
			GuiControl,, controller1, 0
			GuiControl,, controller2, 0
			GuiControl,, controller3, 1
		}
		
	}
	IfEqual controlPickini ,ERROR
	{
		Controlchoice = Auto-Mirror
	}

	global Scanchoice
	IniRead,ScanPickini,Botit ini/Settings.ini,Botit Settings,ScanPick
	{
		
		Scanchoice := ScanPickini

		if (ScanPickini="GrayScale")
		{
			;msgbox,%Controlchoice%
			GuiControl,, RndScan1, 1
			GuiControl,, RndScan2, 0
			
		}
		else 
		{
			;msgbox,%Controlchoice%
			GuiControl,, RndScan1, 0
			GuiControl,, RndScan2, 1
			
		}
		
	}

	IfEqual ScanPickini ,ERROR
	{
		Scanchoice = GrayScale
		
	}

	global bioGate
	IniRead,BioGate,Botit ini/Settings.ini,Botit Settings,biobreaker
	{
		
		

		if (BioGate="1")
		{
			;msgbox,%Controlchoice%
			GuiControl,, biobrk1, 1
			
			
		}
		else 
		{
			;msgbox,%Controlchoice%
			GuiControl,, biobrk1, 0
			
			
		}
		
	}

	IfEqual ScanPickini ,ERROR
	{
		Scanchoice = GrayScale
		
	}

}


controllerpick:
flowmode=% A_GuiControl
if(flowmode="controller1")
{
	GuiControl,, controller1, 1
	GuiControl,, controller2, 0
	GuiControl,, controller3, 0
}
if(flowmode="controller2")
{
	GuiControl,, controller1, 0
	GuiControl,, controller2, 1
	GuiControl,, controller3, 0
}
if(flowmode="controller3")
{
	GuiControl,, controller1, 0
	GuiControl,, controller2, 0
	GuiControl,, controller3, 1
}
;Gui, Submit, NoHide
;msgbox,%flowmode%
return

rndscanpick:
flowmode=% A_GuiControl
if(flowmode="RndScan1")
{
	GuiControl,, RndScan1, 1
	GuiControl,, RndScan2, 0

}
if(flowmode="RndScan2")
{
	GuiControl,, RndScan1, 0
	GuiControl,, RndScan2, 1

}

return

SettingsMenu:
;msgbox,%testgate%
Gui, Settings:New,
Gui, Settings:Default
Gui New,
Gui Add, Picture, x320 y10 w32 h32 gbuttonClosegui vcloseSettingsmenu, Gui\Botit Exit.png
closeSettingsmenu_TT := "Destroy Settings Menu" 
Gui Add, Picture, x150 y15 w48 h-1 vsettingslogo , Gui\SettingsBotit.png
settingslogo_TT := "LOGO Settings Menu" 
	
Gui, Color, 24292E

Gui Font, Bold s12
Gui Add, Text, x80 y+15  h30 +0x200 cwhite,Sleep Before Scan
Gui Add, Picture, x+20   w30 h-1 +BackgroundTrans, Gui\picture.png
Gui Font, Bold s10
Gui Add, Text, x45 y+15  h20 +0x200 cwhite, Random Range:
Gui, Add, Edit, x+20  w50 h20 VSleepAmountA gsubmit_all3, %SleepAmountA%
SleepAmountA_TT := "Set Random Sleep BEFORE Scan A value 1000=1 sec"
Gui, Add, Edit, x+20  w50 h20 VSleepAmountB gsubmit_all3, %SleepAmountB%
SleepAmountB_TT := "Set Random Sleep BEFORE Scan B value 1000=1 sec"

Gui Font, Bold s12
Gui Add, Text, x80 y+15  h30 +0x200 cwhite,Sleep After Click
Gui Add, Picture, x+20   w30 h-1 +BackgroundTrans, Gui\touch.png
;Gui Add, Text, x15 y155  h20 +0x200, 1 second = 1000
Gui Font, Bold s10
Gui Add, Text, x45 y+15  h20 +0x200 cwhite, Random Range:
Gui, Add, Edit, x+15  w50 h20 VSleepAmountC gsubmit_all3, %SleepAmountC%
SleepAmountC_TT := "Set Random Sleep AFTER Click C value 1000=1 sec"
Gui, Add, Edit, x+15  w50 h20 VSleepAmountD gsubmit_all3, %SleepAmountD%
SleepAmountD_TT := "Set Random Sleep AFTER Click D value 1000=1 sec"
Gui Add, Text, x40 y+15  h20 +0x200 c0098ff8d, Value in Milliseconds 1000 is 1 second
Gui Add, Picture, x0 y+10 w360 h2  , Gui\Backgroundmanager.png ;local image

Gui Font, Bold s12
Gui Add, Text, x90 y+15  h30 +0x200 cwhite, Set Click Mode
Gui Add, Picture, x+20   w30 h-1 +BackgroundTrans, Gui\touch.png
Gui Font, Bold s10
Gui, Add, Checkbox,x60 y+10 Checked gcontrollerpick vcontroller1,
Gui, Add, Checkbox,x+85 vcontroller2 gcontrollerpick,
Gui, Add, Checkbox,x+80  vcontroller3 gcontrollerpick,
Gui Add, Picture, x20   w40 h-1 +BackgroundTrans, Gui\androidEmu.png
Gui Add, Picture, x+10   w40 h-1 +BackgroundTrans, Gui\chrome (1).png
Gui Add, Picture, x+30   w40 h-1 vbsicon +BackgroundTrans, Gui\bluestacks.png
;GuiControl,  +Redraw, bsicon
Gui Add, Picture, x+10   w40 h-1 vnoxicon +BackgroundTrans, Gui\Nox_App_Player_Icon.png
;GuiControl,  +Redraw, noxicon
Gui Add, Picture, x+50   w40 h-1  +BackgroundTrans, Gui\mouse.png
Gui Add, Picture, x0 y+10 w360 h2  , Gui\Backgroundmanager.png ;local image
;Gui Add, DropDownList, x120 y+10 w120 vControlchoice gsubmit_all3, %controller1%  ;### control SDL2 with post msg VS ControlClick
;Controlchoice_TT := "Pick How to control the target Botit Mirror | Emulators | PC Games " 

Gui Font, Bold s12
Gui Add, Text,x60 y+10  h30 +0x200 cwhite, BotitRND Scan Mode
Gui Add, Picture, x+20   w30 h-1 +BackgroundTrans, Gui\BotitProc.png
Gui Font, Bold s10
Gui Add, Picture, x90 y+10   w40 h-1 +BackgroundTrans, Gui\rnd1.png
Gui, Add, Checkbox,x+10 Checked vRndScan1 grndscanpick,
Gui Add, Picture, x+30   w40 h-1 +BackgroundTrans, Gui\rnd2.png
Gui, Add, Checkbox,x+10 vRndScan2 grndscanpick,

Gui Font, Bold s12
Gui Add, Picture, x0 y+30 w360 h2  , Gui\Backgroundmanager.png ;local image
Gui Add, Text,x60 y+10  h30 +0x200 cwhite, BioBreaker Setting
Gui Add, Picture, x+20   w30 h-1 +BackgroundTrans, Gui\coffee-time.png
Gui Font, Bold s10
Gui, Add, Checkbox,x160 y+10 vbiobrk1 cwhite Checked ,Active
Gui Add, Picture, x0 y+10 w360 h2  , Gui\Backgroundmanager.png ;local image
;Gui Add, DropDownList, x120 y+10 w120 vScanchoice gsubmit_all3, %controller2%
;Scanchoice_TT := "Pick Mode to Scan With BotitRND " 
Gui Add, Picture, x150 y+15 w48 h-1 vSaveTip gButtonSave, Gui\save.png
SaveTip_TT := "Save Options" 
gui -SysMenu
guiiniread()
Gui Show, center w360,BotIt Settings
return
	
HelpMenu:
	Gui New
	Gui Add, Picture, x280 y10 w32 h32 gbuttonClosegui vclosehelp, Gui\Botit Exit.png
	closehelp_TT := "Destroy Help Menu" 
	Gui Add, Picture, x120 y15 w60 h60  vHelpSettinglog, Gui\Botit Help.png
	HelpSettinglog_TT := "Help Menu" 
	
	Gui, Color, 24292E
	Gui Font, Bold s12
	Gui Add, Text, x60 y+30  h20 +0x200 Center cwhite gInstallerHelp vhelp1, What Is Botit Installer
	help1_TT := "Help Gifs"
	Gui Add, Text, y+20  h20 +0x200 cwhite Center gBotitrndHelp vhelp2, What is Botit RND
	help2_TT := "Help Gifs"
	Gui Add, Text, y+20  h20 +0x200 cwhite Center gGrabHelp vhelp3, How to Grab Target
	help3_TT := "Help Gifs"
	Gui Add, Text,y+20  h20 +0x200 cwhite Center gZoomChecker vhelp4, How To Check Zoom Level
	help4_TT := "Help Gifs"
	Gui Add, Text,y+20  h20 +0x200 cwhite Center gControllerHelp vhelp5, What is Controller Options
	help5_TT := "Help Gifs"
	
	
	gui -SysMenu
	Gui Show, center h330 ,BotIt Settings
	return
	
	ControllerHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotitAHK/master/Info%20Images/BotitControllers.png"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h300")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	BotitrndHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotitAHK/master/Info%20Images/suoZOlhh0d.gif"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h300")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	InstallerHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotitAHK/master/Info%20Images/Installer.gif"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w400 h400")
	
	Gui Font, Bold s12
	Gui Add, Text,x10 y+20  h20 +0x200 cblack Center , 1) Left Click Target Window
	Gui Add, Text, y+20  h20 +0x200 cblack Center , 2) Wait For Screen Overlay
	Gui Add, Text, y+20  h20 +0x200 cblack Center , 3) Right click drag area you want to snap
	Gui Add, Picture, x200 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	ZoomChecker:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotitAHK/master/Info%20Images/ZoomLevel.jpg"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h400")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	GrabHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotitAHK/master/Info%20Images/BotitGrab.gif"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h400")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return