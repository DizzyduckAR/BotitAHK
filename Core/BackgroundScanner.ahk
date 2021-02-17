; This script was created by Arazu 
; https://discord.gg/ggRCXS2
; https://github.com/DizzyduckAR/BotitAHK
;global Mode

;BGS
;**************************************************************

;Random, SleepAmount, 1450, 1750  ; will random sleep after click
;ImgFileName - name or number of the image
;Diff - 1-254 ;how different img can be for match.
;Modes - Single ,Area , Multi 
;Clicks - 0/1  No click Vs Click target found
;Colors - C/G  color VS grayscale
;
global locker := 0
global result

; Converts RGB with Alpha Channel to RGB
ARGBtoRGB( ARGB )
{
	SetFormat, IntegerFast, hex
	ARGB := ARGB & 0x00ffffff
	ARGB .= “” ; Necessary due to the “fast” mode.
	SetFormat, IntegerFast, d
	return ARGB
}

;our main image match system
BotItScanner(Name,Diff,Mode,Colors,Clicks)
{
	
	
	;msgbox, %Name%  %Diff%   %Mode%   %Colors%  %Clicks% %targetwindow%
	if (Mode = "area")
	{
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		%namer%x1 := BotitiniXYtmp[1]-10
		%namer%y1 := BotitiniXYtmp[2]-10
		%namer%x2 := BotitiniXYtmp[3]+10
		%namer%y2 := BotitiniXYtmp[4]+10
		tmpoX1 := %namer%x1
		tmpoY1 := %namer%y1
		tmpoX2A := %namer%x2
		tmpoY2A := %namer%y2
		tmpoX2 := tmpoX2A - tmpoX1
		tmpoY2 := tmpoY2A - tmpoY1
		GuiControl,,Botittext,%Name%
		ImgFileName := "img\" Name Colors ".png"
	}
	
	else
	{
		
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		%namer%x1 := BotitiniXYtmp[1]-5
		%namer%y1 := BotitiniXYtmp[2]-5
		%namer%x2 := BotitiniXYtmp[3]+5
		%namer%y2 := BotitiniXYtmp[4]+5
		GuiControl,,Botittext,%Name%
		ImgFileName := "img\" Name Colors ".png"
	}
	
	IfnotExist, %ImgFileName%
	{
		return
	}
	
	;pre set clean for scanner
	
	Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
	
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	Gdip_Shutdown(pToken)
	;***
	
	;Start Gdip
	a:=A_tickcount
	If !pToken := Gdip_Startup()
	{
		MsgBox, Missing Gdip error! 
		ExitApp
	}
	
	QPX( True )
	;**
	if (Mode = "area")
	{
		;msgbox,area
		pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  )) ;user grabbed mirror/window name
		pBitmapBotitHay := Gdip_CropImage(pBitmapBotitHay, tmpoX1, tmpoY1, tmpoX2, tmpoY2)
		;pBitmapBotitHay := Gdip_BitmapFromHWNDCropped(hWnd, tmpoX1 "|" tmpoY1 "|" tmpoX2 "|" tmpoY2)
		
	}
	else
	{
		;msgbox, %targetwindow%
		pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  )) ;user grabbed mirror/window name
		
	}
	;Neddle and Hay from target window and picked image
	pBitmapBotitN := Gdip_CreateBitmapFromFile(ImgFileName) ;user image
	Width := Gdip_GetImageWidth(pBitmapBotitHay), Height := Gdip_GetImageHeight(pBitmapBotitHay)
	pBitmap := Gdip_CreateBitmap(Width,height)
	BotitG := Gdip_GraphicsFromImage(pBitmap)
	;***
	
	if (Colors = "G")
	{	
	;///grayscale
		;msgbox,gray
		Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
	;///
	}
	
	
	;Scanner Modes
	Gdip_DrawImage(BotitG, pBitmapBotitHay, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
	if (Mode = "Single")
	{
		;msgbox,Single
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,0,0,0,0,Diff,0,1,1)
	}
	
	if (Mode = "Area")
	{
		WinGetPos,areatmpx,areatmpy,areatmpw,areatmph,%targetwindow%
		
		if (tmpoX1 < 0)
		{
			limeterX1 := 0
		}
		else
		{
			limeterX1 := 0
		}
		if (tmpoY1 < 0)
		{
			limeterY1 := 0
		}
		else
		{
			limeterY1 := 0
		}
		if (tmpoX2 > areatmpw)
		{
			limeterX2 := areatmpw
		}
		else
		{
			limeterX2 := tmpoX2
		}
		if (tmpoY2 > areatmph)
		{
			limeterY2 := areatmph
		}
		else
		{
			limeterY2 := tmpoY2
		}
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,%limeterX1%,%limeterY1%,%limeterX2%,%limeterY2%,diff,0,1,1)
	}
	
	if (Mode = "Multi")
	{
		
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,ImgArray,0,0,0,0,Diff,0,1,0)
	}
	;****
	
	;image size for Calcs
	canterx:= Gdip_GetImageWidth( pBitmapBotitN )
	cantery:= Gdip_GetImageHeight( pBitmapBotitN )
	;
	
	
	;Clean UP
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	pBitmap :=""
	BotitG :=""
	
	Gdip_Shutdown(pToken)
	;***
	
	;Results Handler
	
	if (result) 
	{  
		if (Mode = "Area")
		{
			StringSplit, LISTArray, LIST, `,  
			truex:=LISTArray1 + tmpoX1
			truey:=LISTArray2 + tmpoY1
			
		}
		
		else
		{
			StringSplit, LISTArray, LIST, `,  
			truex:=LISTArray1 
			truey:=LISTArray2
			
		}
		
		;canterx /= 2  ;click on center
		;cantery /= 2  ;click on center
		;truex:= truex + canterx  ;click on center
		;truey:= truey + cantery  ;click on center
		
		;Random area Inside Found Image Calc
		random,Xrnd,1,canterx ;click on Random inside image W size
		random,Yrnd,1,cantery ;click on Random inside image H size
		truex:= truex + Xrnd
		truey:= truey + Yrnd
		
		if (Mode = "Multi")
		{
			
			if (result > 0) 
			{
				imgtrack := 0
				GuiControl,,Botittext2,Detected %Name%: %result% Times
				_ArrayX := Object()
				_ArrayY := Object()
				
				loop,parse,IMGArray,`n
				{
					
					imgtrack := imgtrack+1
					StringSplit,PointBot,A_LoopField,`,
					_ArrayX.Insert(PointBot1)
					_ArrayY.Insert(PointBot2)
					truex := PointBot1
					truey := PointBot2
					
					
					If (Clicks = 0)
					{
						
						global truex2:=truex
						global truey2:=truey
						return result
						
					}
					
					
					If (Clicks = 1)
					{
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							Sleep, %SleepAmount%
							
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							Sleep, %SleepAmount%
							
						}
						
					}
					
					
					If (Clicks > 1)
					{
						
						;msgbox,%imgtrack%
						if (Clicks = imgtrack)
						{
							;msgbox,%Clicks%  %imgtrack%
							return
						}
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							Sleep, %SleepAmount%
							
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							Sleep, %SleepAmount%
							
						}
					}
					
				}
				_ArrayX := ""
				_ArrayY := ""
				return result
			}
			
			else
			{
				return false
			}
		}
		
		
		if (result = 1)  ;if image found
		{
			;msgbox,%result%
			GuiControl,, MyProgress, +10	
			;Time Tracker
			Ti :=  QPX( False )
			timea:=(a - A_tickcount)/1000
			GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
			;truex2  truey2 ImgFileName  Ti
			If Clicks = 0
			{
				
				global truex2:=truex
				global truey2:=truey
				return true
				
			}
			
			;msgbox,%Controlchoice%
			If Clicks = 1
			{
				if (Controlchoice = "Auto-Mirror")
				{
					ControlClick2(truex, truey , targetwindow)
					critical,Off
					Sleep, %SleepAmount%
					return true
				}
				
				if (Controlchoice = "HumanMouse")	
				{
					
					WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
					truex:=Gx+truex
					truey:=Gy+truey
					Random, Movernd1, 12, 22
					Random, RandomT, %Vt1%, %Vt2%
					RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
					MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
					critical,Off
					Sleep, %SleepAmount%
					global truex2:=truex
					global truey2:=truey
					return true
				}
				
				if (Controlchoice = "PC/Emulator")	
				{
					
					ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
					;msgbox,1
					critical,Off
					;msgbox,  %SleepAmount%
					Sleep, %SleepAmount%
					;msgbox,2
					
					return true
				}
				
			}
		}
		
		
		return
	}
	else ;if image Not found
	{
		
		critical,Off
		Ti :=  QPX( False )
		timea:=(a - A_tickcount)/1000
		return false
	}
	
	Critical Off
}
		

