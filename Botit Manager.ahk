; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK

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

modepicked = 0
name := "Botit Manager V0.1.1"

IfExist,Gui\favicon.png
{
	Menu, Tray, Icon, Gui\favicon.png
}

;DllCall( "AddFontResource", Str,"Gui\Bangers-Regular.ttf" ) 
;SendMessage,  0x1D,,,, ahk_id 0xFFFF ; Broadcast the change



Gui, Color, fbfbfb 
Gui Font, Bold s10
;Top Header
Gui Add, Picture, x0 y0 w800 h70 , Gui\ManagerHeader.png ;local image
Gui Add, Picture, x10 y5 w60 h-1 +BackgroundTrans, Gui\discordlogo.png ;local image
Gui Add, Picture, x+25 y8 w55 h-1 +BackgroundTrans, Gui\utube.png ;local image
Gui Add, Picture, x650 y8 w55 h-1 +BackgroundTrans, Gui\patreon.png ;local image
Gui Add, Picture, x+25 y8 w55 h-1 +BackgroundTrans, Gui\internet.png ;local image
Gui Font, Bold s26
Gui Add, Text, x0 y18 w800  c434343 center BackgroundTrans , Botit Developer Tool
;Side Menu'sss
Gui Add, Picture, x0 y70 w200 h530 , Gui\ManagerSideMenu.png ;local image
Gui Font, Bold s10
Gui Add, Picture, x55 y80 w32 h-1 +BackgroundTrans , Gui\picture.png ;local image
Gui Add, Picture, x+20 y78 w32 h-1 +BackgroundTrans , Gui\search.png ;local image
Gui Add, Picture, x0 y115 w200 h2 , Gui\Backgroundmanager.png ;local image
Gui Add, Picture, x95 y330 w32 h-1 +BackgroundTrans , Gui\file.png ;local image
Gui, Add, Text, x10 y335 w80 h20 +BackgroundTrans cWhite,Image Tool
Gui, Add, Text, x130 y335 w80 h20 +BackgroundTrans cWhite,Options
Gui Add, Picture, x0 y320 w200 h2 , Gui\Backgroundmanager.png ;local image
Gui Add, Picture, x0 y535 w200 h2 , Gui\Backgroundmanager.png ;local image

Gui Add, Picture, x20 y550 w40 h-1 +BackgroundTrans vSSMsaveicon gSaveData, Gui\diskette.png ;local image
Gui Add, Picture, x80 y550 w40 h-1 +BackgroundTrans vSSMremoveicon gDeleteData, Gui\delete.png ;local image
Gui Add, Picture, x140 y550 w40 h-1 +BackgroundTrans vSSmcropicon gCropimage, Gui\crop.png ;local image

;hide
GuiControl,Hide ,SSMsaveicon
GuiControl,Hide ,SSMremoveicon
GuiControl,Hide ,SSmcropicon

;not showing on load
Gui Add, Picture, x15 y80 w32 h-1 +BackgroundTrans  vRighthnad, Gui\decree.png ;local image
Gui Add, Picture, x150 y80 w32 h-1 +BackgroundTrans vLefthand , Gui\decreeleft.png ;local image
Gui Add, Picture, x70 y130 w32 h-1 +BackgroundTrans vnotFound, Gui\not-found.png ;local image
Gui Add, Text, x0 y+10 w180 h40 cWhite center BackgroundTrans vModeTextSide,

Gui, Add, Text, x2 y200 w75 h20 +BackgroundTrans cWhite vSSMTol,Tolerance:
Gui, Add, Edit, x+15  w30 h20 vSSMTolEdit ,55

Gui, Add, Text, x2 y230 w80 h20 +BackgroundTrans cWhite vSSMMode,ScanMode:
Gui, Add, ComboBox, x+10 y228 w90 VSSMModeCombo ,Window||Area|

Gui, Add, Text, x2 y260 w80 h20 +BackgroundTrans cWhite vSSMScanClr,ScanColor:
Gui, Add, ComboBox, x+10 y258 w100 vSSMScanClrCombo ,GrayScale||Color|


Gui, Add, Text, x2 y290 w80 h20 +BackgroundTrans cWhite vSSMClick,Clicks:
Gui, Add, ComboBox, x+10 y288 w100 vSSMClickCombo ,Click||No Click|


Gui, Add, Text, x2 y375 w45 h20 +BackgroundTrans cWhite vSSMDEMO,Demo:
Gui, Add, Edit, x50 y373 w100 h20 vSSMDEMOEdit,Image installer\Demo.png
Gui Add, Picture, x160 y368 w28 h-1 +BackgroundTrans vSSMDemoFolder, Gui\pages.png ;local image


Gui, Add, Text, x5 y468 w10 h14 +BackgroundTrans cWhite vSSMX1Text,X
Gui, Add, Edit, x25 y465 w40 h20 vSSMx1
Gui, Add, Text, x75 y468 w10 h14 +BackgroundTrans cWhite vSSMY1Text,Y
Gui, Add, Edit, x95 y465 w40 h20 vSSmy1
Gui, Add, Text, x5 y505 w17 h14 +BackgroundTrans cWhite vSSMX2Text,X2
Gui, Add, Edit, x25 y505 w40 h20 vSSMx2
Gui, Add, Text, x75 y505 w40 h14 +BackgroundTrans cWhite vSSMY2Text,Y2
Gui, Add, Edit, x95 y505 w40 h20 vSSMy2
Gui Add, Picture, x147 y475 w48 h-1 +BackgroundTrans VSSMSelect gGetCords, Gui\select.png ;local image
Gui, Add, Text, x2 y440 w200 h20 center +BackgroundTrans cWhite vSSMMulti,Area Scan (window)
Gui, Add, Edit, x2 y400 w190 h20 vSSMMultiEdit
Sidecleaner()
;Main Window Mode Bar
Gui Add, Picture, x200 y140 w600 h35 , Gui\ManagerHeader.png ;local image
Gui Font, Bold s16
ModeText:="Pick Mode To Edit"
Gui Add, Text, x200 y145 w600 h40 c434343 center BackgroundTrans vModeText, Pick Mode To Edit
Gui, Show,w800 h600, %name% ; test gui size and name
;Flows auto get data from user INI. then make images by modes and add them to the gui thaaadaaa
#Include %A_ScriptDir%\Core\INIReader.ahk  ; Get Image Cords from INI
OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes" , "|")
global Botitini:=StrSplit(OutputVar,"|")
Loop % Botitini.MaxIndex()
{
	
  global looper
  looper := % Botitini[A_Index]
  FlowRider(looper)
  if (A_Index = 1)
  {
    
    Gui Add, Picture, x205 y72 w64 h-1 v%looper% gflow BackgroundTrans, Gui\Flow\%looper%.png
    GuiControl,  Hide, %looper%
    GuiControl,  +Redraw, %looper%
    
  }
  Else
  {
    Gui Add, Picture, x+20 y72 w64 h-1 v%looper% gflow  BackgroundTrans, Gui\Flow\%looper%.png
    GuiControl,  Hide, %looper%
    GuiControl,  +Redraw, %looper%
  }
   
}
Gui Add, Picture, x730 y80 w48 h48  +BackgroundTrans gAddmode, Gui\plus.png ;local image


