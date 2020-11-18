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
name := "Botit Image Tool"

IfExist,Gui\favicon.png
{
	Menu, Tray, Icon, Gui\favicon.png
}
DllCall( "GDI32.DLL\AddFontResourceEx", Str,"Gui\Bangers-Regular.ttf",UInt,(FR_PRIVATE:=0x10), Int,0)
;DllCall( "AddFontResource", Str,"Gui\Bangers-Regular.ttf" ) 
;SendMessage,  0x1D,,,, ahk_id 0xFFFF ; Broadcast the change

Gui Font, Bold s26,Bangers
Gui, Color, fbfbfb

;sidebars

;Gui Font, Bold s16,Bangers
;settings build import
IniRead,discord,Botit ini\Build.ini,Botit Build,discord
IniRead,youtube,Botit ini\Build.ini,Botit Build,youtube
IniRead,website,Botit ini\Build.ini,Botit Build,website

;Top Header
Gui Add, Picture, x0 y0 w800 h70 , Gui\ManagerHeader.png ;local image
Gui Add, Text, x0 y00 w800  c434343 center BackgroundTrans , Botit Image Tool
Gui Add, Picture, x10 y5 w60 h-1 +BackgroundTrans gdiscord, Gui\discordlogo.png ;local image
Gui Add, Picture, x+25 y8 w55 h-1 +BackgroundTrans gyoutube, Gui\utube.png ;local image
Gui Add, Picture, x650 y8 w55 h-1 +BackgroundTrans gpatr, Gui\patreon.png ;local image
Gui Add, Picture, x+25 y8 w55 h-1 +BackgroundTrans gwebs, Gui\internet.png ;local image

Gui Add, Picture, x0 y250 w165 h400  , Gui\ManagerSideMenu.png ;local image
;Main Window Mode Bar
Gui Add, Picture, x0 y220 w800 h30 , Gui\ManagerHeader.png ;local image
Gui Font, Bold s18
ModeText:="Pick Mode To Edit"
Gui Add, Text, x0 y210 w800  c434343 center BackgroundTrans vModeText, Demo image
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
    yset:= 72
    Gui Add, Picture, x5 y%yset% w45 h-1 v%looper% gflow BackgroundTrans, Gui\Flow\%looper%.png
    GuiControl,  Hide, %looper%
    GuiControl,  +Redraw, %looper%
    GuiControl,  Show, %looper%
    Continue
    
  }

  if (A_Index = 4)
  {
    yset:= 130
    Gui Add, Picture, x5 y%yset% w45 h-1 v%looper% gflow BackgroundTrans, Gui\Flow\%looper%.png
    GuiControl,  Hide, %looper%
    GuiControl,  +Redraw, %looper%
    GuiControl,  Show, %looper%
    Continue
    
  }


  if (A_Index = 7)
  {

    msgbox, too much modes.
    ExitApp

  }

  Else
  {
    
    Gui Add, Picture, x+8 y%yset% w45 h-1 v%looper% gflow  BackgroundTrans, Gui\Flow\%looper%.png
    GuiControl,  +Redraw, %looper%
    GuiControl,  Hide, %looper%
    GuiControl,  +Redraw, %looper%
    GuiControl,  Show, %looper%
    Continue
  }
   
}

Gui Add, Picture, x162 y60 w5 h160 , Gui\ManagerHeader.png ;local image


Gui Add, Text, x0 y210 w170 h240 cWhite center BackgroundTrans vModeTextSide,
Gui Add, Picture, x10 y260 w32 h-1 +BackgroundTrans vnotFound, Gui\not-found.png ;local image
GuiControl,Hide ,notFound
Gui Add, Picture, x175 y255 w-1 h360 +BackgroundTrans vdemoimage, Gui\not-found.png ;local image
GuiControl,Hide ,demoimage
Gui Font, Bold s12,arial
Gui Add, Text, x0 y374 w160 h40 cWhite center +BackgroundTrans vsidetext1 ,Test options
Gui Add, Picture, x30 y400 w42 h-1 +BackgroundTrans vfaceicon gtesttarget, Gui\face-recognition.png ;local image
Gui Add, Picture, x90 y400 w42 h-1 +BackgroundTrans vtesticon gtesttarget2, Gui\touch.png ;local image
Gui Font, Bold s11,arial
Gui Add, Text, x0 y454 w160 h30 cWhite center +BackgroundTrans vsidetext2 ,Retake Area Or Image
Gui Add, Picture, x10 y480 w46 h-1 +BackgroundTrans VSSMSelect gGetCords, Gui\select.png ;local image
Gui Add, Picture, x65 y478 w40 h-1 +BackgroundTrans  vautocropimg gautocrop, Gui\auto.png ;local image
GuiControl,hide ,autocropimg
Gui Add, Picture, x120 y478 w40 h-1 +BackgroundTrans gCropimage vSSmcropicon, Gui\crop.png ;local image
Gui Add, Picture, x0 y370 w180 h2 vsideline1 , Gui\Backgroundmanager.png ;local image
Gui Add, Picture, x0 y450 w180 h2 vsideline2, Gui\Backgroundmanager.png ;local image
Gui Add, Picture, x0 y530 w180 h2 vsideline3, Gui\Backgroundmanager.png ;local image