;BotItPixel(xget,yget,w,h,mode,tol,neutron)
BotItPixel(name,tol,mode,click)
{
	;msgbox, %name%   %tol%   %mode%   %click%    %color%   %targetwindow%
	IniRead,INItoDDLsplit,Botit ini\Botit.ini,Botit Calls,%name%
	BotitiniXYtmp3:=StrSplit(INItoDDLsplit,"|")
	color := BotitiniXYtmp3[5]
	;msgbox,%color%
	if (runningstate = 2)
	{
		
			return
	}
	;pre set clean for scanner
	Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(ARGB)
	ret :=""
	Compi :=""
	Gdip_Shutdown(pToken)
	;***
	
	;Start Gdip
	a:=A_tickcount
	If !pToken := Gdip_Startup()
	{
		MsgBox, Missing Gdip error! 
		ExitApp
	}
	QPX( True )
	
	WinGet, hwnd, ID, %targetwindow%
	bmpHaystack := Gdip_BitmapFromScreen("hwnd:" hwnd)

	;msgbox, %name%   %tol%  %mode%   %click%   %color% 
	
	;pixel detect
	if (mode = "single")
	{
		
		
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		xget := BotitiniXYtmp[1]
		yget := BotitiniXYtmp[2]
		

		ARGB := GDIP_GetPixel(bmpHaystack, xget, yget)
		ret := ARGBtoRGB(ARGB)
		Compi := COMPARE(ret, color)
		if ( Compi > tol)
		{
			Ti :=  QPX( False )
			timea:=(a - A_tickcount)/1000
			;Clean UP
			Gdip_DisposeImage(bmpHaystack)
			Gdip_DisposeImage(ARGB)
			ret :=""
			Compi :=""
			Gdip_Shutdown(pToken)
			;***
			;msgbox,%tol%  not found Time:%Ti%
			Return False
		}
		Else
		{
			If Click = 0
			{
				
				global truex2:=xget
				global truex2:=yget
				Ti :=  QPX( False )
				critical,Off
				timea:=(a - A_tickcount)/1000
				;Clean UP
				Gdip_DisposeImage(bmpHaystack)
				Gdip_DisposeImage(ARGB)
				ret :=""
				Compi :=""
				Gdip_Shutdown(pToken)
				GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
				;neutronjswrap("statustext","innerHTML","Found " name  " Scan Time:" Ti,neutron)
				sleep,10
				return true
				
			}
			
			
			If Click = 1
			{
				
				random,Xrnd,0,6 ;click on Random inside image W size
				random,Yrnd,0,6 ;click on Random inside image H size
				truex:= xget + Xrnd
				truey:= yget + Yrnd



				if (Controlchoice = "Auto-Mirror")
				{
					ControlClick2(truex, truey , targetwindow)
					
					Ti :=  QPX( False )
					GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
					critical,Off
					timea:=(a - A_tickcount)/1000
					;Clean UP
					Gdip_DisposeImage(bmpHaystack)
					Gdip_DisposeImage(ARGB)
					ret :=""
					Compi :=""
					Gdip_Shutdown(pToken)
					Sleep, %SleepAmount%
					;neutronjswrap("statustext","innerHTML","Found " name "Scan Time:" Ti,neutron)
					return true
				}
				
				if (Controlchoice = "HumanMouse")	
				{
					Ti :=  QPX( False )
					GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
					WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
					truex:=Gx+truex
					truey:=Gy+truey
					Random, Movernd1, 12, 22
					Random, RandomT, %Vt1%, %Vt2%
					RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
					MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
					critical,Off
					Sleep, %SleepAmount%
					global truex2:=truex
					global truey2:=truey
					return true
				}
				
				if (Controlchoice = "PC/Emulator")	
				{
					global truex2:=truex
					global truey2:=truey
					ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
					Ti :=  QPX( False )
					critical,Off
					GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
					timea:=(a - A_tickcount)/1000
					;Clean UP
					Gdip_DisposeImage(bmpHaystack)
					Gdip_DisposeImage(ARGB)
					ret :=""
					Compi :=""
					Gdip_Shutdown(pToken)
					;neutronjswrap("statustext","innerHTML","Found " name "Scan Time:" Ti,neutron)
					Sleep, %SleepAmount%
					return true
				}
				
			}
			
		}
	}

	if (mode = "Area")
	{
		
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		xget := BotitiniXYtmp[1]
		yget := BotitiniXYtmp[2]
		w := BotitiniXYtmp[3] - xget
		h := BotitiniXYtmp[4] - yget
		
		
		;w := w-xget
		;h:= h-yget
		;xgettmp := xget
		;ygettmp := yget
		;msgbox ,X %xget% Y %yget% W %w%  H %h% 
		loop,%h%
		{
			if (A_Index = 1)
			{
				ygettmp := yget
			}
			Else
			{
				ygettmp := ygettmp+1
			}
			
			;msgbox,%ygettmp%   %yget%
			loop,%w%
			{
				if (A_Index = 1)
				{
					xgettmp := xget
				}
				Else
				{
					
					xgettmp := xgettmp+1
				}
				;xgettmp := xget+A_Index
				ARGB := GDIP_GetPixel(bmpHaystack, xgettmp, ygettmp)
				ret := ARGBtoRGB(ARGB)
				;msgbox, ret %ret%  color %color%
				Compi := COMPARE(ret, color)
				if ( Compi > tol)
				{
					;msgbox,%tol% vs %Compi%  not found X %xgettmp%   Y %ygettmp%
					Continue
					
				}
				
				if Compi is space
				{
					Continue
				}
				;msgbox,%tol% vs %Compi%  found X %xgettmp%   Y %ygettmp%  ret %ret%  color %color%
				;Else
				;{
				;	msgbox,%tol% vs %Compi%
					If (Click = 0)
					{
					;	msgbox,%tol% vs %Compi%  found X %xgettmp%   Y %ygettmp%  ret %ret%  color %color%
						global truex2:=xgettmp
						global truey2:=ygettmp
						Ti :=  QPX( False )
						critical,Off
						timea:=(a - A_tickcount)/1000
						;Clean UP
						Gdip_DisposeImage(bmpHaystack)
						Gdip_DisposeImage(ARGB)
						ret :=""
						Compi :=""
						Gdip_Shutdown(pToken)
						GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
						;neutronjswrap("statustext","innerHTML","Found " name  " Scan Time:" Ti,neutron)
						sleep,10
						return true
						
					}
					
					
					If (Click = 1)
					{
						;msgbox,click
						random,Xrnd,0,6 ;click on Random inside image W size
						random,Yrnd,0,6 ;click on Random inside image H size
						truex:= xgettmp + Xrnd
						truey:= ygettmp + Yrnd



						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							global truex2:=truex
							global truey2:=truey
							Ti :=  QPX( False )
							critical,Off
							GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
							timea:=(a - A_tickcount)/1000
							;Clean UP
							Gdip_DisposeImage(bmpHaystack)
							Gdip_DisposeImage(ARGB)
							ret :=""
							Compi :=""
							Gdip_Shutdown(pToken)
							Sleep, %SleepAmount%
							;neutronjswrap("statustext","innerHTML","Found " name "Scan Time:" Ti,neutron)
							return true
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							Ti :=  QPX( False )
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							critical,Off
							GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							return true
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							Ti :=  QPX( False )
							critical,Off
							GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
							timea:=(a - A_tickcount)/1000
							;Clean UP
							Gdip_DisposeImage(bmpHaystack)
							Gdip_DisposeImage(ARGB)
							ret :=""
							Compi :=""
							global truex2:=truex
							global truey2:=truey
							Gdip_Shutdown(pToken)
							;neutronjswrap("statustext","innerHTML","Found " name "Scan Time:" Ti,neutron)
							Sleep, %SleepAmount%
							return true
						}
						
					}
					
					
				;}
				
			}
		}
			

		
	}
	Return False
	
}