;Drag Buttom Icons
Gui Add, Text, x220 y487 w220 h30 vSSMaddmodetxt BackgroundTrans c282c31 center, Add To Mode
Gui Add, Picture, x220 y485 w220 h30 vSSMbg1, Gui\ManagerHeader.png ;local image
Gui Add, Picture, x220 y530 w60 h-1 vSSMimgeadd +BackgroundTrans gAddImage, Gui\photoadd.png ;local image
Gui Add, Picture, x+20 y530 w60 h-1 vSSMfuncadd +BackgroundTrans gfuncadd, Gui\code.png ;local image
Gui Add, Picture, x+20 y530 w60 h-1 vSSMpixeladd +BackgroundTrans, Gui\pixels.png ;local image

;hide
GuiControl,Hide ,SSMaddmodetxt
GuiControl,Hide ,SSMbg1
GuiControl,Hide ,SSMimgeadd
GuiControl,Hide ,SSMfuncadd
GuiControl,Hide ,SSMpixeladd


Gui Add, Text, x460 y487 w120 h30 vSSMbuildtxt BackgroundTrans c282c31 center, Build
Gui Add, Picture, x460 y485 w120 h30 vSSMbg2, Gui\ManagerHeader.png ;local image
Gui Add, Picture,x490 y+10 w60 h-1 vSSMnuildicon  +BackgroundTrans, Gui\lego.png ;local image

;hide
GuiControl,Hide ,SSMbuildtxt
GuiControl,Hide ,SSMbg2
GuiControl,Hide ,SSMnuildicon

Gui Add, Text, x600 y487 w180 h30 vSSMEditTxt BackgroundTrans c282c31 center, Edit | Delete
Gui Add, Picture, x600 y485 w180 h30 vSSMbg3, Gui\ManagerHeader.png ;local image
Gui Add, Picture,x610 y+10 w60 h-1 vSSMEditicon +BackgroundTrans gEditMode, Gui\hierarchy.png ;local image
Gui Add, Picture, x700 y530 w48 h48  vSSMdeleteicon gDeleteMode, Gui\Deletemode.png

;hide
GuiControl,Hide ,SSMEditTxt 
GuiControl,Hide ,SSMbg3
GuiControl,Hide ,SSMEditicon
GuiControl,Hide ,SSMdeleteicon

IfExist,Gui\favicon.png
{
	Menu, Tray, Icon, Gui\favicon.png
}
Return ; stop point script will not run above this line unless called with button or function


;app exit label	
GuiEscape:
GuiClose:
ExitApp


;labels
EditMode:
{
  
  ; IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  ; BotitINItoDDL:=StrSplit(Botitini,"|")
  ; Loop % BotitINItoDDL.MaxIndex()
  ; {
  ;   KeyName2=% BotitINItoDDL[A_Index]
  ;   msgbox,%KeyName2%
  ; }
  ; return
  Gui New,
  Gui Add, Picture, x280 y10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png

  Gui, Color, 24292E
  Gui Font, Bold s10
  Gui Add, Picture, x180 y10 w64 h-1 +BackgroundTrans, Gui\Flow\%flowmode%.png
  
  Gui, Add, Edit, x150 y90 w160 h60 vFlowEditbox 
  IniRead,FlowEditbox2 ,Botit ini\Botit.ini,Botit Modes,%flowmode%
  GuiControl,,FlowEditbox,%FlowEditbox2%
  Gui Add,button ,x170 y180 gSaveOrder , Save New Order
  Gui, Add, ListView,x20 y20 w120 h250 ReadOnly Sort vMultiimageView ,Name|Type
  IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  Botitini:=StrSplit(Botitini,"|")
  ;Loop % Botitini.MaxIndex()
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]

    IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%looper%
    Botitini2:=StrSplit(Botitini2,"|")
    Typelist:=Botitini2[1]

    

      LV_Add("",looper,Typelist)
      LV_ModifyCol()
    
    
  }

    

  ;Gui Add,button ,x30 y+20 gAddNewfunc , Add New Image		
  gui -SysMenu
  gui +AlwaysOnTop
  Gui Show, center ,Edit Scans Order
}
Return

SaveOrder:
{
  GuiControlGet,FlowEditbox,,FlowEditbox
  IniWrite,%FlowEditbox%,Botit ini\Botit.ini,Botit Modes,%flowmode%
  LV_Delete()
  IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
    Botitini:=StrSplit(Botitini,"|")
    ;Loop % Botitini.MaxIndex()
    Loop % Botitini.MaxIndex()
    {
      looper := % Botitini[A_Index]

      IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%looper%
      Botitini2:=StrSplit(Botitini2,"|")
      Typelist:=Botitini2[1]

      

        LV_Add("",looper,Typelist)
        LV_ModifyCol()
      
      
    }
  msgbox,0x40000,Error,%UserInput% Already exist,1
}
Return

Cropimage:
KeyWait, LButton, U
BotitScreenshot(lowmode)
SidecleanerFileds()
SideMenu(lowmode)
return