Gui Font, Bold s12,arial
Gui Add, Text, x0 y534 w160 h30 cWhite center +BackgroundTrans vsidetext3 ,ImageMagic

GuiControl,  +Redraw ,sideline1
GuiControl,  +Redraw ,sideline2
GuiControl,  +Redraw ,sideline3

IfExist,Gui\favicon.png
{
	Menu, Tray, Icon, Gui\favicon.png
}
Return ; stop point script will not run above this line unless called with button or function


;app exit label	
GuiEscape:
GuiClose:
ExitApp



Cropimage:
KeyWait, LButton, U
BotitScreenshot(lowmode)
SidecleanerFileds()
SideMenu(lowmode)
return

imgbuilder:
{
      
     ; msgbox, %newcontrol% %oldcontrol%
      ObjectRider(newcontrol)  ;build image
      GuiControlGet, MyControl, Name, %newcontrol% ;check if controller Exist
      if (errorlevel=0)  ;if exist move and redraw
      {
        
        GuiControlGet, OutputVar, Visible , newcontrol
        if (OutputVar = 1)
        {
          Return
        }
        Else
        {
          if (oldcontrol = "none")
          {
            
            VarX:=170
            VarY:=70
            GuiControl, Move, %newcontrol%, % "x" VarX "y" VarY
            GuiControl, +Redraw, %newcontrol%
            
            return
          
          }
          Else  ; btn Exist but not showing
          {
            GuiControlGet, MyEdit, Pos,%oldcontrol%
              if (MyEditX>700)
              {
                MyEditY:=MyEditY+50
                MyEditX:=170
                GuiControl, Move, %newcontrol%, % "x" MyEditX "y" MyEditY
                GuiControl, +Redraw, %newcontrol%
              }
              Else
              {
                MyEditX:= MyEditX+50
                GuiControl, Move, %newcontrol%, % "x" MyEditX "y" MyEditY
                GuiControl, +Redraw, %newcontrol%
              }
          }

        }
       
      }
      else ; if not exist build
      {
        
        ;on first button after flow pressed
        if (oldcontrol = "none")
        {
          Gui Add, Picture, x170 y70 w48 h-1 v%newcontrol% gControlMove +BackgroundTrans, Gui\ManagerObjects\%newcontrol%.png
          GuiControl, +Redraw, %newcontrol%
          return
          
        }
        GuiControlGet, MyEdit, Pos,%oldcontrol%
        ;MsgBox The X coordinate is %MyEditX%. The Y coordinate is %MyEditY%. The width is %MyEditW%. The height is %MyEditH%.
        {
          if (MyEditX>700)
          {
            MyEditY:=MyEditY+50
            Gui Add, Picture, x170 y%MyEditY% w48 h-1 v%newcontrol% gControlMove +BackgroundTrans, Gui\ManagerObjects\%newcontrol%.png
          }
          Else
          {
            MyEditX:= MyEditX+50
            ;msgbox,else %MyEditX%
            Gui Add, Picture, x%MyEditX% y%MyEditY% w48 h-1 v%newcontrol% gControlMove +BackgroundTrans, Gui\ManagerObjects\%newcontrol%.png
            GuiControl, +Redraw, %newcontrol%
          }
        }
        

        return
        
      }
}
return

discord:
run,%discord%
return

youtube:
run,%youtube%
return

patr:
run,https://www.patreon.com/AutoMirror
return