;scan all images inside img/Random/ folder and match them to the target
BotItFolderScanner(Diff,Colors) ; Diff 1-245 | Colors C/G  *full color and grayscale
{
	
	Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
	If (Colors = "G")
	{	
		Loop, Files, img\Random\Botitrnd*G.png
		{
			IfExist, %A_LoopFileFullPath%
			{
				Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
				ImgFileName := A_LoopFileFullPath
				
				
				a:=A_tickcount
				If !pToken := Gdip_Startup()
				{
					MsgBox, Missing Gdip error! 
					ExitApp
				}
				
				QPX( True )
				pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  )) ;user grabbed mirror/window name
				pBitmapBotitN := Gdip_CreateBitmapFromFile(ImgFileName) ;user image
				Width := Gdip_GetImageWidth(pBitmapBotitHay), Height := Gdip_GetImageHeight(pBitmapBotitHay)
				pBitmap := Gdip_CreateBitmap(Width,height)
				BotitG := Gdip_GraphicsFromImage(pBitmap)
				
				Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
				Gdip_DrawImage(BotitG, pBitmapBotitHay, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
				
				result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,0,0,0,0,Diff,0,1,1)
				
				
				;image size for Calcs
				canterx:= Gdip_GetImageWidth( pBitmapBotitN )
				cantery:= Gdip_GetImageHeight( pBitmapBotitN )
				
				
				Gdip_DisposeImage(pBitmap)
				Gdip_DeleteGraphics(BotitG)
				Gdip_DisposeImage(pBitmapBotitHay)
				Gdip_DisposeImage(pBitmapBotitN)
				pBitmapBotitHay :=""
				pBitmapBotitN :=""
				Gdip_Shutdown(pToken)
				
				if (result) 
				{  
					
					StringSplit, LISTArray, LIST, `,  
					truex:=LISTArray1 
					truey:=LISTArray2
					random,Xrnd,0,canterx ;click on Random inside image W size
					random,Yrnd,0,cantery ;click on Random inside image H size
					truex:= truex + Xrnd
					truey:= truey + Yrnd
					
					if (result = 1) 
					{
						
						GuiControl,, MyProgress, +10	
						Ti :=  QPX( False )
						timea:=(a - A_tickcount)/1000
						GuiControl,1:,Botittext2,Found %ImgFileName% Scan Time:%Ti%
						
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							critical,Off
							Sleep, %SleepAmount%
							;SetTimer,RandomTicker,On
							Continue
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							msgbox, x%truex% y%truey%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							critical,Off
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							;SetTimer,RandomTicker,On
							Continue
							;return true
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							critical,Off
							Sleep, %SleepAmount%
							;SetTimer,RandomTicker,On
							Continue
						}
						
						
					}
					
					
				}
				else ;if image Not found
				{
					
					critical,Off
					Ti :=  QPX( False )
					timea:=(a - A_tickcount)/1000
					
				}
				
				Sleep, 50
			}

			Else
			{
				Return
			}
		}
	}
	
	If (Colors = "C")
	{	
		Loop, Files, img\Random\Botitrnd*C.png
		{
			IfExist, %A_LoopFileFullPath%
			{
				Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
				ImgFileName := A_LoopFileFullPath
				;ImgFileName = %ImgFileName%
				;ImgFileName := A_LoopFileFullPath
				
				a:=A_tickcount
				If !pToken := Gdip_Startup()
				{
					MsgBox, Missing Gdip error! 
					ExitApp
				}
				
				QPX( True )
				pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  )) ;user grabbed mirror/window name
				pBitmapBotitN := Gdip_CreateBitmapFromFile(ImgFileName) ;user image
				Width := Gdip_GetImageWidth(pBitmapBotitHay), Height := Gdip_GetImageHeight(pBitmapBotitHay)
				pBitmap := Gdip_CreateBitmap(Width,height)
				BotitG := Gdip_GraphicsFromImage(pBitmap)
				
			 	;Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
				Gdip_DrawImage(BotitG, pBitmapBotitHay, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
				
				result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,0,0,0,0,70,0,1,1)
				
				
				;image size for Calcs
				canterx:= Gdip_GetImageWidth( pBitmapBotitN )
				cantery:= Gdip_GetImageHeight( pBitmapBotitN )
				
				
				Gdip_DisposeImage(pBitmap)
				Gdip_DeleteGraphics(BotitG)
				Gdip_DisposeImage(pBitmapBotitHay)
				Gdip_DisposeImage(pBitmapBotitN)
				pBitmapBotitHay :=""
				pBitmapBotitN :=""
				Gdip_Shutdown(pToken)
				
				if (result) 
				{  
					
					StringSplit, LISTArray, LIST, `,  
					truex:=LISTArray1 
					truey:=LISTArray2
					random,Xrnd,0,canterx ;click on Random inside image W size
					random,Yrnd,0,cantery ;click on Random inside image H size
					truex:= truex + Xrnd
					truey:= truey + Yrnd
					
					if (result = 1) 
					{
						
						GuiControl,, MyProgress, +10	
						Ti :=  QPX( False )
						timea:=(a - A_tickcount)/1000
						GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
						
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							critical,Off
							Sleep, %SleepAmount%
							;SetTimer,RandomTicker,On
							Continue
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							critical,Off
							Sleep, %SleepAmount%
							;SetTimer,RandomTicker,On
							global truex2:=truex
							global truey2:=truey
							Continue
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							critical,Off
							Sleep, %SleepAmount%
							;SetTimer,RandomTicker,On
							Continue
						}
						
						
					}
					
					
				}
				else ;if image Not found
				{
					
					Ti :=  QPX( False )
					timea:=(a - A_tickcount)/1000
					
				}
				
				Sleep, 50
			}

			Else
			{
				Return
			}
		}
	}
}



