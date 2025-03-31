# FileOpener Backend Installer

This repository contains the source and installer for the backend component used by the [Local Network File Open Edge Extension](ID: polnepdgmkkmpeeanjpeloecppfobogh).
(extension in review)

## 🔍 Overview

The MSI installer installs a local batch file and registers a custom URL protocol (`fileopen://`) so that files can be opened from the browser using the extension.
The extension will convert clicked links that correspond with the various local (`file://`) link formats to (`fileopen://`) to be routed by this program.
This, alongside the extension, allows opening direct file links from the browser so as to open the original copy.

This program and extension was crafted to be used for in-house productivity/utility purposes

### Installed Components

- `C:\Program Files\FileOpener\file_open.bat` — handles path decoding and launching files
- Registry keys under `HKEY_CLASSES_ROOT\fileopen` — define the custom protocol handler

## 🛠 Build Instructions

This uses the [WiX Toolset](https://wixtoolset.org/) to build the MSI installer.

### Prerequisites

- Windows
- [WiX Toolset v3.11+](https://wixtoolset.org/releases/)
  - Make sure `candle.exe` and `light.exe` are in your PATH

### Build the MSI

cd [PATH TO PROJECT ROOT]
.\build.ps1

Manual:
cd src
candle Product.wxs RegistryAndFiles.wxs
light -o ../FileOpenerInstaller.msi Product.wixobj RegistryAndFiles.wixobj

Silent:
msiexec /i FileOpenerInstaller.msi /quiet

Uninstall:
msiexec /x FileOpenerInstaller.msi /quiet

### Security & Privacy

No network connections are made by this component.

No telemetry, tracking, or logging beyond a temp file log for debugging.

Source code is fully auditable and self-contained.

## 📄 License

This project is licensed under the [MIT License](LICENSE).