webs:
run,%website%
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
   ;  tmpdupe:=KeyName2 "copy" A_Index

      IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
      typechk:=StrSplit(typechk,"|")
      typeOBJ:=typechk[1]
      if (typeOBJ="Image")
      {
        GuiControl,Hide ,%KeyName2%
      }

      if (typeOBJ="Func")
      {
        ;msgbox,func
        Loop % typechk.MaxIndex()
        {
          if (typechk[A_Index]="Func")
          {
            Continue
          }
          funcbtnremove:= typechk[A_Index]
          GuiControl,Hide ,%funcbtnremove%
        }
      } 
    }
    modepicked=0
    
  }
  flowmode=% A_GuiControl
  oldcontrol:="none"
  IniRead,Botitini,Botit ini\Botit.ini,Botit Modes,%flowmode%
  BotitINItoDDL:=StrSplit(Botitini,"|")
  Loop % BotitINItoDDL.MaxIndex()
  {
     ; msgbox, old %oldcontrol%
      KeyName2=% BotitINItoDDL[A_Index]
      IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
      typechk:=StrSplit(typechk,"|")
      typeOBJ:=typechk[1]
      if (typeOBJ="Image")
      {
        newcontrol:=KeyName2
        gosub,imgbuilder
        oldcontrol:=newcontrol
      }
      if (typeOBJ="Func")
      {
        ;msgbox,func
        Loop % typechk.MaxIndex()
        {
          if (typechk[A_Index]="Func")
          {
            Continue
          }
          
          newcontrol:=typechk[A_Index]
          ;msgbox,new %newcontrol%   old %oldcontrol%
          gosub,imgbuilder
          oldcontrol:=typechk[A_Index]
          ;msgbox,% typechk[A_Index]
        }
      }
      
      
  }
  
  modepicked=1
  return


}
return

ControlMove: ;control move label
{
  global lowmode
  lowmode=% A_GuiControl
  
 ; msgbox % SubStr(lowmode, 1, InStr(lowmode, "Copy") - 1) 
 ; msgbox % SubStr(lowmode, InStr(lowmode, "Copy") + 1)
  
  If InStr(lowmode, "copy")
  {
    lowmode:=SubStr(lowmode, 1, InStr(lowmode, "Copy") - 1)

    
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

buttonClosegui:
gui Destroy
return

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

AutoScreenshot(ImageName,Wauto,Hauto,targetwindow)
{
	

	;msgbox, %targetwindow%
	IniRead,Botitini,Botit ini\ImageXY.ini,Botit XY,%ImageName%
	Botitini:=StrSplit(Botitini,"|")
	Botitini%ImageName%x1 := Botitini[1]
	Botitini%ImageName%y1 := Botitini[2]
	Botitini%ImageName%x2 := Botitini[3]
	Botitini%ImageName%y2 := Botitini[4]
	
	
	tmpw2 := Botitini%ImageName%x2
	tmph2 := Botitini%ImageName%y2
	ImgNamew := Botitini%ImageName%x1
	ImgNameh := Botitini%ImageName%y1
	
	
	
	global ImgNamew2 := tmpw2 - ImgNamew
	global ImgNameh2 := tmph2 - ImgNameh
	
	
	
	WinMove,%targetwindow%,,,,%Wauto%,%Hauto% 
	sleep,50
  WinMove,%targetwindow%,,,,%Wauto%,%Hauto% 
  sleep,10
	WinGet, hWnd,ID,%targetwindow% 
	
	
	
	
	If !pToken := Gdip_Startup()
	{
		MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
		ExitApp
	}
	
	pBitmap := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  ))
	Gdip_SaveBitmapToFile(pBitmap,"img/test.png")
	clip1 := Gdip_CreateBitmapFromFile("img/test.png")
	
	Width := Gdip_GetImageWidth(clip1), Height := Gdip_GetImageHeight(clip1)
	pBitmap := Gdip_CreateBitmap(ImgNamew2,ImgNameh2)
	G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_DrawImage(G, clip1, 0, 0, Width, Height, ImgNamew, ImgNameh, Width, Height, Matrix)
	Gdip_SaveBitmapToFile(pBitmap,"img/" ImageName "C.png")
	Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
	Gdip_DrawImage(G, clip1, 0, 0, Width, Height, ImgNamew, ImgNameh, Width, Height, Matrix)
	Gdip_SaveBitmapToFile(pBitmap,"img/" ImageName "G.png")
	
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(clip1)
	Gdip_DeleteGraphics(G)
	Gdip_DisposeImage(Height)
	Gdip_DisposeImage(Width)
	Gdip_Shutdown(pToken)
	G :=""
	Matrix := ""
	msgbox,,Done,Crop Fin,0.5
	return
}