;Test hWnd Cut
ImageSearch_hWndCut(BotitName)
{
	
	a:=A_tickcount
	If !pToken := Gdip_Startup()
	{
		MsgBox, Missing Gdip error! 
		ExitApp
	}
	QPX( True )
	
	IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%BotitName%
	namer := "Botitini" BotitName
	BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
	%namer%x1 := BotitiniXYtmp[1]-5
	%namer%y1 := BotitiniXYtmp[2]-5
	%namer%x2 := BotitiniXYtmp[3]+5
	%namer%y2 := BotitiniXYtmp[4]+5
	tmpoX1 := %namer%x1
	tmpoY1 := %namer%y1
	tmpoX2 := %namer%x2
	tmpoY2 := %namer%y2
	tmpoX2 := tmpoX2 - tmpoX1
	tmpoY2 := tmpoY2 - tmpoY1
	
	WinGet, hWnd,ID,%targetwindow%
	pBitmap := Gdip_BitmapFromHWNDCropped(hWnd, tmpoX1 "|" tmpoY1 "|" tmpoX2 "|" tmpoY2)
	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	
	
	
	Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
	
	Gdip_Shutdown(pToken)
	
	
}


BotItScannertest(Name,Diff,Mode,Colors,Clicks,title)
{
	
	;msgbox, %Name%  %Diff%   %Mode%   %Colors%  %Clicks%
	if (Mode = "area")
	{
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		%namer%x1 := BotitiniXYtmp[1]-10
		%namer%y1 := BotitiniXYtmp[2]-10
		%namer%x2 := BotitiniXYtmp[3]+10
		%namer%y2 := BotitiniXYtmp[4]+10
		tmpoX1 := %namer%x1
		tmpoY1 := %namer%y1
		tmpoX2A := %namer%x2
		tmpoY2A := %namer%y2
		tmpoX2 := tmpoX2A - tmpoX1
		tmpoY2 := tmpoY2A - tmpoY1
		GuiControl,,Botittext,%Name%
		ImgFileName := "img\" Name Colors ".png"
	}
	
	else
	{
		IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%Name%
		namer := "Botitini" Name
		BotitiniXYtmp:=StrSplit(BotitiniXY,"|")
		%namer%x1 := BotitiniXYtmp[1]-5
		%namer%y1 := BotitiniXYtmp[2]-5
		%namer%x2 := BotitiniXYtmp[3]+5
		%namer%y2 := BotitiniXYtmp[4]+5
		GuiControl,,Botittext,%Name%
		ImgFileName := "img\" Name Colors ".png"
	}
	
	IfnotExist, %ImgFileName%
	{
		return
	}
	
	;pre set clean for scanner
	Random, SleepAmount, %SleepAmountC%, %SleepAmountD%
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	Gdip_Shutdown(pToken)
	;***
	
	;Start Gdip
	a:=A_tickcount
	If !pToken := Gdip_Startup()
	{
		MsgBox, Missing Gdip error! 
		ExitApp
	}
	
	QPX( True )
	;**
	if (Mode = "area")
	{
		
		pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" title ""  )) ;user grabbed mirror/window name
		pBitmapBotitHay := Gdip_CropImage(pBitmapBotitHay, tmpoX1, tmpoY1, tmpoX2, tmpoY2)
		;pBitmapBotitHay := Gdip_BitmapFromHWNDCropped(hWnd, tmpoX1 "|" tmpoY1 "|" tmpoX2 "|" tmpoY2)
		
	}
	else
	{
		;msgbox, %title%
		pBitmapBotitHay := Gdip_BitmapFromHWND(hwnd := WinExist("" title ""  )) ;user grabbed mirror/window name
		
	}
	;Neddle and Hay from target window and picked image
	pBitmapBotitN := Gdip_CreateBitmapFromFile(ImgFileName) ;user image
	Width := Gdip_GetImageWidth(pBitmapBotitHay), Height := Gdip_GetImageHeight(pBitmapBotitHay)
	pBitmap := Gdip_CreateBitmap(Width,height)
	BotitG := Gdip_GraphicsFromImage(pBitmap)
	;***
	
	if (Colors = "G")
	{	
	;///grayscale
		;msgbox,gray
		Matrix = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
	;///
	}
	
	
	;Scanner Modes
	Gdip_DrawImage(BotitG, pBitmapBotitHay, 0, 0, Width, Height, 0, 0, Width, Height, Matrix)
	if (Mode = "Single")
	{
		;msgbox,Single
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,0,0,0,0,Diff,0,1,1)
	}
	
	if (Mode = "Area")
	{
		WinGetPos,areatmpx,areatmpy,areatmpw,areatmph,%targetwindow%
		
		if (tmpoX1 < 0)
		{
			limeterX1 := 0
		}
		else
		{
			limeterX1 := 0
		}
		if (tmpoY1 < 0)
		{
			limeterY1 := 0
		}
		else
		{
			limeterY1 := 0
		}
		if (tmpoX2 > areatmpw)
		{
			limeterX2 := areatmpw
		}
		else
		{
			limeterX2 := 0
		}
		if (tmpoY2 > areatmph)
		{
			limeterY2 := areatmph
		}
		else
		{
			limeterY2 := 0
		}
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,List,%limeterX1%,%limeterY1%,%limeterX2%,%limeterY2%,diff,0,1,1)
	}
	
	if (Mode = "Multi")
	{
		
		result:= Gdip_ImageSearch(pBitmap,pBitmapBotitN,ImgArray,0,0,0,0,Diff,0,1,0)
	}
	;****
	
	;image size for Calcs
	canterx:= Gdip_GetImageWidth( pBitmapBotitN )
	cantery:= Gdip_GetImageHeight( pBitmapBotitN )
	;
	
	
	;Clean UP
	Gdip_DisposeImage(pBitmap)
	Gdip_DeleteGraphics(BotitG)
	Gdip_DisposeImage(pBitmapBotitHay)
	Gdip_DisposeImage(pBitmapBotitN)
	pBitmapBotitHay :=""
	pBitmapBotitN :=""
	pBitmap :=""
	BotitG :=""
	
	Gdip_Shutdown(pToken)
	;***
	
	;Results Handler
	
	if (result) 
	{  
		
		
		
		if (Mode = "Area")
		{
			StringSplit, LISTArray, LIST, `,  
			truex:=LISTArray1 + tmpoX1
			truey:=LISTArray2 + tmpoY1
			
		}
		
		else
		{
			StringSplit, LISTArray, LIST, `,  
			truex:=LISTArray1 
			truey:=LISTArray2
			
		}
		
		;canterx /= 2  ;click on center
		;cantery /= 2  ;click on center
		;truex:= truex + canterx  ;click on center
		;truey:= truey + cantery  ;click on center
		
		;Random area Inside Found Image Calc
		random,Xrnd,1,canterx ;click on Random inside image W size
		random,Yrnd,1,cantery ;click on Random inside image H size
		truex:= truex + Xrnd
		truey:= truey + Yrnd
		
		if (Mode = "Multi")
		{
			
			if (result > 0) 
			{
				imgtrack := 0
				GuiControl,,Botittext2,Detected %Name%: %result% Times
				_ArrayX := Object()
				_ArrayY := Object()
				
				loop,parse,IMGArray,`n
				{
					
					imgtrack := imgtrack+1
					StringSplit,PointBot,A_LoopField,`,
					_ArrayX.Insert(PointBot1)
					_ArrayY.Insert(PointBot2)
					truex := PointBot1
					truey := PointBot2
					
					
					If (Clicks = 0)
					{
						
						global truex2:=truex
						global truey2:=truey
						return result
						
					}
					
					
					If (Clicks = 1)
					{
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							Sleep, %SleepAmount%
							
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							Sleep, %SleepAmount%
							
						}
						
					}
					
					
					If (Clicks > 1)
					{
						
						;msgbox,%imgtrack%
						if (Clicks = imgtrack)
						{
							;msgbox,%Clicks%  %imgtrack%
							return
						}
						if (Controlchoice = "Auto-Mirror")
						{
							ControlClick2(truex, truey , targetwindow)
							Sleep, %SleepAmount%
							
						}
						
						if (Controlchoice = "HumanMouse")	
						{
							
							WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
							truex:=Gx+truex
							truey:=Gy+truey
							Random, Movernd1, 12, 22
							Random, RandomT, %Vt1%, %Vt2%
							RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
							MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
							
							Sleep, %SleepAmount%
							global truex2:=truex
							global truey2:=truey
							
						}
						
						if (Controlchoice = "PC/Emulator")	
						{
							ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
							Sleep, %SleepAmount%
							
						}
					}
					
				}
				_ArrayX := ""
				_ArrayY := ""
				return result
			}
			
			else
			{
				return false
			}
		}
		
		
		if (result = 1)  ;if image found
		{
			
			
			GuiControl,, MyProgress, +10	
			;Time Tracker
			Ti :=  QPX( False )
			timea:=(a - A_tickcount)/1000
			GuiControl,,Botittext2,Found %ImgFileName% Scan Time:%Ti%
			;truex2  truey2 ImgFileName  Ti
			If Clicks = 0
			{
				global namer2:=Name
				global Timore:=Ti
				global truex2:=truex
				global truey2:=truey
				;msgbox, %namer2% %Timore%  %truex2%  %truey2%
				critical,Off
				return true
				
			}
			
			
			If Clicks = 1
			{
				
				
				
				global namer2:=Name
				global Timore:=Ti
				global truex2:=truex
				global truey2:=truey
				;msgbox, %truex% %truey%  %targetwindow%
				;ControlClick2(truex, truey , targetwindow)
				;msgbox,click1
				;Sleep, %SleepAmount%
				ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
				;sleep,100
				ControlClick, x%truex% y%truey%, %targetwindow%,,Left,1, NA
				;msgbox,click2
				critical,Off
				return true
				
				
				if (Controlchoice = "HumanMouse")	
				{
					
					WinGetPos,Gx,Gy,Gw,Gh,%targetwindow%
					truex:=Gx+truex
					truey:=Gy+truey
					Random, Movernd1, 12, 22
					Random, RandomT, %Vt1%, %Vt2%
					RandomBezier( 0, 0, truex ,truey,"T"RandomT "RO")
					MouseClick,Left,%truex% ,%truey%,1,%Movernd1%
					critical,Off
					Sleep, %SleepAmount%
					global truex2:=truex
					global truey2:=truey
					return true
				}
				
				
				
			}
		}
		
		
		return
	}
	else ;if image Not found
	{
		
		critical,Off
		Ti :=  QPX( False )
		timea:=(a - A_tickcount)/1000
		return false
	}
	
	Critical Off
}

