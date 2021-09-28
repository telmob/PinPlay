#include <Constants.au3>
#include <GUIListView.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlListView_SaveTxt
; Description ...: Exports a listview to a txt file.
; Syntax ........: _GUICtrlListView_SaveTxt($hListView, $sFilePath[, $sDelimiter = '|'])
; Parameters ....: $hListView           - Control ID/Handle to the control
;                  $sFilePath           - Filepath to save the txt data string to.
;                  $sDelimiter          - [optional] Delimiter to distinguish between columns. Default is |.
; Return values .: Success - True
;                  Failure - False and sets @error to non-zero.
; Author ........: guinness
; Remarks .......: GUICtrlListView.au3 should be included.
; Example .......: Yes
; ===============================================================================================================================
Func _GUICtrlListView_SaveTxt($hListView, $sFilePath, $sDelimiter = '=')
    If $sDelimiter = Default Then
        $sDelimiter = '='
    EndIf

    Local Const $iColumnCount = _GUICtrlListView_GetColumnCount($hListView) - 1
    Local Const $iItemCount = _GUICtrlListView_GetItemCount($hListView) - 1
    Local $sReturn = ''
    For $i = 0 To $iItemCount
        For $j = 0 To $iColumnCount
            $sReturn &= _GUICtrlListView_GetItemText($hListView, $i, $j)
            If $j < $iColumnCount Then
                $sReturn &= $sDelimiter
            EndIf
        Next
        $sReturn &= @CRLF
    Next

    Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE)
    If $hFileOpen = -1 Then
        Return SetError(1, 0, False)
    EndIf
    FileWrite($hFileOpen, $sReturn)
    FileClose($hFileOpen)
    Return True
EndFunc   ;==>_GUICtrlListView_SaveTxt