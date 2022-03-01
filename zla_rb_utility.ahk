#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; --ZLA Rolling/Boundary Utility v0.2.3--
;       Created by Jeff Schuss
; Last updated 3/1/22 by Jeff Schuss
script_title := "ZLA Rolling/Boundary Utility"
ini := "zla_rbu.ini"

;Scratchpad and Temporary Altitude Entries version 4.10 dtd 4/7/2021 [https://laartcc.org/document/scratchpad-and-temporary-altitude-entries]
sid_only := { BRDR7: "BR" , CATH1: "CT", CHANL3: "CH", CHATY5: "CR", ELB4: "ET", ELMOO9: "EL", FALCC1: "FA", FLOUT5: "FL", GAUCH2: "GH", GIDGT1: "GID", GMN7: "GM", HABUT4: "HB", HAWWC3: "HC", HOOVR7: "HV", IRV5: "IE", JOHKR2: "JKR", KWANG5: "KW", LOHLA2: "LOH", MARIC4: "MR", MEADO4: "ME", MIKAA1: "MA", MISHN3: "MN", MOOOS2: "MO", MUSEL8: "MS", NIITZ2: "NIT", NIKKL1: "NL", OSHNN1: "OS", OYODA2: "OYO", PEBLE6: "PB", POM1: "PM", RADYR2: "RYR", RASLR2: "RAS", RATPK2: "RAT", SBA5: "SB", SCAMR2: "SMR", SEBBY3: "SB", SLI8: "SL", SXC8: "SX", TRM6: "TH", VNY3: "VN", WRING4: "WR", ZZOOO2: "ZO" }
sid_trans := { CWARD2LAX: "CL", CWARD2SLI: "CS", DARRK3DINTY: "DD", DARRK3MCKEY: "DM", DARRK3RIZIN: "DI", DARRK3SCTRR: "DR", DARRK3STOKD: "DS", DOTSS2CLEEE: "DL", DOTSS2CNERY: "DN", ECHHO2IKAYE: "EI", ECHHO2SLI: "ES", FINZZ3BEALE: "FB", FINZZ3HAILO: "FH", FINZZ3LAS: "FL", FINZZ3MISEN: "FM", FINZZ3NNAVY: "FN", GARDY4BEALE: "GB", GARDY4HAILO: "GH", GARDY4LAS: "GL", GARDY4MISEN: "GI", GARDY4NNAVY: "GN", HHERO3EHF: "HE", HHERO3IKAYE: "HI", HHERO3OROSZ: "HO", HOBOW3BEALE: "HB", HOBOW3HAILO: "HH", HOBOW3LAS: "HL", HOBOW3MISEN: "HM", HOBOW3NNAVY: "HN", LADYJ4COREZ: "LO", LADYJ4CSTRO: "LS", LAXX1FICKY: "XF", LAXX1IPL: "XI", LAXX1MZB: "XM", LAXX1OCN: "XO", LAXX1SLI: "XS", LAXX1SXC: "XK", LAXX1TRM: "XT", MCCRN6BTY: "MB", MCCRN6HEC: "MH", MCCRN6TNP: "MT", MMOTO2DINTY: "MD", MMOTO2MALIT: "MM", ORCKA5BEALE: "OB", ORCKA5HAILO: "OH", ORCKA5LAS: "OL", ORCKA5MISEN: "OM", ORCKA5YELAH: "OY", OROSZ2COREZ: "OO", OROSZ2CSTRO: "OS", PADRZ2CHKNN: "PC", PADRZ2DINTY: "PD", PADRZ2EHF: "PE", PADRZ2IKAYE: "PI", PADRZ2MALIT: "PM", PADRZ2OROSZ: "PO", PERCH3DINTY: "PD", PERCH3FICKY: "PF", PIGGN2AVRRY: "PA", PIGGN2CNERY: "PC", PIGGN2OTAYY: "PO", PIGGN2TCATE: "PT", PNDAH2OTAYY: "PO", PNDAH2TCATE: "PT", RAJEE3AVRRY: "RA", RAJEE3DINTY: "RD", RAJEE3MALIT: "RL", RAJEE3MTBAL: "RT", RAJEE3OTAYY: "RO", SAYOW2IPL: "SI", SAYOW2MTBAL: "SM", SKWRL2GMN: "SG", SKWRL2VALEY: "SV", SLAPP2BLH: "SB", SLAPP2HAILO: "SI", SLAPP2HEC: "SE", SLAPP2LAS: "SS", SLAPP2MISEN: "SN", SNSHN5BEALE: "SB", SNSHN5COREZ: "SC", SNSHN5EHF: "SE", SNSHN5HAILO: "SH", SNSHN5LAS: "SL", SNSHN5MISEN: "SM", SNSHN5YELAH: "SY", SUMMR2DINTY: "SD", SUMMR2FICKY: "SF", SUMMR2MCKEY: "SM", SUMMR2RIZIN: "SI", SUMMR2SCTRR: "SR", SUMMR2STOKD: "SS", TRTON2DINTY: "TD", TRTON2FICKY: "TF", TRTON2MCKEY: "TM", TRTON2SCTRR: "TR", TRTON2STOKD: "TS", TUSTI2AVRRY: "TA", TUSTI2CNERY: "TC", TUSTI2OTAYY: "TO", TUSTI2TCATE: "TT", VTU8DINTY: "VD", VTU8RZS: "VR", VTU8VTU: "VV", VVERA2DAG: "VD", VVERA2HEC: "VH", WNNDY3COREZ: "WO", WNNDY3CSTRO: "WS", ZILLI4BEAUT: "ZB", ZILLI4LAUER: "ZL" }

;var init
config := []
id := ""
nn := ""
id2 := ""
nn2 := ""
env := ""
ini_data := []
rwy_ary := []
PDC1 := ""
PDC2 := ""
PDC3 := ""
PDC4 := ""

;custom functions
debug(string) {
	FileAppend %string%, *
}

Join(sep, params*) {
    for index,param in params
        str .= param . sep
    return SubStr(str, 1, -StrLen(sep))
}

;ini reading
IniRead, version, %ini%, :META, Version
script_title := script_title . " " . version
;  default GUI positions (remembers last position)
IniRead, ix, %ini%, :CONFIG, WinX
IniRead, iy, %ini%, :CONFIG, WinY
IniRead, airport_str, %ini% ;this gets all the airports (which are the .ini sections)
airports := StrSplit(airport_str, "`n")
airport_str := ""
for i, airport in airports
{
	if (SubStr(airport, 1, 1) = ":") ;skips any config settings in the .ini file
		Continue
	IniRead, section_txt, %ini%, %airport%
	ini_data[airport] := section_txt
	if (i  > 1)
		airport_str := airport_str . "|"
	airport_str := airport_str . airport
	
}


;main GUI
Gui,main:New, +AlwaysOnTop -MaximizeBox -MinimizeBox +HwndGuiMain, %script_title%
Gui,main:Color, 323232, 1e1e1e
Gui,main:Add, Text, cWhite, Airport:
Gui,main:Add, DDL, cWhite vApt_DDL gApt_DDL_Change HwndApt_DDL_ID, %airport_str% ;these GUI control options are the worst, they set an output variable for DDL value, link a subroutine to the change event, and store the ID (HWND) in another output variable
Gui,main:Add, Text, cWhite x+10 y5 gBox_Change, Controller ID:
Gui,main:Add, Edit, cWhite r1 vCon_Txt gBox_Change
Gui,main:Add, Text, cWhite x10 y+5   , Config:
Gui,main:Add, DDL, cWhite vCfg_DDL gCfg_DDL_Change HwndCfg_DDL_ID, %cfg_str%
Gui,main:Add, Button, xp+130 yp w120 cRed gSetup_Button HwndSetup_Button_ID, Initial &Setup (not ran)
Gui,main:Add, GroupBox, cWhite x135 y95 w245 h170, PDC (Ctrl+Shift+letter)
Gui,main:Add, Text, y110 xp+15 cWhite, Via  Chg       Alt        Preview
Gui,main:Add, Text, y+7 x140 cWhite, q)
Gui,main:Add, Checkbox, Checked yp-2 x153 w20 h20 cWhite vPDCv_Box1 HwndPDCv_Box1_ID gBox_Change
Gui,main:Add, Checkbox, yp+0 x173 w20 h20 cWhite vPDCc_Box1 gBox_Change
Gui,main:Add, Edit, yp+0 x193 w50 h20 cWhite vPDCm_Edit1 HwndPDCm_Edit1_ID gBox_Change
Gui,main:Add, Text, yp+2 x245 cWhite w130 HwndPDC_Preview1_ID
Gui,main:Add, Text, y+10 x140 cWhite, w)
Gui,main:Add, Checkbox, Checked yp-2 x153 w20 h20 cWhite vPDCv_Box2 HwndPDCv_Box2_ID gBox_Change
Gui,main:Add, Checkbox, yp+0 x173 w20 h20 cWhite vPDCc_Box2 gBox_Change
Gui,main:Add, Edit, yp+0 x193 w50 h20 cWhite vPDCm_Edit2 HwndPDCm_Edit2_ID gBox_Change
Gui,main:Add, Text, yp+2 x245 cWhite w130 HwndPDC_Preview2_ID
Gui,main:Add, Text, y+10 x140 cWhite, e)
Gui,main:Add, Checkbox, Checked yp-2 x153 w20 h20 cWhite vPDCv_Box3 HwndPDCv_Box3_ID gBox_Change
Gui,main:Add, Checkbox, yp+0 x173 w20 h20 cWhite vPDCc_Box3 gBox_Change
Gui,main:Add, Edit, yp+0 x193 w50 h20 cWhite vPDCm_Edit3 HwndPDCm_Edit3_ID gBox_Change
Gui,main:Add, Text, yp+2 x245 cWhite w130 HwndPDC_Preview3_ID
Gui,main:Add, Text, y+10 x140 cWhite, r)
Gui,main:Add, Checkbox, Checked yp-2 x153 w20 h20 cWhite vPDCv_Box4 HwndPDCv_Box4_ID gBox_Change
Gui,main:Add, Checkbox, yp+0 x173 w20 h20 cWhite vPDCc_Box4 gBox_Change
Gui,main:Add, Edit, yp+0 x193 w50 h20 cWhite vPDCm_Edit4 HwndPDCm_Edit4_ID gBox_Change
Gui,main:Add, Text, yp+2 x245 cWhite w130 HwndPDC_Preview4_ID
Gui,main:Add, Checkbox, y+10 x140 cWhite vPDCr_Box gBox_Change, Use rwy PDCs? (e`.g: `.pdcvr)
Gui,main:Add, Checkbox, y+10 x140 cWhite vPush_Box gBox_Change, Use push PDCs? (e`.g: `.pushpdcv)
Gui,main:Add, GroupBox, cWhite x5 y95 w125 h170, Runways (Ctrl+Shift+#)
Gui,main:Add, Text, y130 xp+5 cWhite, 1)
Gui,main:Add, Edit, xp+20 yp-3 w80 cWhite r1 vRwy_Edit1 HwndRwy_Edit1_ID
Gui,main:Add, Text, x10 y+5 cWhite, 2)
Gui,main:Add, Edit, xp+20 yp-3 w80 cWhite r1 vRwy_Edit2 HwndRwy_Edit2_ID
Gui,main:Add, Text, x10 y+5 cWhite, 3)
Gui,main:Add, Edit, xp+20 yp-3 w80 cWhite r1 vRwy_Edit3 HwndRwy_Edit3_ID
Gui,main:Add, Text, x10 y+5 cWhite, 4)
Gui,main:Add, Edit, xp+20 yp-3 w80 cWhite r1 vRwy_Edit4 HwndRwy_Edit4_ID
;  initialize PDCs and preview
Gosub, Box_Change
;  init window position if the .ini file has it saved
if ((ix = "ERROR") || (iy = "ERROR")) 
	Gui,main:Show, Center
