
### #region conda initialize
### # !! Contents within this block are managed by 'conda init' !!
### If (Test-Path "C:\tools\miniconda3\Scripts\conda.exe") {
###     (& "C:\tools\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
### }
### #endregion

### Use gcm for details
function which($cmd) {
	Get-Command $cmd | Select-Object -ExpandProperty Definition
}