Minidelete:
{
  
  
  StringReplace, Deletename, A_GuiControl, Exit,, All
  IniRead,Botitini2,Botit ini\Botit.ini,Botit Modes,%flowmode%
  If InStr(Botitini2, Deletename "|")
      {
        StringReplace, Botitini2, Botitini2,%Deletename%|,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%flowmode%
        
        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(looper)
        Botitini2:=
        
        return
        
      }
      
      If InStr(Botitini2,"|" Deletename)
      {
        StringReplace, Botitini2, Botitini2,|%Deletename%,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%flowmode%
        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(flowmode)
        
        return
        
      }

      If InStr(Botitini2, Deletename)
      {
        
        StringReplace, Botitini2, Botitini2,%Deletename%,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%flowmode%
        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(flowmode)
        return
        
      }
      
    return
  

  



  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes" , "|")
  Botitini:=StrSplit(OutputVar,"|")




  Loop % Botitini.MaxIndex()
  {

      looper := % Botitini[A_Index]

      IniRead,Botitini2,Botit ini\Botit.ini,Botit Modes,%looper%
      If InStr(Botitini2, Deletename "|")
      {

        StringReplace, Botitini2, Botitini2,%Deletename% | ,

        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%looper%

        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(looper)
        Botitini2:=

        Continue
      }
      
      If InStr(Botitini2,"|" Deletename)
      {
    
        StringReplace, Botitini2, Botitini2,| %Deletename%,

        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(looper)

        Continue
      }

      If InStr(Botitini2, Deletename)
      {

        StringReplace, Botitini2, Botitini2,%Deletename%,

        GuiControl,Hide ,%Deletename%
        GuiControl,Hide ,%Deletename%Exit
        Sidecleaner()
        ObjectRider(looper)
        Continue
      }

      Else
      {

        Continue
      }
      
  }
}
return

funcadd:
{
  
  loop, %A_ScriptDir%\Botit Functions\Minions\*.ahk ; collect all relevant plugins
  {
    tmp:=A_LoopFileName
    StringReplace, JustFileName, A_LoopFileName, .%A_LoopFileExt%,, All
    iniwriteer:="Func"
    IniWrite,%iniwriteer%,Botit ini\Botit.ini,Botit Calls,%JustFileName%

  }
  
  
  
  Gui New,
  Gui Add, Picture, x320 y10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png

  Gui, Color, 24292E
  Gui Font, Bold s10
  Gui Add,button ,x180 y70 gAddtoFlow , Add Function/s To Mode	
  Gui, Add, ListView,x20 y20 w150 ReadOnly Sort vMultiimageView ,Name|Type
  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Calls" , "|")
  Botitini:=StrSplit(OutputVar,"|")
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]

    IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%looper%
    Botitini2:=StrSplit(Botitini2,"|")
    Typelist:=Botitini2[1]
    if (Typelist="Func")
    {

      LV_Add("",looper,Typelist)
      LV_ModifyCol()
    }
    
  }

    

  ;Gui Add,button ,x30 y+20 gAddNewfunc , Add New Image		
  gui -SysMenu
  gui +AlwaysOnTop
  Gui Show, center ,Add Object to Flow
}
return

ObjectBuilder:
{
  
  flowaddons()
  loopnumber:=0
  GuiControl,,ModeText,%flowmode%
  IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  BotitINItoDDL:=StrSplit(Botitini,"|")
  Loop % BotitINItoDDL.MaxIndex()
  {
    sleep,10
    KeyName2=% BotitINItoDDL[A_Index]
    
    ObjectRider(KeyName2)
    loopnumber:=A_Index
    ;msgbox,%loopnumber%
    ;GuiControl,  +Redraw, %KeyName2%
    ;GuiControl,Show ,%KeyName2%
    ;GuiControl,Show ,%KeyName2%exit
    GuiControlGet, MyControl, Name, %KeyName2%
    ;GuiControlGet, OutputVar2,, %KeyName2%
     if (errorlevel=0)
    {
      
    

      if (A_Index = 1)
      {
        GuiControl,Hide ,%KeyName2%
        GuiControl,Hide ,%KeyName2%exit
        VarX:=220
        VarY:=190
        oldname:=KeyName2
        exitnamer:=KeyName2 "Exit"
        ;GuiControlGet, MyEdit, Pos,%oldname%
        Xcalc:=VarX+64+1
        GuiControl, Move, %KeyName2%, % "x" VarX "y" VarY
        GuiControl, Move, %KeyName2%exit, % "x" Xcalc "y" VarY
        GuiControl, +Redraw, %KeyName2%
        GuiControl,  +Redraw, %KeyName2%exit
        GuiControl,Show ,%KeyName2%
        GuiControl,Show ,%KeyName2%exit
       ;  msgbox,done
        Continue
        
      }
      if (A_Index = 7)
      {
        VarX:=220
        VarY:=280
        oldname:=KeyName2
        exitnamer:=KeyName2 "Exit"
        Xcalc:=VarX+64+1
        GuiControl, Move, %KeyName2%, % "x" VarX "y" VarY
        GuiControl, Move, %KeyName2%exit, % "x" Xcalc "y" VarY
        GuiControl, +Redraw, %KeyName2%
        GuiControl,  +Redraw, %KeyName2%exit
        GuiControl,Show ,%KeyName2%
        GuiControl,Show ,%KeyName2%exit
        
        Continue
      }

      if (A_Index = 13)
      {
        VarX:=220
        VarY:=370
        oldname:=KeyName2
        exitnamer:=KeyName2 "Exit"
        Xcalc:=VarX+64+1
        GuiControl, Move, %KeyName2%, % "x" VarX "y" VarY
        GuiControl, Move, %KeyName2%exit, % "x" Xcalc "y" VarY
        GuiControl, +Redraw, %KeyName2%
        GuiControl,  +Redraw, %KeyName2%exit
        GuiControl,Show ,%KeyName2%
        GuiControl,Show ,%KeyName2%exit

        Continue
      }   

      if (A_Index < 7) or (A_Index < 13) or ((A_Index > 13))
      {
        
        
        GuiControlGet, btncopychk, Visible , %KeyName2%
        ;msgbox, %btncopychk%
        ;if (btncopychk=1)
        ;{
        ;  gosub,checkandbuildDUpe
        ;  msgbox,%tmpdupe%
        ;  Continue
        ;}
        GuiControl,Hide ,%KeyName2%
        GuiControl,Hide ,%KeyName2%exit
        global Xcalc
        global MyEditX
        exitnamer:=KeyName2 "Exit"
        Xcalc:=Xcalc+25
        GuiControl, Move, %KeyName2%, % "x" Xcalc "y" VarY
        Xcalc:=Xcalc+64+1
        GuiControl, Move, %KeyName2%exit, % "x" Xcalc "y" VarY
        GuiControl, +Redraw, %KeyName2%
        GuiControl,  +Redraw, %KeyName2%exit
        GuiControl,Show ,%KeyName2%
        GuiControl,Show ,%KeyName2%exit
        oldname:=KeyName2
        Continue
        
      }

      


    }
    else
    {
      
      ;msgbox,%KeyName2%  Not Found
      if (A_Index = 1)
        {
        startx:=220
        starty:=190
        exitnamer:=KeyName2 "Exit"
        ;swapname:=KeyName2 "Swap"
        oldname:=KeyName2
        
        Gui Add, Picture, x210 y190 w64 h64 v%KeyName2% gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y190 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        
        Continue
        
      }
      if (A_Index < 7)
      {
        exitnamer:=KeyName2 "Exit"
        oldname:=KeyName2
        Gui Add, Picture, x+20 y190 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y190 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        Continue
        
      }
      if (A_Index = 7)
      {
        exitnamer:=KeyName2 "Exit"
        Gui Add, Picture, x220 y280 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y280 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        Continue
      }
      if (A_Index < 13)
      {
        exitnamer:=KeyName2 "Exit"
        Gui Add, Picture, x+20 y280 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y280 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        Continue
      }
      if (A_Index = 13)
      {
        exitnamer:=KeyName2 "Exit"
        Gui Add, Picture, x220 y370 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y370 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        Continue
      }   
      if (A_Index > 13)
      {
        exitnamer:=KeyName2 "Exit"
        Gui Add, Picture, x+20 y370 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
        Gui Add, Picture, x+1 y370 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
        Continue
      }
    }

  }
  modepicked=1
}
return


