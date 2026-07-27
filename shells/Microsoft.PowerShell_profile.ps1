# ===== Powershell Profile ====
z ~\scoop
Set-PsReadlineKeyHandler -Key Tab -Function MenuComplete
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# === Functions ===

function ezai {
eza --icons
}

function fzfi {
fzf --preview 'bat --style=numbers --color=always --theme="ansi" --line-range=:500 {+}'
}

# === Import Modules ===

