# ===== Powershell Profile ====
Set-PsReadlineKeyHandler -Key Tab -Function MenuComplete
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# === Functions ===

function reload {
$tmppwd = $pwd
cd ~
cd .\Documents\WindowsPowerShell
.\Microsoft.PowerShell_profile.ps1
cd $tmppwd
}

function lsi {
eza --icons
}

function fzfi {
fzf --preview 'bat --style=numbers --color=always --theme="ansi" --line-range=:500 {+}'
}

# === Import Modules ===