else 
	Gui,main:Show, x%ix% y%iy%

Apt_DDL_Change:
	Gui, Submit, NoHide ;need to do this to register user input ?!?!?!?!?! I hate this language
	cfg := StrSplit(ini_data[Apt_DDL], "`n")
	cfg_ary := []
	cfg_str := "" 
	for i, c in cfg ;this is so unreadable, but all it does is chain the different configs (keys of the ini file) together with "|" separators for the dropdown list text
	{
		ary := StrSplit(c, "=")
		cfg_ary[ary[1]] := ary[2]
		cfg_str := cfg_str . "|"
		if (i = 2)
			cfg_str := cfg_str . "|" ;this adds a second pipe after the first value which makes it pre-selected as a default
		cfg_str := cfg_str . ary[1]		
	}
	GuiControl, , %Cfg_DDL_ID%, %cfg_str%
	Gosub Cfg_DDL_Change
Return

Cfg_DDL_Change:
	Gui, Submit, NoHide
	rwy_ary := StrSplit(cfg_ary[Cfg_DDL], ",")
	edit_ary := []
	
	txt := ""
	for i in [1,2,3,4]
	{
		edit_id_var = Rwy_Edit%i%_ID
		GuiControl, , % %edit_id_var%, % rwy_ary[i]
	}
	
