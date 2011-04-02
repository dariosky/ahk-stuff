; Some useful AutoHotKey tools
; Dario "dariosky" Varotto

; Windows+Z to toggle mute sounds
#z::
	Send {Volume_Mute}
return

; Windows + mouse wheel to change volume
#WheelUp:: Send {Blind}{Volume_Up}
#WheelDown:: Send {Blind}{Volume_Down}

; Windows+M to lock session and standby the screen ('nircmd' on path required)
#m::
	Send {Blind}#l
	Sleep 1000
	RunWait nircmd.exe monitor off
return

; Windows+O ejects/close the primary cdrom
#o::
	Drive, Eject
	if A_TimeSinceThisHotkey < 1000  ; Adjust this time if needed.
		Drive, Eject,, 1
return

; function to get the current path in explorer windows - c:\ otherwise
OpenCmdInCurrent()
{
	#IfWinActive ahk_class ExploreWClass|CabinetWClass
		WinGetText , full_path, A  ; This is required to get the full path of the file from the address bar
		;msgbox, Da Gettext: %full_path%
		; Split on newline (`n)
		StringSplit, word_array, full_path, `n
		full_path = %word_array1%   ; Take the first element from the array

		; Just in case - remove all carriage returns (`r)
		StringReplace, full_path, full_path, `r, , all
		full_path := RegExReplace(full_path, "^.*: ", "")
		IfInString full_path, \
		{
			return %full_path%
		}
	#IfWinActive
    Return "C:\"
}

; Windows+C open a command prompt in the current path
#c::
	test := OpenCmdInCurrent()
	Run %ComSpec% /K cd /d %test%
return

; Backspace, in Windows 7 act like "to Upper level"
#IfWinActive, ahk_class CabinetWClass
Backspace::
   ControlGet renamestatus,Visible,,Edit1,A
   ControlGetFocus focussed, A
   if(renamestatus!=1&&(focussed="DirectUIHWND3"||focussed="SysTreeView321"))
   {
    SendInput {Alt Down}{Up}{Alt Up}
  }else{
      Send {Backspace}
  }
#IfWinActive
return

; some italian accented chars
;  ALT gr+vowel (for the E key, which is euro sign, we use ALTgr+W)
;  upper and lower case

^+>!a::Send À
^+>!w::Send È
^+>!i::Send Ì
^+>!o::Send Ò
^+>!u::Send Ù

^>!a::Send à
^>!w::Send è
^>!i::Send ì
^>!o::Send ò
^>!u::Send ù
^>!n::Send ñ

; AltGr+0 as tilde
^>!0::Send ~

; Some sometime useful symbol ALT gr+T
^>!t::Send ™
^>!c::Send ©

; some italian "hotstrings"
::cmq::comunque