AddMode:
{
  Gui +LastFound +OwnDialogs +AlwaysOnTop
  InputBox, UserInput , Add Image, Please enter Flow Name., , 200, 150
  if ErrorLevel
    Return
  exist:=Checkflows(UserInput)
  if exist
  {
    msgbox,0x40000,Error,%UserInput% Already exist,1
    Return
  }

  IniWrite,% "",Botit ini\Botit.ini,Botit Modes,%UserInput%
  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes" , "|")
  global Botitini:=StrSplit(OutputVar,"|")
  Max:= % Botitini.MaxIndex()
  Max:= Max-1

  Loop % Botitini.MaxIndex()
  {
    
    global looper
    looper := % Botitini[A_Index]
    FlowRider(looper)
    GuiControlGet, OutputVar, Enabled, %looper%
    if (errorlevel=0)
    {
        ;msgbox, the control exists
        GuiControl,Show ,%looper%
        
        x1tmp:=Max * 80 + 205
        
        ;y1tmp=72
        Continue
    }
    

    Else
    {
      Gui Add, Picture, x%x1tmp%+20 y72 w64 h-1 v%looper% gflow  BackgroundTrans, Gui\Flow\%looper%.png
    }
    
  }
  Reload
}
return

DeleteMode:
exist:=Checkflows(flowmode)
if exist
{
  IniDelete,Botit ini\Botit.ini,Botit Modes,%flowmode%
  reload
}
return

GetCords:
{
  GetCords2()
}
return

GetCords2()
{
 
  KeyWait, LButton, U
  ScreenCapture(location:="clipboard")
  sleep, 100
  BW2 := BW2+tmpsnapX
  BH2 := BH2+tmpsnapY
  GuiControl,,SSMx1, %tmpsnapX%
  GuiControl,,SSmy1, %tmpsnapY%
  GuiControl,,SSMx2, %BW2%
  GuiControl,,SSMy2, %BH2%
}

flow:
{
  
  Sidecleaner()
  
  
  

  if (modepicked=1)
  {
    
    IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
    BotitINItoDDL:=StrSplit(Botitini,"|")
    
    Loop % BotitINItoDDL.MaxIndex()
    {
      KeyName2=% BotitINItoDDL[A_Index]
      tmpdupe:=KeyName2 "copy" A_Index
      GuiControl,Hide ,%KeyName2%
      GuiControl,Hide ,%KeyName2%exit
      GuiControl,Hide ,%tmpdupe%
      GuiControl,Hide ,%tmpdupe%exit
      
    }
    modepicked=0
    
  }
  flowmode=% A_GuiControl
  gosub,ObjectBuilder
  gosub,ObjectBuilder
  ;gosub,ObjectBuilder
  ;ObjectBuilder(flowmode)
  ;modepicked=1
}
return

ControlMove: ;control move label
{
  lowmode=% A_GuiControl
  
 ; msgbox % SubStr(lowmode, 1, InStr(lowmode, "Copy") - 1) 
 ; msgbox % SubStr(lowmode, InStr(lowmode, "Copy") + 1)
  
  If InStr(lowmode, "copy")
  {
    lowmode:=SubStr(lowmode, 1, InStr(lowmode, "Copy") - 1)

    msgbox %lowmode%
  }


  SidecleanerFileds()
  SideMenu(lowmode)
  
  ;MouseGetPos,moveX,MoveY,,sHwnd, 2 ;get mouse pos while lebel was called (when we pressed the button we activate "ControlMove")
  ;PostMessage, 0x112,0xF012,0,,ahk_id %sHwnd% ; postmsg allow control over target 
  ;Winset,Redraw,,ahk_id %sHwnd% ; draw the new button while move
  ;WinGetPos,Gx,Gy,Gw,Gh,%name%
  ;LimitX := Gx+Gw-moveX
  ;LimitY := Gy+Gh-MoveY
}
Return

SaveData:
{
  exist:=Checkflows(lowmode)
  if exist
  {
    msgbox,0x40000,Error,%UserInput% Flow exist Dupe,1
    Return
  }
    
  IniRead,Botitini,Botit ini\Botit.ini,Botit Calls,%lowmode%
  Botitini:=StrSplit(Botitini,"|")
  typeOBJ:=Botitini[1]
	if (typeOBJ="Image")
	{
		;image data
    GuiControlGet, Tol,,SSMTolEdit
    GuiControlGet, Moder,,SSMModeCombo
    if (Moder="Window")
    {
      Moder:="Single"
    }
    Else
    {
      Moder:="area"
    }
    GuiControlGet, ScanM,,SSMScanClrCombo
    if (ScanM="GrayScale")
    {
      ScanM:="G"
    }
    Else
    {
      ScanM:="C"
    }
    GuiControlGet, Clickchk,,SSMClickCombo
    if (Clickchk="Click")
    {
      Clickchk:="1"
    }
    Else
    {
      Clickchk:="0"
    }

    ;bundle the call before write
    Liner:="Image|" Tol "|" Moder "|" ScanM "|" Clickchk

    ;ini Write
    IniWrite,%Liner%,Botit ini\Botit.ini,Botit Calls,%lowmode%

    ;installer data
    GuiControlGet, Demopath,,SSMDEMOEdit
    GuiControlGet, Multicalls,,SSMMultiEdit

    Liner:="Image|" Demopath "|" Multicalls
    IniWrite,%Liner%,Botit ini\Installer.ini,Botit Images,%lowmode%


    GuiControlGet, SSMx1,,SSMx1
    GuiControlGet, SSmy1,,SSmy1
    GuiControlGet, SSMx2,,SSMx2
    GuiControlGet, SSMy2,,SSMy2

    Liner:=SSMx1 "|" SSmy1 "|" SSMx2 "|" SSMy2
    IniWrite,%Liner%,Botit ini\ImageXY.ini,Botit XY,%lowmode%
    
    msgbox,0x40000,Saved,Finish Saving,0.7
    return
   
	}
	
	if (typeOBJ="Func")
	{
		return
	}
	
	if (typeOBJ="Pixel")
	{
		return
	}
}
Return