Return

Box_Change:
	Gui, Submit, NoHide
	Loop, 4 
	{
		i := A_Index
		if (Push_Box = 1)
			txt := ".pushpdc"
		else
			txt := ".pdc"
		if (PDCv_Box%i% = 1)
			txt := txt . "v"
		if (PDCm_Edit%i%)
			txt := txt . "m"
		if (SubStr(txt, -1) = "vm")
			txt := StrReplace(txt, "m", "x")
		if (PDCc_Box%i% = 1)
			txt := txt . "c"
		if !Con_Txt
			txt := txt . "u"
		if (PDCr_Box = 1)
			txt := txt . "r"
		box_check := PDCm_Edit%i% || PDCv_Box%i%
		if !box_check			
			GuiControl, +cRed, % PDC_Preview%i%_ID
		else
			GuiControl, +cWhite , % PDC_Preview%i%_ID
		
		if (Con_Txt = "*")
			txt := txt . " " . PDCm_Edit%i%
		else
			txt := txt . " " . PDCm_Edit%i% . " " . Con_Txt
		if (PDCr_Box = 1)
			txt := txt . " " . Rwy_Edit%i%
		txt := RegExReplace(txt,"\x20{2,}"," ")
		txt := Trim(txt)
		GuiControl, , % PDC_Preview%i%_ID, %txt%
		PDC%i% := txt
		Gui, Submit, NoHide
	}
