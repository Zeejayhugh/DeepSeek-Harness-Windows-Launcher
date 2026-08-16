[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$appName = 'DeepSeek Harness'
$url = 'http://127.0.0.1:3080'
$startupTimeoutSeconds = 45
$logDirectory = Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'DeepSeekHarness\Logs'
$stdoutLog = Join-Path $logDirectory 'dsh-output.log'
$stderrLog = Join-Path $logDirectory 'dsh-error.log'

function Show-LauncherError {
    param([Parameter(Mandatory)][string]$Message)

    Add-Type -AssemblyName System.Windows.Forms
    [void][System.Windows.Forms.MessageBox]::Show(
        $Message,
        $appName,
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
}

function Test-HarnessReady {
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 2
        return ($response.StatusCode -ge 200 -and $response.StatusCode -lt 500)
    }
    catch {
        return $false
    }
}

function Find-Browser {
    $chromeCandidates = foreach ($root in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LocalAppData)) {
        if ($root) { Join-Path $root 'Google\Chrome\Application\chrome.exe' }
    }

    $edgeCandidates = foreach ($root in @(${env:ProgramFiles(x86)}, $env:ProgramFiles, $env:LocalAppData)) {
        if ($root) { Join-Path $root 'Microsoft\Edge\Application\msedge.exe' }
    }

    foreach ($commandName in @('chrome.exe', 'chrome')) {
        $command = Get-Command $commandName -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($command) { return $command.Source }
    }

    foreach ($candidate in $chromeCandidates) {
        if (Test-Path -LiteralPath $candidate -PathType Leaf) { return $candidate }
    }

    foreach ($commandName in @('msedge.exe', 'msedge')) {
        $command = Get-Command $commandName -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($command) { return $command.Source }
    }

    foreach ($candidate in $edgeCandidates) {
        if (Test-Path -LiteralPath $candidate -PathType Leaf) { return $candidate }
    }

    return $null
}

try {
    $npxCommand = Get-Command 'npx.cmd' -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $npxCommand) {
        $npxCommand = Get-Command 'npx' -ErrorAction SilentlyContinue | Select-Object -First 1
    }

    if (-not $npxCommand) {
        Show-LauncherError "Node.js/npm was not found.`n`nInstall the current Node.js LTS release from https://nodejs.org/, then start DeepSeek Harness again."
        exit 1
    }

    $browser = Find-Browser
    if (-not $browser) {
        Show-LauncherError 'Google Chrome or Microsoft Edge was not found. Install one of these browsers, then start DeepSeek Harness again.'
        exit 1
    }

    if (-not (Test-HarnessReady)) {
        New-Item -ItemType Directory -Path $logDirectory -Force | Out-Null

        $process = Start-Process -FilePath $npxCommand.Source `
            -ArgumentList @('--yes', '@deepseek-ai/dsh', 'web') `
            -WindowStyle Hidden `
            -RedirectStandardOutput $stdoutLog `
            -RedirectStandardError $stderrLog `
            -PassThru

        $deadline = [DateTime]::UtcNow.AddSeconds($startupTimeoutSeconds)
        while ([DateTime]::UtcNow -lt $deadline) {
            if (Test-HarnessReady) { break }
            if ($process.HasExited) { break }
            Start-Sleep -Milliseconds 500
        }

        if (-not (Test-HarnessReady)) {
            Show-LauncherError "DeepSeek Harness did not become available within 45 seconds.`n`nCheck your internet connection and Node.js installation, then try again.`n`nDiagnostic logs:`n$logDirectory"
            exit 1
        }
    }

    Start-Process -FilePath $browser -ArgumentList "--app=$url"
}
catch {
    $details = $_.Exception.Message
    Show-LauncherError "DeepSeek Harness could not be started.`n`n$details`n`nDiagnostic logs (if available):`n$logDirectory"
    exit 1
}