AddImage:
{
  Gui New,
  Gui Add, Picture, x320 y10 w32 h32 gbuttonClosegui, Gui\Botit Exit.png

  Gui, Color, 24292E
  Gui Font, Bold s10
  Gui Add,button ,x180 y70 gAddtoFlow , Add Image/s To Mode	
  Gui, Add, ListView,x20 y20 w150 ReadOnly Sort vMultiimageView ,Name|Type
  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Calls" , "|")
  Botitini:=StrSplit(OutputVar,"|")
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]

    IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%looper%
    Botitini2:=StrSplit(Botitini2,"|")
    Typelist:=Botitini2[1]
    if (Typelist="Image")
    {
      
      LV_Add("",looper,Typelist)
      LV_ModifyCol()
    }
    
  }

    

  Gui Add,button ,x30 y+20 gAddNewImg , Add New Image		
  gui -SysMenu
  gui +AlwaysOnTop
  Gui Show, center ,Add Object to Flow
}
return


AddtoFlow:
{
  
  
  IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  
  if (Botitini = "")
  {
    FirstTrigger:=1
   
  }

  
  RowNumber := 0  ; This causes the first loop iteration to start the search at the top of the list.
  Loop
  {
      RowNumber := LV_GetNext(RowNumber)  ; Resume the search at the row after that found by the previous iteration.
      if not RowNumber  ; The above returned zero, so there are no more selected rows.
          break

      LV_GetText(Text, RowNumber)
      IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
      if (FirstTrigger=1)
      {
        Liner:=Botitini Text
        FirstTrigger:=0
      }

      Else
      {
        Liner:=Botitini "|" Text
      }
      
      IniWrite,%Liner%,Botit ini\Botit.ini,Botit Modes,%flowmode%
      
  }
  gui Destroy
  Gosub, ObjectBuilder
  Gosub, ObjectBuilder
  ; IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  ; BotitINItoDDL:=StrSplit(Botitini,"|")
  ; Loop % BotitINItoDDL.MaxIndex()
  ; {
  ;   sleep,10
  ;   KeyName2=% BotitINItoDDL[A_Index]

  ;   ObjectRider(KeyName2)
  ;   ;msgbox, %KeyName2%
  ;   GuiControl,  +Redraw, %KeyName2%
  ;   GuiControl,Show ,%KeyName2%
  ;   GuiControl,Show ,%KeyName2%exit
  ;   GuiControlGet, MyControl, Name, %KeyName2%
  ;   ;GuiControlGet, OutputVar2,, %KeyName2%
  ;   ;msgbox,%MyControl%  %A_Index%
  ;    if (errorlevel=0)
  ;   {
  ;     ;msgbox, the control exists
  ;     if (A_Index = 1)
  ;     {
  ;       startx:=220
  ;       starty:=190
  ;       exitnamer:=KeyName2 "Exit"      
  ;       GuiControl, Move, %KeyName2%, x210 y190 w64 h64
  ;       GuiControl, Move, %KeyName2%exit, x+1 y190 w64 h64
  ;      ; GuiControl, MoveDraw, %KeyName2%
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
        
  ;     }
  ;     if (A_Index < 7)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"      
  ;       GuiControl, Move, KeyName2, x+15 y190 w64 h64
  ;       GuiControl, Move, KeyName2"exit", x+1 y190 w64 h64
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
        
  ;     }
  ;     if (A_Index = 7)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"      
  ;       GuiControl, Move, KeyName2, x210 y280 w64 h64
  ;       GuiControl, Move, KeyName2"exit", x+1 y280 w64 h64
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
  ;     }
  ;     if (A_Index < 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       GuiControl, Move, KeyName2, x+15 y280 w64 h64
  ;       GuiControl, Move, KeyName2"exit", x+1 y280 w64 h64
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
  ;     }
  ;     if (A_Index = 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       GuiControl, Move, KeyName2, x210 y370 w64 h64
  ;       GuiControl, Move, KeyName2"exit", x+1 y370 w64 h64
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
  ;     }   
  ;     if (A_Index > 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       GuiControl, Move, KeyName2, x+15 y370 w64 h64
  ;       GuiControl, Move, KeyName2"exit", x+1 y370 w64 h64
  ;       GuiControl,Show ,%KeyName2%
  ;       GuiControl,Show ,%KeyName2%exit
  ;       Continue
  ;     }

  ;   }
  ;   else
  ;   {
  ;     ;msgbox,nobtn
  ;     if (A_Index = 1)
  ;       {
  ;       startx:=220
  ;       starty:=190
  ;       exitnamer:=KeyName2 "Exit"
  ;       ;msgbox,%exitnamer%
  ;       Gui Add, Picture, x210 y190 w64 h64 v%KeyName2% gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y190 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
        
  ;     }
  ;     if (A_Index < 7)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       Gui Add, Picture, x+20 y190 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y190 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
        
  ;     }
  ;     if (A_Index = 7)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       Gui Add, Picture, x220 y280 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y280 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
  ;     }
  ;     if (A_Index < 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       Gui Add, Picture, x+20 y280 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y280 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
  ;     }
  ;     if (A_Index = 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       Gui Add, Picture, x220 y370 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y370 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
  ;     }   
  ;     if (A_Index > 13)
  ;     {
  ;       exitnamer:=KeyName2 "Exit"
  ;       Gui Add, Picture, x+20 y370 w64 h64 v%KeyName2%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  ;       Gui Add, Picture, x+1 y370 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png
  ;       Continue
  ;     }
  ;   }

  ; }
}
return



Checkflows(NewMode)
{
  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes" , "|")
  global Botitini:=StrSplit(OutputVar,"|")
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]
    if (NewMode=looper)
    {
      return True
    }
  }
  return false

}

