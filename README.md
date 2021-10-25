# zla-rb-pdc-utility
vZLA Rolling/Boundary Notification and PDC Utility

Download both the .ini and .exe. Put both in the same directory and run the .exe.

May not work with VRC. Should be fully functional in vSTARS.

## Usage:
1. Select your airport/config and enter which controller you want to send notifications to (e.g: 6S, 1A, C55, etc.; this also affects departure freq for PDCs).
1. Press the Initial Setup button (you should get two click prompts. Sometimes it bugs out and you only get one... press it again and retry if this happens)
1. You'll click once in your flight plan route window (where the SID/transition goes)
    1. You'll click again in your text entry window (where you send dot commands)  
1. PDCs can be configured with checkboxes for climb via, routing change, a fillable altitude box, and a global checkbox at the bottom which adds runway PDC syntax (only use if your alias file/config file has been customized to include this!)  
2. **VRC:** Select the aircraft to choose who receives the PDC or which aircraft is indicated in the boundary notification (the tool will auto-open the flight plan; opposite behavior of vSTARS)
3. **vSTARS:** Open the flight plan of the aircraft to choose who receives the PDC or which aircraft is indicated in the boundary notification (the tool will auto-select the aircraft; opposite behavior of VRC)

You're good to go! See hotkeys below. 

## Hotkeys:
### Boundary notifications:
Ctrl+Shift+1 - Send boundary notification for runway #1.  
Ctrl+Shift+2 - Send boundary notification for runway #2.  
Ctrl+Shift+3 - Send boundary notification for runway #3.  
Ctrl+Shift+4 - Send boundary notification for runway #4.  

### PDCs:
Ctrl+Shift+q - Send PDC "q" \*  
Ctrl+Shift+w - Send PDC "w" \*  
Ctrl+Shift+e - Send PDC "e" \*  
Ctrl+Shift+r - Send PDC "r" \*  
\*will use runway #1 if runway PDCs are in use
