#include *i %A_ScriptDir%\Botit Functions\Minions	; make it so all includes will automatically look in this folder
	#include *i %A_ScriptDir%\Botit Functions\dynamicFunc.ahk ; the autoexec section of all plugins (the part above the first return in each plugin)
	#include *i %A_ScriptDir%\Botit Functions\Bundler.ahk ; the rest of the contents of the plugins (the part below the first return in each plugin)	
;Return
Plugins:
	FileRead, plugins_old , %A_ScriptDir%\Botit Functions\Bundler.ahk ; for comparison later on
    ;msgbox,%plugins_old%
	FileDelete %A_ScriptDir%\Botit Functions\dynamicFunc.ahk ; this file will contain the autoexecute lines (before the first "return" in the file(s))
	FileDelete %A_ScriptDir%\Botit Functions\Bundler.ahk ; this file will contain the rest of the files of the plugins
	loop, %A_ScriptDir%\Botit Functions\Minions\*.ahk ; collect all relevant plugins
	{
		autoexec_end = 0 ; this var is to determine if the end of autoexec has been reached
		; collect the autoexec section of the file (until the first "return")
		FileRead, file_plugin, %A_LoopFileLongPath%
		loop, parse, file_plugin, `n	; parse the current plugin, line by line
		{
			if autoexec_end = 0 ; the end may not be near
			{
				if A_LoopField contains return
				{
					FileAppend, %autoexec%`n, %A_ScriptDir%\Botit Functions\dynamicFunc.ahk
					autoexec_end = 1 ; the end has been found
				}
				else
				{
					if A_Index = 1
						autoexec = `n`n%A_LoopField%
					else
						autoexec = %autoexec%`n%A_LoopField%
				}
			}
			else
			{
				if contents =
					contents = %A_LoopField%
				else
					contents = %contents%`n%A_LoopField%
			}
		}
		FileAppend, `n%contents%, %A_ScriptDir%\Botit Functions\Bundler.ahk
		contents := 		; free up some memory
	}
    ;msgbox,%plugins_new%
    ;msgbox,%plugins_old%
	FileRead , plugins_new , %A_ScriptDir%\Botit Functions\Bundler.ahk
	if (plugins_old <> plugins_new)
		reload
	plugins_new :=		; free up some memory
	plugins_old :=		; free up some memory
