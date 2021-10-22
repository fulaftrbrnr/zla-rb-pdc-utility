# zla-rb-pdc-utility
vZLA Rolling/Boundary Notification and PDC Utility

Download both the .ini and .exe. Put both in the same directory and run the .exe.

May not work with VRC. Should be fully functional in vSTARS.

## Usage:
Select your airport/config and enter which controller you want to send notifications to (e.g: 6S, 1A, C55, etc.; this also affects departure freq for PDCs).
Press the Initial Setup button (you should get two click prompts. Sometimes it bugs out and you only get one... press it again and retry if this happens)
  • You'll click once in your flight plan route window (where the SID/transition goes)
  • You'll click again in your text entry window (where you send dot commands)
PDCs can be configured with checkboxes for climb via, routing change, a fillable altitude box, and a global checkbox at the bottom which adds runway PDC syntax (only use if your alias file/config file has been customized to include this!)
You're good to go! See hotkeys below. 

## Hotkeys:
### Boundary notifications:
Ctrl+Shift+1 - Send boundary notification for runway #1.
Ctrl+Shift+2 - Send boundary notification for runway #2.
Ctrl+Shift+3 - Send boundary notification for runway #3.
Ctrl+Shift+4 - Send boundary notification for runway #4.
Ctrl+Shift+q - Send PDC "q" \*
Ctrl+Shift+w - Send PDC "w" \*
Ctrl+Shift+e - Send PDC "e" \*
Ctrl+Shift+r - Send PDC "r" \*
\*will use runway #1 if runway PDCs are in use
