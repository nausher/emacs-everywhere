emacs-everywhere
================

A Script to make EMACS like features (Kill-ring, transpose, select till end of sentence etc) in all Applications in Windows.

Installation
============
To run this script and use the keyboard shortcuts.    
1) Download and Install AutoHotKey from - [http://www.autohotkey.com/](http://www.autohotkey.com/ "http://www.autohotkey.com/")    
2) Download/Copy the [EmacsEverywhere.ahk script](https://raw.github.com/nausher/emacs-everywhere/master/EmacsEverywhere.ahk) and double click it to start running it.


Shortcuts Explained
====================

## **Transpose** ##

To transpose characters Emacs style - i.e. t|lak => t|alk    
Where | indicates the cursor.    
Place the cursor to the left of the 2 characters that need to be transposed and press 
***(Left) Ctrl + Q***

## **Multi-Clipboard / EMACS Kill-ring / Copy-ring** ##

To copy multiple items and keep them in a stack to be used for pasting.

1) Copy normally with ***Ctrl+C***

2) Use one of the following keyboard shortcuts to make use of the Kill-ring (Copy-ring)

a) ***Windows Key + V***  :- To paste the most recent copied item.     
  Pressing again will paste the item one older in the stack

b) ***Ctrl + Windows Key + V*** :- Pastes the oldest item in the Kill-ring stack (bottom most).    
  Use this to paste the oldest item you copied, and repeatedly doing this will paste from the bottom of the stack.
  
c) ***Windows Key + \*** :- Pastes the most recent item from the Kill-ring (Copy-ring) stack and
  repeatedly pressing this will cycle through all the different items in the stack, displaying all the different
  item stored in the Kill-ring (Copy-ring).


d) ***Ctrl + Windows Key + \*** :- Pastes the oldest item from the Kill-ring (Copy-ring) stack and
  repeatedly pressing this will cycle through all the different items in the stack in reverse order,
  displaying all the different item stored in the Kill-ring (Copy-ring).

e) or You can continue to paste normally with :- ***Ctrl + V***

    
## **EMACS Style Select till end of sentence (period) across multiple lines** ##   
    
To select all the text to the right of the cursor untill it encounters a . (period) or any other special character
even across newlines use one of the following shortcuts - 


1) ***(Left) Alt + /*** :- Selects from current cursor position till it encounters a '/' or 15 words whichever comes first.

2) ***(Left) Alt + .*** :- Selects from current cursor position till it encounters a period '.' (i.e. end of sentence) or 15 words whichever comes first.

3) ***(Left) Alt + '*** :- Selects from current cursor position till it encounters a single quote ' or double quote " or 15 words whichever comes first.





 


