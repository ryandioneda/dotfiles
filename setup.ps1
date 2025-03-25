Write-Host "Setting up dotfiles..."

# List of dotfiles and their target locations
$dotfiles = @{
    "$HOME\dotfiles\vscode\keybindings.json" = "$env:APPDATA\Code\User\keybindings.json"
    "$HOME\dotfiles\vscode\settings.json" = "$env:APPDATA\Code\User\settings.json"
}

# Create symlink
foreach ($source in $dotfiles.Keys) {
    $target = $dotfiles[$source]

    if (Test-Path $target) {
        Write-Host "Skipping: $target already exists."
    } else {
        Write-Host "Creating symlink: $target -> $source"
        New-Item -ItemType SymbolicLink -Path $target -Target $source | Out-Null
        Write-Host "Symlink created!"
    }
}


# Install VS Code extensions
$extensionsList = "$HOME\dotfiles\vscode\extensions.list"
if (Test-Path $extensionsList) {
    Write-Host "Installing VS Code extensions..."
    Get-Content $extensionsList | ForEach-Object { 
        Write-Host "Installing $_..."
        code --install-extension $_
    }
    Write-Host "VS Code extensions installation complete!"
} else {
    Write-Host "No extensions.list file found. Skipping VS Code extension installation."
}

Write-Host "Configuration setup complete."