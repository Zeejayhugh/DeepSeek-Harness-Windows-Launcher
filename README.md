# DeepSeek Harness Windows Launcher

A small, open-source Windows launcher for running the official DeepSeek Harness web interface as a desktop-style app.

## Install

1. Open the repository's **Releases** page.
2. Download `DeepSeek-Harness-Desktop-Setup.exe` from the latest release.
3. Run the installer. It installs only for the current Windows user and does not require administrator rights.
4. Start **DeepSeek Harness** from the desktop or Start menu shortcut.

The installer includes an uninstaller, available from Windows **Installed apps**.

## Requirements

- Windows 10 or Windows 11
- The current [Node.js LTS](https://nodejs.org/) release, including npm/npx
- Google Chrome or Microsoft Edge
- Internet access the first time `npx` obtains the official `@deepseek-ai/dsh` package

The launcher does not install Node.js or a browser. If Node.js/npm is missing, it displays an installation prompt instead of failing silently.

## What the launcher does

When the shortcut is opened, the launcher:

1. Starts `npx --yes @deepseek-ai/dsh web` without showing a console window.
2. Waits up to 45 seconds for `http://127.0.0.1:3080`.
3. Opens the service in Chrome app mode, or Edge app mode when Chrome is unavailable.

Diagnostic logs are stored under `%LOCALAPPDATA%\DeepSeekHarness\Logs`.

## API keys and privacy

This repository and installer contain no DeepSeek API key. Each user configures their own credentials through DeepSeek Harness. The launcher does not hard-code personal paths; installation and log locations are resolved from standard Windows per-user folders.

## Build locally

Install [Inno Setup 6](https://jrsoftware.org/isinfo.php), then compile `installer\DeepSeekHarness.iss`. The resulting installer is written to `dist\DeepSeek-Harness-Desktop-Setup.exe`.

## License

MIT
