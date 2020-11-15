; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK

;********* Buttons ;gui's
guimain1:
critical,off
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

global controller1
IniRead,controller1ini,Botit ini/Settings.ini,Botit Settings,Controlchoice
{

	controller1 := controller1ini
}
IfEqual controller1ini ,ERROR
{
	controller1 = Auto-Mirror||PC/Emulator|HumanMouse|
}

global controller2
IniRead,controller2ini,Botit ini/Settings.ini,Botit Settings,Botitrnd
{

	controller2 := controller2ini

}

IfEqual controller2ini ,ERROR
{
	controller2 = Color|GrayScale||
	
}	

global Controlchoice
IniRead,controlPickini,Botit ini/Settings.ini,Botit Settings,ControlPick
{
	
	Controlchoice := controlPickini
}
IfEqual controlPickini ,ERROR
{
	 Controlchoice = Auto-Mirror
}

global Scanchoice
IniRead,ScanPickini,Botit ini/Settings.ini,Botit Settings,ScanPick
{
	
	 Scanchoice := ScanPickini
	
}

IfEqual ScanPickini ,ERROR
{
	Scanchoice = GrayScale
	
}	

global TotalTime2 := 0
global timeBio := 0
global RandomActiveGate := 0
global BreakerBlock := 0
global tempvictory 
tempvictory := 0
global Vt1 := 350
global Vt2 := 1000



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
	Gui, Add, Edit, x+20 y40 w108 h20 +0x200 vtargetwindow gsubmit_all, %targetwindow%
	targetwindow_TT := "Target Window/Window Name For botit to scan"
	Gui Add, Picture, x+15 y28 w35 h40 gGrab vGrabber, Gui\GrabBotit.png
	Grabber_TT := "Left Click on Target Window After MSG Gone"
	Gui Font, Bold s10
	Gui Add, Text, x10 y+40 cwhite h20 +0x200 , Mode:
	Gui Add, DropDownList, x+20   vmenuChoice gsubmit_all2,
	INItoDDL2("menuChoice","Botit ini\Botit.ini", "Botit Modes")
	
	menuChoice_TT := "Pick Mode for botit to run"
	Gui Font, Bold s10
	Gui, Add , Picture, x250 y100 w45 h45  vState2  gSubRoutine2, Gui\StartBotit.png
	State2_TT := "Start Botit After Window | Mode | Difficulty Picked"
	Gui, Add , Picture, x252 y100  w45 h45 E0x200 vState3   gSubRoutine2, Gui\StartBotit.png
	State3_TT := "Kill Running Script"
	GoSub, Toggle_Switch2
	
	Gui, Add , Picture, x+2 y100 w45 h45  vState0  gSubRoutine1, Gui\StopBotit.png
	State0_TT := "Pause Botit"
	Gui, Add , Picture, x300 y100  w45 h45 E0x200 vState1  gSubRoutine1, Gui\StopBotit.png
	State1_TT := "Release Paused Botit"
	GoSub, Toggle_Switch
	
	Gui Add, Picture, x+5  w45 h45 gRestart vResetTip, Gui\ResetBotit.png
	ResetTip_TT := "Restart Botit"
	Gui Add, Text, x10 y+45 cwhite h20, More Options:
	;Gui Add,Button,x10 y+10 gtest1 , test
	
	Gui Add, Picture, x20 y300 w45 h45 gButtonBotitRND vBotitRNDTip, Gui\BotitProc.png
	BotitRNDTip_TT := "Allow snap with Auto import to script Running \img\random\"
	Gui Add, Picture, x+50 y300 w60 h60 gButtonInstaller vInstallerTip, Gui\SetupBotit.png
	InstallerTip_TT := "Call Botit Image Installer GUI"
	Gui Add, Picture, x+50 y322 w42 h42 gHelpMenu vHelpTip, Gui\Botit Help.png
	HelpTip_TT := "Open Help GUI with Q&A and Gifs"
	Gui Add, Picture, x+10 y320 w50 h50 gSettingsMenu vSettingTip, Gui\SettingsBotit.png
	SettingTip_TT := "Open Botit Settings GUI Allow change Control|Sleeps|Scan Modes"
	Gui Add, Picture, x+10 y320 w48 h48 gDiscord vDiscordtip, Gui\discordlogo.png
	Discordtip_TT := "Open a Discord Invite to Botit Server"
	Gui Add, Text, x10 y350 cwhite h20 , BotitRND
	Gui Add, Text, x+30 cwhite h20 , IMG Installer
	
	Gui Add, Picture, x240 y170 w150 h130 vBoxTip , Gui\BotitBox.png
	Gui Add, Progress, vMyProgress x1 y380 w399 cB2AF52 h20  -Smooth 
	MyProgress_TT := "Botit Scan Info Bar. Show Image|Case Scanned. Show Image Found and Timers"
	Gui Add, Text, x10 y382 w80 h20 cBlack +BackgroundTrans vBotittext , ;image/routine
	Gui Font
	Gui Add, Text, x+10 y383 w300 h20 cBlack  vBotittext2 +BackgroundTrans, ;found image
	Gui Font, Bold s10
	Gui Add, Text, x278 y170 h20  cFBEAEB +BackgroundTrans +0x200 vBox , Info Panel:
	Gui Add, Text, cFBEAEB x245 y+5 w140 h20 center +BackgroundTrans vBotittext5,
	Gui Add, Text, cFBEAEB x255 y+5 w120 h20 center +BackgroundTrans vBotittext3, ;difficulty
	Gui Add, Text, cFBEAEB   y+5 w120 h20  center +BackgroundTrans vBotittext4, ;sleeping
	Gui Show, w400 h400, Botit Blank v1.0.0
	Menu, Tray, Icon, Gui\favicon.png
	
	hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND 
	OnMessage(0x200,"WM_MOUSEMOVE")
	GetCordsPixels()
	
}	
return



	SettingsMenu:
	Gui, Settings:New,
	Gui, Settings:Default
	Gui New,
	Gui Add, Picture, x320 y10 w32 h32 gbuttonClosegui vcloseSettingsmenu, Gui\Botit Exit.png
	closeSettingsmenu_TT := "Destroy Settings Menu" 
	Gui Add, Picture, x150 y15 w60 h60 vsettingslogo , Gui\SettingsBotit.png
	settingslogo_TT := "LOGO Settings Menu" 
	
	Gui, Color, 24292E
	Gui Font, Bold s10
	Gui Add, Text, x15 y+20  h20 +0x200 cwhite, Random Sleep Before Click:
	Gui, Add, Edit, x+20  w50 h20 VSleepAmountA gsubmit_all3, %SleepAmountA%
	SleepAmountA_TT := "Set Random Sleep BEFORE Scan A value 1000=1 sec"
	Gui, Add, Edit, x+20  w50 h20 VSleepAmountB gsubmit_all3, %SleepAmountB%
	SleepAmountB_TT := "Set Random Sleep BEFORE Scan B value 1000=1 sec"
