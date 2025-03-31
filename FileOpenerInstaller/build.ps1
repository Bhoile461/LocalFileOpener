# build.ps1

# Locate WiX Toolset install folder
$wixBase = "C:\Program Files (x86)\WiX Toolset*"
$wixDir = Get-ChildItem -Directory $wixBase | Sort-Object Name -Descending | Select-Object -First 1
$wixBin = Join-Path $wixDir.FullName "bin"

# Build input/output paths
$srcDir = Join-Path $PSScriptRoot "src"
$outDir = $PSScriptRoot  # current folder

$candle = Join-Path $wixBin "candle.exe"
$light = Join-Path $wixBin "light.exe"

# Sanity check
if (!(Test-Path $candle)) { Write-Error "candle.exe not found"; exit 1 }
if (!(Test-Path $light))  { Write-Error "light.exe not found"; exit 1 }

# Run WiX tools
Write-Host " Using WiX at $wixBin"

Push-Location $srcDir
& $candle "Product.wxs" "RegistryAndFiles.wxs"
& $light -o "$outDir\FileOpenerInstaller.msi" "Product.wixobj" "RegistryAndFiles.wixobj"
Pop-Location

Write-Host "`n Build complete: FileOpenerInstaller.msi"
