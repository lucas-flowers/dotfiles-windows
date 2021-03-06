
# Terminal settings
Set-PSReadlineOption `
    -EditMode vi `
    -ViModeIndicator Cursor `
    -BellStyle None

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
function Prompt {
    Write-Host "PS" -NoNewline -ForegroundColor DarkBlue
    Write-Host " " -NoNewline
    Write-Host $(Get-Location) -NoNewline -ForegroundColor DarkYellow
    "> "
}

# PowerShell drives (ignore output from these commands)
&{
New-PSDrive -Scope Global -PSProvider Registry -Name HKU -Root HKEY_USERS
New-PSDrive -Scope Global -PSProvider Registry -Name HKCR -Root HKEY_CLASSES_ROOT
New-PSDrive -Scope Global -PSProvider Registry -Name HKCC -Root HKEY_CURRENT_CONFIG
} | Out-Null

# Aliases
Set-Alias make 'mingw32-make.exe'
Set-Alias l 'Get-ChildItem'
function ls1 {
    <#
    .SYNPOSIS
    Alias-like function representing `Get-ChildItem -Name`. Roughly analogous
    to `ls -1` in Unix. Useful for printing the contents of directories in
    PSDrives where Get-ChildItem output is messy (such as Registry:).
    #>
    Get-ChildItem -Name
}
function cfg {
    git.exe --git-dir="$env:USERPROFILE\dotfiles-windows" --work-tree="$env:USERPROFILE" $args
}