installerimagebuilder(name,targetwindow,x1,y1,x2,y2)
{
  ;msgbox,%name%  %title%  %x1%   %y1%   %x2%   %y2% 
  drawx1:= x1-4
  drawy1:= y1-4
  drawx2:= x2-x1 
  drawy2:= y2-y1
  ;msgbox,  %drawx1%   %drawy1%    %drawx2%     %drawy2%
  pBitmap := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  ))  ;user grabbed mirror/window name
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
  ;Nameimg:=
  ;targetwindow:=
  ;tmpsnapX:=
  ;tmpsnapY:=
  ;BW2:=
  ;BH2:=
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
		Sidecleaner()
    Return
    GuiControl,Show ,Lefthand
	}
	
	ImgFileName := "img\" Keyname "C.png"
	IfnotExist, %ImgFileName%
	{
		
		GuiControl,  +Redraw, notFound
    xcenter:=Round((160)/2)-Round(32/2)
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
    
    if (w1 > h1)
    {
      if (w1>140)
      {
        w1:=140
        h1:=-1
      }
    }

    else
    {
      if (h1>90)
      {
        h1:=90
        w1:=-1
      }
      
    }
    GuiControl,Hide ,notFound
    GuiControl, -Redraw, notFound
    xcenter:=Round((120)/2)-Round(w1/2)

		GuiControl,,notFound, *w%w1% *h%h1% %ImgFileName%
    GuiControl, Move,Gui\not-found.png,x%xcenter%
    GuiControl, MoveDraw,*x%xcenter% %ImgFileName%
		GuiControl,  +Redraw, notFound
    
	}
  loaddemo(Keyname)
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

  GuiControl,Show ,sidetext1
  GuiControl,Show ,faceicon
  GuiControl,Show ,testicon
  GuiControl,Show ,sidetext2
  GuiControl,Show ,SMSelect
  GuiControl,Show ,SSmcropicon
  GuiControl,Show ,autocropimg
  GuiControl,Show ,sidetext3
  
  ;SSMX1Text|SSMY1Text|SSMX2Text|SSMY2Text
}

testtarget:
Grab("scan")
return

testtarget2:
Grab("click1")
return


autocrop:
;msgbox,%lowmode%
{
  if (targetwindow = "" )
  {
      MsgBox,262144,No Target, No Window target! Grab Mirror,1
      settimer,Titletracker,20
      sleep,150
      KeyWait, LButton, D
      {
        MouseGetPos,,,guideUnderCursor
        WinGetTitle, targetwindow, ahk_id %guideUnderCursor%
        
        ;global namer2
        ;global Timore
        
        settimer,Titletracker,off
        ToolTip,
      
      }
  }
  WinGetPos,,,cropWchk,cropHchk,%targetwindow%
  if (cropWchk>cropHchk)
  {
    ;msgbox,w %cropWchk%  %cropHchk%
    IniRead,autocropW,Botit ini\Build.ini,Botit Build,autocropW2
    IniRead,autocropH,Botit ini\Build.ini,Botit Build,autocropH2
    AutoScreenshot(lowmode,autocropW,autocropH,targetwindow)
    SidecleanerFileds()
    SideMenu(lowmode)
    Return
  }
  Else
  {
    ;msgbox,h %cropWchk%  %cropHchk%
    IniRead,autocropW,Botit ini\Build.ini,Botit Build,autocropW
    IniRead,autocropH,Botit ini\Build.ini,Botit Build,autocropH
    AutoScreenshot(lowmode,autocropW,autocropH,targetwindow)
    SidecleanerFileds()
    SideMenu(lowmode)
    Return
  }
}
return