;Test window Snap
ImageSearch_BotitBGSTest(Title)
{
	
	a:=A_tickcount
	If !pToken := Gdip_Startup()
	{
		MsgBox, Missing Gdip error! 
		ExitApp
	}
	
	QPX( True )
	
	
	
	pBitmap := Gdip_BitmapFromHWND(hwnd := WinExist("" targetwindow ""  ))  ;user grabbed mirror/window name
	;WinGet, hWnd,ID,%Title%
	;pBitmap := Gdip_BitmapFromScreen2("hwnd:" hWnd)
	Gdip_SetBitmapToClipboard(pBitmap)
	Width := Gdip_GetImageWidth(pBitmap), Height := Gdip_GetImageHeight(pBitmap)
	Gdip_SaveBitmapToFile(pBitmap, "Botittest.png")
	Gui,Test: new
	Gui,Test: Add, Pic, border hwndhpic +0x4E w%Width% h%Height%
	Gui,Test: Show,, Test
	Ti :=  QPX( False )
	timea:=(a - A_tickcount)/1000
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	Setimage(hpic,hBitmap)
	msgbox,   time needed=%Ti%      %timea%,progress
	Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
	
	
}

;Time Tracker
QPX( N=0 ) {       ;  Wrapper for  QueryPerformanceCounter()by SKAN  | CD: 06/Dec/2009
		Static F,A,Q,P,X  ;  www.autohotkey.com/forum/viewtopic.php?t=52083 | LM: 10/Dec/2009
		If ( N && !P )
			Return  DllCall("QueryPerformanceFrequency",Int64P,F) + (X:=A:=0)
		+ DllCall("QueryPerformanceCounter",Int64P,P)
		DllCall("QueryPerformanceCounter",Int64P,Q), A:=A+Q-P, P:=Q, X:=X+1
		Return ( N && X=N ) ? (X:=X-1)<<64 : ( N=0 && (R:=A/X/F) ) ? ( R + (A:=P:=X:=0) ) : 1
}