AddNewImg:
{
  Gui +LastFound +OwnDialogs +AlwaysOnTop
  InputBox, UserInput , Add Image, Please enter Image Name., , 200, 150
  if ErrorLevel
      Return

  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Calls" , "|")
  Botitini:=StrSplit(OutputVar,"|")
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]
    if (UserInput=looper)
    {
      msgbox,Error,Error Name already in database
      return
    } 
  }
  ;bundle the call before write
  Liner:="Image"
  ;ini Write
  IniWrite,%Liner%,Botit ini\Botit.ini,Botit Calls,%UserInput%
  IniWrite,%Liner%,Botit ini\Installer.ini,Botit Images,%UserInput%
  IniWrite,% "",Botit ini\ImageXY.ini,Botit XY,%UserInput%
  LV_Delete()
  OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Calls" , "|")
  Botitini:=StrSplit(OutputVar,"|")
  Loop % Botitini.MaxIndex()
  {
    looper := % Botitini[A_Index]

    IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%looper%
    Botitini2:=StrSplit(Botitini2,"|")
    Typelist:=Botitini2[1]
    if (Typelist="Image")
    {
      
      LV_Add("",looper,Typelist)
      LV_ModifyCol()
    }
    
  }
  msgbox,0x40000,Update,List has Been Updated,0.7
}
return

buttonClosegui:
gui Destroy
return

DeleteData:
{
  msgbox,	0x1,Warning,Image Data Will be removed from all ini and flows!
  
  {
    OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes" , "|")
    Modesplitter:=StrSplit(OutputVar,"|")
    
    Loop % Modesplitter.MaxIndex()
    {
     
      looperdlt := % Modesplitter[A_Index]
     
      IniRead,Botitini2,Botit ini\Botit.ini,Botit Modes,%looperdlt%
      If InStr(Botitini2, lowmode "|")
      {
       
        StringReplace, Botitini2, Botitini2,%lowmode%|,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%looperdlt%
        
        GuiControl,Hide ,%lowmode%
        GuiControl,Hide ,%lowmode%Exit
        Sidecleaner()
        IniDelete,Botit ini\Botit.ini,Botit Calls,%lowmode%
        IniDelete,Botit ini\Installer.ini,Botit Images,%lowmode%
        IniDelete,Botit ini\ImageXY.ini,Botit XY,%lowmode%
        ObjectRider(flowmode)
        Botitini2:=
        
        Continue
        
      }
      
      If InStr(Botitini2,"|" lowmode)
      {
    
        StringReplace, Botitini2, Botitini2,|%lowmode%,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%looperdlt%
        GuiControl,Hide ,%lowmode%
        GuiControl,Hide ,%lowmode%Exit
        Sidecleaner()
        IniDelete,Botit ini\Botit.ini,Botit Calls,%lowmode%
        IniDelete,Botit ini\Installer.ini,Botit Images,%lowmode%
        IniDelete,Botit ini\ImageXY.ini,Botit XY,%lowmode%
        ObjectRider(looperdlt)
        Botitini2:=
        Continue
        
      }

      If InStr(Botitini2, lowmode)
      {
        
     
        StringReplace, Botitini2, Botitini2,%lowmode%,
        IniWrite,%Botitini2%,Botit ini\Botit.ini,Botit Modes,%looperdlt%
        GuiControl,Hide ,%lowmode%
        GuiControl,Hide ,%lowmode%Exit
        Sidecleaner()
        IniDelete,Botit ini\Botit.ini,Botit Calls,%lowmode%
        IniDelete,Botit ini\Installer.ini,Botit Images,%lowmode%
        IniDelete,Botit ini\ImageXY.ini,Botit XY,%lowmode%
        ObjectRider(looperdlt)
        Botitini2:=
        Continue
        
      }
      
    }
     
    
   ;modepicked=1
    ;Gosub, Flow
    
    ;FlowRider(looper)
    
    ;IniDelete,Botitini,Botit ini\Botit.ini,Botit Calls,%lowmode%
  }
  msgbox,0x40000,Deleted,Finish Delete,0.7
}
Return