Return

Setup_Button:
	Gosub, PromptClick1
	MouseGetPos, , , id, nn ;this is why you have to click into the FP Route field. grabs the HWND of the window (id) and the class_nn of the textbox control (nn)
	WinGet, procname, ProcessName, ahk_id %id%
	if InStr(procname, "vSTA")
		env := "VSTARS"
	else if InStr(procname, "vrc")
		env := "VRC"
	else
		env := ""
		
	Gosub, PromptClick2

	if (env = "")
		MsgBox, This script not configured for your radar client`. Errors may occur`.
		
	GuiControl, , %Setup_Button_ID%, Initial &Setup (complete)
	GuiControl, +cGreen , %Setup_Button_ID%
Return

;get window ID and control ID to clipboard (for debug purposes)
;~ ^+g::
	;~ MouseGetPos, , , idg, nng
	;~ ;nng2 := StrReplace(nng, "ad12", "ad18")
	;~ ;ControlGetText, wintitle, %nng2%, ahk_id %idg%
	;~ ;MsgBox, %wintitle%
	;~ clipboard := % idg . " `; " . nng
;~ Return

;Each one of these is one of the runways input during initialization IN ORDER. Hotkey is ctrl+shift+number. I don't think numpad will work
;VRC: Make sure you have the aircraft selected before using these, no need to have FP open. Mouse position is irrelevant
;vSTARS: Make sure you have the aircraft's flight plan open. Mouse position is irrelevant
^+1::
	Gui, main:Submit, NoHide
	rwy := 1
	Gosub, SendBound
Return
^+2::
	Gui, main:Submit, NoHide
	rwy := 2
	Gosub, SendBound
