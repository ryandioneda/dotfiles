Write-Host "Creating symlinks for existing machine..."

# List of configuration files to link
$dotfiles = @{
    "$HOME\dotfiles\vscode\keybindings.json" = "$env:APPDATA\Code\User\keybindings.json"
    "$HOME\dotfiles\vscode\settings.json" = "$env:APPDATA\Code\User\settings.json"
}

# Create symlinks
foreach ($source in $dotfiles.Keys) {
    $target = $dotfiles[$source]

    # Check if target already exists
    if (Test-Path $target) {
        Write-Host "Skipping: $target already exists."
    } else {
        Write-Host "Creating symlink: $target -> $source"
        New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
        Write-Host "Symlink created!"
    }
}

Write-Host "Symlinks setup complete."