Gdip_CropImage(pBitmap, x, y, w, h)
{
	pBitmap2 := Gdip_CreateBitmap(w, h), G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_DrawImage(G2, pBitmap, 0, 0, w, h, x, y, w, h)
	Gdip_DeleteGraphics(G2)
	return pBitmap2
}

Gdip_BitmapFromHWNDCropped(hwnd, Screen) {
	Raster := ""
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	hhdc := GetDCEx(hwnd, 3)
	S := StrSplit(Screen, "|")
	_x := S[1], _y := S[2], _w := S[3], _h := S[4]
	
	
	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(_w, _h, chdc)
	obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, _w, _h, hhdc, _x, _y, Raster)
	ReleaseDC(hhdc)
	
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}



ControlMouseMove(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="")
{
    static EnumChildFindPointProc=0
    if !EnumChildFindPointProc
        EnumChildFindPointProc := RegisterCallback("EnumChildFindPoint","Fast")
    
    if !(target_window := WinExist(WinTitle, WinText, ExcludeTitle, ExcludeText))
        return false
    if Control
    {
        if Control is integer
            Control_is_hwnd := IsWindowChildOf(Control, target_window)
        
        if Control_is_hwnd
        {
            ; If %Control% specifies a control hwnd, send it the mouse move,
            ; but use coords relative to the window specified by WinTitle.
            ; This can be used to more easily simulate mouse capture.
            control_window := Control
            VarSetCapacity(rect, 16)
            DllCall("GetWindowRect","uint",target_window,"uint",&rect)
            VarSetCapacity(child_rect, 16)
            DllCall("GetWindowRect","uint",control_window,"uint",&child_rect)
            X -= NumGet(child_rect,0,"int") - NumGet(rect,0,"int")
            Y -= NumGet(child_rect,4,"int") - NumGet(rect,4,"int")
        }
        else
            ControlGet, control_window, Hwnd,, %Control%, ahk_id %target_window%
    }
    if (!control_window)
    {
        VarSetCapacity(rect, 16)
        DllCall("GetWindowRect","uint",target_window,"uint",&rect)
        VarSetCapacity(pah, 36, 0)
        NumPut(X + NumGet(rect,0,"int"), pah,0,"int")
        NumPut(Y + NumGet(rect,4,"int"), pah,4,"int")
        DllCall("EnumChildWindows","uint",target_window,"uint",EnumChildFindPointProc,"uint",&pah)
        control_window := NumGet(pah,24) ? NumGet(pah,24) : target_window
        DllCall("ScreenToClient","uint",control_window,"uint",&pah)
        X:=NumGet(pah,0,"int"), Y:=NumGet(pah,4,"int")
    }
    wParam :=  (InStr(Options,"L") ? 0x1 : 0) || (InStr(Options,"M") ? 0x10 : 0) || (InStr(Options,"R") ? 0x2 : 0)
            || (InStr(Options,"X1") ? 0x20 : 0) || (InStr(Options,"X2") ? 0x40 : 0)
            || (InStr(Options,"S") ? 0x4 : 0) || (InStr(Options,"C") ? 0x8 : 0)
            || (InStr(Options,"K") ? (GetKeyState("Shift") ? 0x4:0)|(GetKeyState("Control") ? 0x8:0) : 0)
    PostMessage, 0x200, wParam, (x & 0xFFFF) | ((y & 0xFFFF)<<16),, ahk_id %control_window%
    return control_window
}