Grab(mode)
{
  
  
  if (mode="scan")
  {
   ; msgbox, %mode%
    settimer,Titletracker,50
    sleep,150
    KeyWait, LButton, D
    {
      MouseGetPos,,,guideUnderCursor
      WinGetTitle, targetwindow, ahk_id %guideUnderCursor%
      global namer2
      global Timore
      settimer,Titletracker,off
      ToolTip,
      IniRead,Botitini,Botit ini\Botit.ini,Botit Calls,%lowmode%
	    Botitini:=StrSplit(Botitini,"|")
      tol:=Botitini[2]
      scantype:=Botitini[3]
      scancolors:=Botitini[4]
      exist:=BotItScannertest(lowmode,tol,scantype,scancolors,0,targetwindow)	
	    if exist
      {
        
        msgbox,0x40000,Image Detected,RelativeX %truex2%  RelativeY%truey2%  Name %namer2%  Scan Time %Timore%  Target Window: %targetwindow%,2
        return
      }
      Else
      {
        msgbox,0x40000,No Detect,Name %lowmode% Target Window: %targetwindow%,2
        return
      }
    }
  }

  if (mode="click1")
  {
    ;msgbox, %mode%
    settimer,Titletracker,20
    sleep,150
    KeyWait, LButton, D
    {
      MouseGetPos,,,guideUnderCursor
      WinGetTitle, targetwindow, ahk_id %guideUnderCursor%
      ;global targetwindow
      global namer2
      global Timore
      ;targetwindow := Title
      settimer,Titletracker,off
      ToolTip,
      IniRead,Botitini2,Botit ini\Botit.ini,Botit Calls,%lowmode%
	    Botitini2:=StrSplit(Botitini2,"|")
      tol:=Botitini2[2]
      scantype:=Botitini2[3]
      scancolors:=Botitini2[4]
     ; msgbox, name: %lowmode%  tol: %tol% type: %scantype% colors: %scancolors%
      exist:=BotItScannertest(lowmode,tol,scantype,scancolors,1,targetwindow)	
	    if exist
      {
        ;sleep,1000
        msgbox,0x40000,Image Detected,RelativeX %truex2%  RelativeY%truey2%  Name %namer2%  Scan Time %Timore%  Target Window: %targetwindow%,2
        return
        ;msgbox,RelativeX %truex2%  RelativeY%truey2%  Name %namer2%  Scan Time %Timore%  Target Window: %targetwindow%
      }
      Else
      {
        msgbox,0x40000,No Detect,Name %lowmode% Target Window: %targetwindow%,2
        return

      }
    }
  }

  Else
  {
    settimer,Titletracker,20
    sleep,150
    KeyWait, LButton, D
    {
      MouseGetPos,,,guideUnderCursor
      WinGetTitle, Title2, ahk_id %guideUnderCursor%
      
      ;global namer2
      ;global Timore
      global targetwindow2 := ahk_id %guideUnderCursor%
      settimer,Titletracker,off
      ToolTip,
     
    }
  }
}


Titletracker:
MouseGetPos,,,guideUnderCursor
WinGetTitle, targetwindow, ahk_id %guideUnderCursor%
ToolTip, %Title% left mouse Click on Title
return


loaddemo(Keyname)
{
  ImgFileName := "Image installer\" Keyname ".png"
  pToken := Gdip_StartUp()
  pBitmap := Gdip_CreateBitmapFromFile(ImgFileName)
  Gdip_GetImageDimensions(pBitmap, w1, h1)
  Gdip_DisposeImage(pBitmap)
  Gdip_ShutDown(pToken)

  if (w1 > h1)
    {
      if (w1>580)
      {
        w1:=560
        h1:=-1
      }
    }

    else
    {
      if (h1>360)
      {
        h1:=360
        w1:=-1
      }
    }
  GuiControl,Hide ,demoimage
  GuiControl, -Redraw, demoimage
  GuiControl,,demoimage, *w%w1% *h%h1% %ImgFileName%
  GuiControl,,demoimage, %ImgFileName%
  GuiControl,  +Redraw, demoimage

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

  ;GuiControl,Show ,SSMsaveicon
  ;GuiControl,Show ,SSMremoveicon
  ;GuiControl,Show ,SSmcropicon
 ; GuiControl, +Redraw, SSmcropicon
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

  GuiControl,Hide ,sidetext1
  GuiControl,Hide ,faceicon
  GuiControl,Hide ,testicon
  GuiControl,Hide ,sidetext2
  GuiControl,Hide ,SMSelect
  GuiControl,Hide ,SSmcropicon
  GuiControl,Hide ,autocropimg
  GuiControl,Hide ,sidetext3


  
  
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



FlowRider(KeyName)
{
  SetWorkingDir %A_ScriptDir%

  pToken := Gdip_Startup()

  BackGround:="Gui\FlowLogo.png"
  SaveAs:="Gui\Flow\" KeyName ".png"
  MyText1:=KeyName


  pBitmap := Gdip_CreateBitmapFromFile(BackGround)
  G := Gdip_GraphicsFromImage(pBitmap)

  Options = x0 y35 w60 h30 Center cffa9ede8 s16 Bold
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
#Include %A_ScriptDir%\Botit Functions\func.ahk
#Include %A_ScriptDir%\Core\INIReader.ahk  ; Get Image Cords from INI