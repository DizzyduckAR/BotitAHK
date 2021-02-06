FileDelete , BotitCloud.txt
#Include, Core\INIReader.ahk
global first:=1
global Dupe:=0
IniRead, modes, Botit ini\Botit.ini, Botit Modes
FileAppend, Modes`n`n%modes%`n`n, %A_WorkingDir%\BotitCloud.txt

array := []

; Iterate from 1 to the end of the array:

    OutputVar := IniGetKeys("Botit ini\Botit.ini", "Botit Modes","|")
    BotitINItoDDL:=StrSplit(OutputVar,"|")
    ;Loop Picked Mode
    Loop % BotitINItoDDL.MaxIndex()
    {
        looper:= BotitINItoDDL[A_Index]
       ; msgbox, % BotitINItoDDL[A_Index]
        IniRead,INItoDDLsplit,Botit ini\Botit.ini,Botit Modes,%looper%
		BotitiniXYtmp2:=StrSplit(INItoDDLsplit,"|")
		
		Loop % BotitiniXYtmp2.MaxIndex()
        {
            namer := BotitiniXYtmp2[A_Index]
            ;msgbox,%namer%
            if (first=1)
            {
                
                Array.Push(namer)
                first:=0
            }
            ;Array.Push(namer)
          ;  msgbox, % namer
            Loop % array.Length()
            {
                
                if (array[A_Index] = namer)
                {
                    ;MsgBox,  dupe name %namer%
                    Dupe:=1
                    break
                }
                
                
                
            }
            if (Dupe=0)
            {
                Array.Push(namer)
            }
            Dupe:=0
            ;msgbox, % BotitiniXYtmp2[A_Index]
        }
        
       
        ; if (array[A_Index] = "test")
        ; {
        ;     MsgBox,dupe
        ; }

        ; MsgBox % array[A_Index]
    }
    
     Loop % array.Length()
        {
            ;msgbox,list
            KeyName2:=array[A_Index]

            IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
            typechk:=StrSplit(typechk,"|")
            typeOBJ:=typechk[1]
            if (typeOBJ="Func")
            {
                ;Array.RemoveAt(A_Index)
                Loop % typechk.MaxIndex()
                {
                    if (typechk[A_Index]="Func")
                    {
                        Continue
                    }
                    funcbtnremove:= typechk[A_Index]
                    
                    Loop % array.Length()
                    {
                        ;MsgBox % array[A_Index]
                        if (array[A_Index] = funcbtnremove)
                        {
                            ;MsgBox,  dupe name %funcbtnremove%
                            Dupe:=1
                            break
                        }
                        
                        
                        
                    }
                    if (Dupe=0)
                    {
                        Array.Push(funcbtnremove)
                    }
                    Dupe:=0
                ;msgbox,%funcbtnremove%
                ;GuiControl,Hide ,%funcbtnremove%
                }
            } 
            ; Else
            ; {
            ;     msgbox, not func
            ; }
            ;MsgBox % array[A_Index]
            
            
        }

        ;msgbox,done
        FileRemoveDir, tmp,1

        sleep,50
        FileCreateDir,tmp
        Loop % array.Length()
        {
            
            ;MsgBox % array[A_Index]
            KeyName2:=array[A_Index]

            IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
            typechk:=StrSplit(typechk,"|")
            typeOBJ:=typechk[1]
            if (typeOBJ="Image")
            {
                ;msgbox, % typechk[4]
                colorset:=typechk[4]
                IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
                IniWrite, %typechk%, tmp\build.ini,Botit Call, %KeyName2%

                IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%KeyName2%
                IniWrite, %BotitiniXY%, tmp\build.ini,Botit XY, %KeyName2%
                
                ;msgbox, %colorset%
                File := "img\" KeyName2 colorset ".png"
                ;msgbox,%File%
                FileGetSize, nBytes, %File%
                FileRead, Bin, *c %File%
                B64Data := Base64imgEnc( Bin, nBytes, 100, 2 )
                StringReplace, B64Data,B64Data, `r,, All
                StringReplace, B64Data,B64Data, `n,, All
                StringReplace, B64Data,B64Data, `r,, All
                StringReplace, B64Data,B64Data, `n,, All
                data = "%KeyName2%G": " %B64Data% " ,
                
                FileAppend,%data%`n, tmp\imgEnc.txt

            }
            if (typeOBJ="Func")
            {
                ;msgbox, %KeyName2% Func 
                IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
                IniWrite, %typechk%, tmp/build.ini,Botit Call, %KeyName2%
                ;IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%KeyName2%
                ;IniWrite, %BotitiniXY%, tmp\build.ini,Botit XY, %KeyName2%
            }

            if (typeOBJ="Pixel")
            {
                ;msgbox, %KeyName2% Pixel
                IniRead,typechk,Botit ini\Botit.ini,Botit Calls,%KeyName2%
                IniWrite, %typechk%, tmp/build.ini,Botit Call, %KeyName2%

                IniRead,BotitiniXY,Botit ini\ImageXY.ini,Botit XY,%KeyName2%
                IniWrite, %BotitiniXY%, tmp\build.ini,Botit XY, %KeyName2%
            }
        }

        IniRead, calls, tmp\build.ini, Botit Call
        FileAppend, Botit Call`n`n%calls%`n`n, %A_WorkingDir%\BotitCloud.txt

        IniRead, imgxy, tmp\build.ini, Botit XY
        FileAppend, Image XY`n`n%imgxy%`n`n, %A_WorkingDir%\BotitCloud.txt

        FileRead, Out2, Botit Functions\func.ahk
        StringReplace, Out2, Out2, (), (neutron), All
        rep1:="0)"
        rep2:="0,neutron)"
        StringReplace, Out2, Out2,%rep1% ,%rep2% , All
        rep1:="1)"
        rep2:="1,neutron)"
        StringReplace, Out2, Out2,%rep1% ,%rep2%, All
        FileAppend,Botit Functions`n`n%Out2%`n`n, %A_WorkingDir%\BotitCloud.txt

        FileRead, Out2, tmp\imgEnc.txt
        FileAppend,Botit Images`n`n%Out2%`n`n, %A_WorkingDir%\BotitCloud.txt

        FileRemoveDir, tmp,1

        msgbox,Exporting Done `nBotitCloud.txt was created on root
exitapp




Base64imgEnc( ByRef Bin, nBytes, LineLength := 64, LeadingSpaces := 0 ) 
{ ; By SKAN / 18-Aug-2017
	Local Rqd := 0, B64, B := "", N := 0 - LineLength + 1  ; CRYPT_STRING_BASE64 := 0x1
	DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin ,"UInt",nBytes, "UInt",0x1, "Ptr",0,   "UIntP",Rqd )
	VarSetCapacity( B64, Rqd * ( A_Isunicode ? 2 : 1 ), 0 )
	DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin, "UInt",nBytes, "UInt",0x1, "Str",B64, "UIntP",Rqd )
	If ( LineLength = 64 and ! LeadingSpaces )
		Return B64
	B64 := StrReplace( B64, "`r`n" )        
	Loop % Ceil( StrLen(B64) / LineLength )
		B .= Format("{1:" LeadingSpaces "s}","" ) . SubStr( B64, N += LineLength, LineLength ) . "`n" 
	Return RTrim( B,"`n" )    
}