IsWindowChildOf(aChild, aParent)
{
    static EnumChildFindHwndProc=0
    if !EnumChildFindHwndProc
        EnumChildFindHwndProc := RegisterCallback("EnumChildFindHwnd","Fast")
    VarSetCapacity(lParam,8,0), NumPut(aChild,lParam,0)
    DllCall("EnumChildWindows","uint",aParent,"uint",EnumChildFindHwndProc,"uint",&lParam)
    return NumGet(lParam,4)
}
EnumChildFindHwnd(aWnd, lParam)
{
    if (aWnd = NumGet(lParam+0))
    {
        NumPut(1, lParam+4)
        return false
    }
    return true
}

;by skrommel
COMPARE(color1,color2)  ; colors in hex format  "0xff8728"
{
  
  Loop,2
  {
    param:=A_Index
    StringTrimLeft,color%param%,color%param%,2
    Loop,3
    {
      StringLeft,c%param%%A_Index%,color%param%,2
      value:=c%param%%A_Index%
      c%param%%A_Index%=0x%value%
      StringTrimLeft,color%param%,color%param%,2
    }
  } 
  difference:=(Abs(c11-c21)+Abs(c12-c22)+Abs(c13-c23))/3
  
  Return difference
}



ConvertARGB(ARGB, Convert := 0)
{
    SetFormat, IntegerFast, Hex
    RGB += ARGB
    RGB := RGB & 0x00FFFFFF
    if (Convert)
        RGB := (RGB & 0xFF000000) | ((RGB & 0xFF0000) >> 16) | (RGB & 0x00FF00) | ((RGB & 0x0000FF) << 16)
    return RGB
}