;Functions
BotitScreenshot(Nameimg)
{
	
	Clipboard :=
	ScreenCapture(location:="clipboard")
	sleep, 100
	clip1 := Gdip_CreateBitmapFromClipboard()
	Width := Gdip_GetImageWidth(clip1), Height := Gdip_GetImageHeight(clip1)
	pBitmap := Gdip_CreateBitmap(Width,height)
	G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_DrawImage(G, clip1, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
	Gdip_SaveBitmapToFile(pBitmap,"img/" Nameimg "C.png")
	Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
	Gdip_DrawImage(G, clip1, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
	Gdip_SaveBitmapToFile(pBitmap,"img/" Nameimg "G.png")
	BW2:=tmpsnapX+BW2
	BH2:=tmpsnapY+BH2
	;msgbox, x1 %tmpsnapX% y1 %tmpsnapY% x2  %BW2%  y2  %BH2%
	IniWrite,%tmpsnapX%|%tmpsnapY%|%BW2%|%BH2%,Botit ini\ImageXY.ini,Botit XY,%Nameimg%
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(G)
	Gdip_DisposeImage(clip1)
	Gdip_DisposeImage(Width)
	clip1 :=""
	G :=""
	Width :=""
	pBitmap :=""
	Matrix :=""
  sleep,10
  ;msgbox,%Nameimg% 
  IniRead,Botitini,Botit ini\ImageXY.ini,Botit XY,%Nameimg%
  Botitini:=StrSplit(Botitini,"|")
  tmpsnapX:=Botitini[1]
  tmpsnapY:=Botitini[2]
  BW2:=Botitini[3]
  BH2:=Botitini[4]
  sleep,50
  ;msgbox, x1 %tmpsnapX% y1 %tmpsnapY% x2  %BW2%  y2  %BH2%
  installerimagebuilder(Nameimg,Title,tmpsnapX,tmpsnapY,BW2,BH2)
  Nameimg:=
  Title:=
  tmpsnapX:=
  tmpsnapY:=
  BW2:=
  BH2:=


	Gdip_Shutdown(pToken)
	msgbox,,,Crop Fin,1
	return
}


installerimagebuilder(name,title,x1,y1,x2,y2)
{
  ;msgbox,%name%  %title%  %x1%   %y1%   %x2%   %y2% 
  drawx1:= x1-4
  drawy1:= y1-4
  drawx2:= x2-x1 
  drawy2:= y2-y1
  ;msgbox,  %drawx1%   %drawy1%    %drawx2%     %drawy2%
  pBitmap := Gdip_BitmapFromHWND(hwnd := WinExist("" title ""  ))  ;user grabbed mirror/window name
	;WinGet, hWnd,ID,%Title%
	;pBitmap := Gdip_BitmapFromScreen2("hwnd:" hWnd)
	Gdip_SetBitmapToClipboard(pBitmap)
	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	tmpsnapX:="Image installer\" name ".png"
  ;msgbox,%tmpsnapX%

  namex1:=x1-20
  namey1:=y1-50
  MyText1:=name
  G := Gdip_GraphicsFromImage(pBitmap)
  Options = x%namex1% y%namey1% w120 h50 Center cffa9ede8 s30 Bold
  Gdip_TextToGraphics(G, MyText1, Options, "Bangers")

  pPen := Gdip_CreatePen(0xffff0000, 3)
  Gdip_DrawRectangle(G, pPen, drawx1, drawy1, drawx2, drawy2)
  Gdip_SaveBitmapToFile(pBitmap, tmpsnapX)
  Gdip_DeleteGraphics(G)
  Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
  Liner:="Image|" tmpsnapX "|" Multicalls
  IniWrite,%Liner%,Botit ini\Installer.ini,Botit Images,%MyText1%
  ;Gdip_Shutdown(pToken)
  Return

  sleep,3000
  SetWorkingDir %A_ScriptDir%

  pToken := Gdip_Startup()

  BackGround:="Image installer\" name ".png"
  SaveAs:="Image installer\" name "2.png"
  MyText1:=name

  msgbox, %BackGround%  
  msgbox, %SaveAs%  
  msgbox, %MyText1%  
  pBitmap := Gdip_CreateBitmapFromFile(BackGround)
  G := Gdip_GraphicsFromImage(pBitmap)

  Options = x0 y34 w60 h30 Center cffa9ede8 s14 Bold
  Gdip_TextToGraphics(G, MyText1, Options, "Bangers")



  Gdip_SaveBitmapToFile(pBitmap, SaveAs)

  Gdip_DeleteGraphics(G)
  Gdip_DisposeImage(pBitmap)
  Gdip_Shutdown(pToken)
  
}


SideMenu(Keyname)
{
	GuiControl,Hide ,Righthnad
	GuiControl,Hide ,Lefthand

  
  GuiControl,,ModeTextSide,%Keyname%
	IniRead,Botitini,Botit ini\Botit.ini,Botit Calls,%KeyName%
	Botitini:=StrSplit(Botitini,"|")
	typeOBJ:=Botitini[1]
  
	if (typeOBJ="Image")
	{
		
		GuiControl,Show ,Righthnad
    typeOBJ2:=Botitini[2]
    GuiControl,,SSMTolEdit,%typeOBJ2%
    typeOBJ3:=Botitini[3]
    if (typeOBJ3="Single")
    {
      GuiControl,Choose,SSMModeCombo,|1
    }
    Else
    {
      GuiControl,Choose,SSMModeCombo,|2
    }
    typeOBJ4:=Botitini[4]
    if (typeOBJ4="C")
    {
      GuiControl,Choose,SSMScanClrCombo,|2
    }
    Else
    {
      GuiControl,Choose,SSMScanClrCombo,|1
    }
    typeOBJ5:=Botitini[5]
        if (typeOBJ5=0)
    {
      GuiControl,Choose,SSMClickCombo,|2
    }
    Else
    {
      GuiControl,Choose,SSMClickCombo,|1
    }

    IniRead,Botitini,Botit ini\Installer.ini,Botit Images,%KeyName%
	  Botitini:=StrSplit(Botitini,"|")
    typeOBJ2:=Botitini[2]
    GuiControl,,SSMDEMOEdit,%typeOBJ2%

    typeOBJ3:=Botitini[3]
    GuiControl,,SSMMultiEdit,%typeOBJ3%
    ;SSMx1|SSMx2|SSmy1|SSMy2
    IniRead,Botitini,Botit ini\ImageXY.ini,Botit XY,%KeyName%
	  Botitini:=StrSplit(Botitini,"|")
    typeOBJ:=Botitini[1]
    GuiControl,,SSMx1,%typeOBJ%
    typeOBJ2:=Botitini[2]
    GuiControl,,SSmy1,%typeOBJ2%

    typeOBJ3:=Botitini[3]
    GuiControl,,SSMx2,%typeOBJ3%
    typeOBJ4:=Botitini[4]
    GuiControl,,SSMy2,%typeOBJ4%

	}
	
	if (typeOBJ="Func")
	{
		Return
	}
	
	if (typeOBJ="Pixel")
	{
		GuiControl,Show ,Lefthand
	}
	
	ImgFileName := "img\" Keyname "C.png"
	IfnotExist, %ImgFileName%
	{
		
		GuiControl,  +Redraw, notFound
    xcenter:=Round((180)/2)-Round(32/2)
		GuiControl,,notFound, *w32 *h32 Gui\not-found.png
    GuiControl, Move,Gui\not-found.png,x%xcenter%
		GuiControl, MoveDraw,Gui\not-found.png
		GuiControl, +Redraw, notFound
		
	}
	else
	{
    pToken := Gdip_StartUp()
    pBitmap := Gdip_CreateBitmapFromFile(ImgFileName)
    Gdip_GetImageDimensions(pBitmap, w1, h1)
    Gdip_DisposeImage(pBitmap)
    Gdip_ShutDown(pToken)
    if (w1 > 100)
    {
      w1:=100
      }

    if (h1 > 33)
    {
      h1:=32
    }
    GuiControl,Hide ,notFound
    GuiControl, -Redraw, notFound
    xcenter:=Round((180)/2)-Round(w1/2)

		GuiControl,,notFound, *w%w1% *h%h1% %ImgFileName%
    GuiControl, Move,Gui\not-found.png,x%xcenter%
    GuiControl, MoveDraw,*x%xcenter% %ImgFileName%
		GuiControl,  +Redraw, notFound
    
	}
  GuiControl,Show ,SSMTol
	GuiControl,Show ,SSMTolEdit
  GuiControl,Show ,SSMMode
  GuiControl,Show ,SSMModeCombo
  GuiControl,Show ,ModeTextSide

  GuiControl,Show ,SSMScanClr
	GuiControl,Show ,SSMScanClrCombo
  GuiControl,Show ,SSMClick
  GuiControl,Show ,SSMClickCombo

  GuiControl,Show ,SSMDEMO
	GuiControl,Show ,SSMDEMOEdit
  GuiControl,Show ,SSMx1
  GuiControl,Show ,SSMx2
  GuiControl,Show ,SSmy1
  GuiControl,Show ,SSMy2
	GuiControl,Show ,SSMSelect
  GuiControl,Show ,SSMMulti
  GuiControl,Show ,SSMMultiEdit
	GuiControl,Show ,SSMDemoFolder
	
  GuiControl,Show ,SSMX1Text
  GuiControl,Show ,SSMY1Text
  GuiControl,Show ,SSMX2Text
  GuiControl,Show ,SSMY2Text

  
  ;SSMX1Text|SSMY1Text|SSMX2Text|SSMY2Text
}


flowaddons()
{
  GuiControl,Show ,SSMbg1
  
  GuiControl,Show ,SSMimgeadd
  GuiControl,Show ,SSMfuncadd
  GuiControl,Show ,SSMpixeladd 
 
  GuiControl,Show ,SSMaddmodetxt
  GuiControl,+Redraw, SSMaddmodetxt 
  

  GuiControl,Show ,SSMbuildtxt
  GuiControl,+Redraw,SSMbuildtxt
  GuiControl,Show ,SSMbg2
  GuiControl,Show ,SSMnuildicon

  GuiControl,Show ,SSMEditTxt
  GuiControl,+Redraw,SSMEditTxt
  GuiControl,Show ,SSMbg3
  GuiControl,Show ,SSMEditicon
  GuiControl,Show ,SSMdeleteicon

  GuiControl,Show ,SSMsaveicon
  GuiControl,Show ,SSMremoveicon
  GuiControl,Show ,SSmcropicon
}

Sidecleaner()
{
	GuiControl,Hide ,Righthnad
	GuiControl,Hide ,Lefthand
  GuiControl,Hide ,notFound
  GuiControl, -Redraw, notFound
  GuiControl,Hide ,ModeTextSide
  GuiControl,Hide ,SSMTol
	GuiControl,Hide ,SSMTolEdit
  GuiControl,Hide ,SSMMode
  GuiControl,Hide ,SSMModeCombo

  GuiControl,Hide ,SSMScanClr
	GuiControl,Hide ,SSMScanClrCombo
  GuiControl,Hide ,SSMClick
  GuiControl,Hide ,SSMClickCombo
  
  GuiControl,Hide ,SSMDEMO
	GuiControl,Hide ,SSMDEMOEdit
  GuiControl,Hide ,SSMx1
  GuiControl,Hide ,SSMx2
  GuiControl,Hide ,SSmy1
  GuiControl,Hide ,SSMy2
	GuiControl,Hide ,SSMSelect
  GuiControl,Hide ,SSMMulti
  GuiControl,Hide ,SSMMultiEdit
  GuiControl,Hide ,SSMDemoFolder

  GuiControl,Hide ,SSMX1Text
  GuiControl,Hide ,SSMY1Text
  GuiControl,Hide ,SSMX2Text
  GuiControl,Hide ,SSMY2Text


  
  ;SSMaddmodetxt  | 
}

SidecleanerFileds()
{
  GuiControl,,SSMTolEdit
  GuiControl,,SSMDEMOEdit
  GuiControl,,SSMMultiEdit
  GuiControl,,SSMx1
  GuiControl,,SSMx2
  GuiControl,,SSmy1
  GuiControl,,SSMy2
  
  
}


checkandbuildDUpe:
{

  ;random,keyassign,1,1000
  msgbox,%loopnumber%
  global tmpdupe
  tmpdupe:=KeyName2 "copy" loopnumber
  exitnamer:=tmpdupe "Exit"

 ; msgbox,
  GuiControlGet, MyControl2, Name, %tmpdupe%
  if (errorlevel=0)
  {
    msgbox,found dupe %MyControl2%
    Return
  }

  Gui Add, Picture, x+20 y190 w64 h64 v%tmpdupe%  gControlMove +BackgroundTrans, Gui\ManagerObjects\%KeyName2%.png
  Gui Add, Picture, x+1 y190 w12 h12 v%exitnamer% gMinidelete +BackgroundTrans, Gui\remove.png

  ;msgbox,1


}
Return

FlowRider(KeyName)
{
  SetWorkingDir %A_ScriptDir%

  pToken := Gdip_Startup()

  BackGround:="Gui\FlowLogo.png"
  SaveAs:="Gui\Flow\" KeyName ".png"
  MyText1:=KeyName


  pBitmap := Gdip_CreateBitmapFromFile(BackGround)
  G := Gdip_GraphicsFromImage(pBitmap)

  Options = x0 y34 w60 h30 Center cffa9ede8 s14 Bold
  Gdip_TextToGraphics(G, MyText1, Options, "Bangers")



  Gdip_SaveBitmapToFile(pBitmap, SaveAs)

  Gdip_DeleteGraphics(G)
  Gdip_DisposeImage(pBitmap)
  Gdip_Shutdown(pToken)
}


ObjectRider(KeyName)
{
	SetWorkingDir %A_ScriptDir%
	pToken := Gdip_Startup()
	
	IniRead,Botitini,Botit ini\Botit.ini,Botit Calls,%KeyName%
	Botitini:=StrSplit(Botitini,"|")
	typeOBJ:=Botitini[1]
	
	if (typeOBJ="Image")
	{
		BackGround:="Gui\BotitImage.png"
	}
	
	if (typeOBJ="Func")
	{
		BackGround:="Gui\BotitFunc.png"
	}
	
	if (typeOBJ="Pixel")
	{
		BackGround:="Gui\BotitPixel.png"
	}
	
	
	MyText1:=KeyName
	SaveAs:="Gui\ManagerObjects\" KeyName ".png"
	
	pBitmap := Gdip_CreateBitmapFromFile(BackGround)
	G := Gdip_GraphicsFromImage(pBitmap)
	
	Options = x0 y39 w60 h30 Center cffa9ede8 s14 Bold
	Gdip_TextToGraphics(G, MyText1, Options, "Bangers")
	
	
	
	Gdip_SaveBitmapToFile(pBitmap, SaveAs)
	
	Gdip_DeleteGraphics(G)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
  
}
return

;Includes
#Include %A_ScriptDir%\Core\Gdip_All.ahk
#Include %A_ScriptDir%\Core\Clipper.ahk