;Gui Add, Text, x15 y155  h20 +0x200, 1 second = 1000
	Gui Font, Bold s10
	Gui Add, Text, x15 y+10  h20 +0x200 cwhite, Random Sleep After click:
	Gui, Add, Edit, x+35  w50 h20 VSleepAmountC gsubmit_all3, %SleepAmountC%
	SleepAmountC_TT := "Set Random Sleep AFTER Click C value 1000=1 sec"
	Gui, Add, Edit, x+20  w50 h20 VSleepAmountD gsubmit_all3, %SleepAmountD%
	SleepAmountD_TT := "Set Random Sleep AFTER Click D value 1000=1 sec"
	Gui Add, Text, x110 y+15  h20 +0x200 cwhite, Set Controller Mode
	Gui Add, DropDownList, x120 y+10 w120 vControlchoice gsubmit_all3, %controller1%  ;### control SDL2 with post msg VS ControlClick
	Controlchoice_TT := "Pick How to control the target Botit Mirror | Emulators | PC Games " 
	Gui Add, Text,x100 y+10  h20 +0x200 cwhite, Set BotitRND Scan Mode
	Gui Add, DropDownList, x120 y+10 w120 vScanchoice gsubmit_all3, %controller2%
	Scanchoice_TT := "Pick Mode to Scan With BotitRND " 
	Gui Add, Picture, x140 y+15 w60 h60 vSaveTip gButtonSave, Gui\save.png
	SaveTip_TT := "Save Options" 
	gui -SysMenu
	Gui Show, center ,BotIt Settings
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
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotIt/master/Info%20Images/BotitControllers.png"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h300")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	BotitrndHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotIt/master/Info%20Images/suoZOlhh0d.gif"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h300")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	InstallerHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotIt/master/Info%20Images/Installer.gif"
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
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotIt/master/Info%20Images/ZoomLevel.jpg"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h400")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return
	
	GrabHelp:
	
	url := "https://raw.githubusercontent.com/DizzyduckAR/BotIt/master/Info%20Images/BotitGrab.gif"
	Gui, Margin, 20, 20
	Gui New, +HwndhWndGifAnim
	
	AnimatedGifControl(hWndGifAnim, url, "w600 h400")
	Gui Add, Picture, x300 y+10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png
	gui -SysMenu
	Gui Show, center ,Zoom Level
	
	return