Return
^+3::
	Gui, main:Submit, NoHide
	rwy := 3
	Gosub, SendBound
Return
^+4::
	Gui, main:Submit, NoHide
	rwy := 4
	Gosub, SendBound
Return
^+q::
	Gui, main:Submit, NoHide
	rwy := 1
	Gosub, SendPDC
Return
^+w::
	Gui, main:Submit, NoHide
	rwy := 2
	Gosub, SendPDC
Return
^+e::
	Gui, main:Submit, NoHide
	rwy := 3
	Gosub, SendPDC
Return
^+r::
	Gui, main:Submit, NoHide
	rwy := 4
	Gosub, SendPDC
Return

;the meat and taters:
SendBound:
	if (env = "VRC") { ;this block opens the FP of the selected a/c in VRC... makes life slightly easier for VRC users
		SendInput {F6} 
		Sleep, 100
		SendEvent {NumpadAdd}
	}
	else if (env = "VSTARS") {
		nn3 := StrReplace(nn, "ad12", "ad18") ;this gets the callsign in vSTARS
		ControlGetText, nn3_txt, %nn3%, ahk_id %id%
		ControlSetText, %nn2%, %nn3_txt%, ahk_id %id2% ;this puts the callsign into the vSTARS text box
		ControlFocus, %nn2%, ahk_id %id2%
		Sleep, 100
		Send  {NumpadAdd Down} ;this selects the aircraft
		Sleep, 50
		Send  {NumpadAdd Up}
	}
	ControlGetText, ctrltext, %nn%, ahk_id %id%
	atext := StrSplit(ctrltext, ["."," "])
	sid := atext[1]
	if (sid_only.HasKey(sid))
	{
		scratch := sid_only[sid]
	} else {
		sid := atext[1] . atext[2]
		scratch := sid_trans[sid]
	}	
	rwy_var = Rwy_Edit%rwy%
	cbtext := % ".bound " . Con_Txt . " " . %rwy_var% . " " . scratch 

	ControlSetText, %nn2%, %cbtext%, ahk_id %id2%
	timerfunc := Func("DepReminder").Bind(nn3_txt) ;have to bind the function and parameter to a variable for the timer
	SetTimer, %timerfunc%, -5000
Return

SendPDC:
	if (env = "VSTARS") {
		nn3 := StrReplace(nn, "ad12", "ad18") ;this gets the callsign in vSTARS
		ControlGetText, nn3_txt, %nn3%, ahk_id %id%
		ControlSetText, %nn2%, %nn3_txt%, ahk_id %id2% ;this puts the callsign into the vSTARS text box
		ControlFocus, %nn2%, ahk_id %id2%
		Sleep, 100
		Send  {NumpadAdd Down} ;this selects the aircraft
		Sleep, 50
		Send  {NumpadAdd Up}
	}

	ControlSetText, %nn2%, % PDC%rwy%, ahk_id %id2%

Return

;this subroutine pops up a msg box that terminates once it detects 
PromptClick1:
	Gui,help:Add, Text,     , Left click once in your flight plan window's Route field`.`nDO NOT click anywhere else before`.
	Gui,help:+toolwindow
	Gui,help:Show
	KeyWait, LButton, D
	MouseGetPos, , , id, nn
	KeyWait, LButton, U ;needed to add this to avoid PromptClick2 from registering the first down event
	Gui, help: Destroy
Return

PromptClick2:
	Gui,help:Add, Text,     , Left click once in your client's text entry field (same place as dot commands)`.`nDO NOT click anywhere else before`.
	Gui,help:+toolwindow
	Gui,help:Show
	KeyWait, LButton, D
	MouseGetPos, , , id2, nn2
	Gui, help: Destroy
Return

;this function prompts the user via tooltip to hand off aircraft to departure
DepReminder(callsign)
{
	Tooltip, Handoff: %callsign%
	Sleep, -35000
	Tooltip
}

mainGuiClose:
	Gui,main:+LastFound
	WinGetPos, GX, GY, GW, GH
	IniWrite, %GX%, %ini%, :CONFIG, WinX
	IniWrite, %GY%, %ini%, :CONFIG, WinY
	ExitApp
