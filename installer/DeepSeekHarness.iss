#define MyAppName "DeepSeek Harness"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Zeejayhugh"
#define MyAppExeName "launch.vbs"

[Setup]
AppId={{8D0B0A61-87B2-43F9-A56E-C18BC5D82D29}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={localappdata}\Programs\DeepSeek Harness
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=..\dist
OutputBaseFilename=DeepSeek-Harness-Desktop-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
UninstallDisplayName={#MyAppName}
CloseApplications=no

[Files]
Source: "..\launcher\launch.vbs"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\launcher\launcher.ps1"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{userdesktop}\{#MyAppName}"; Filename: "{sys}\wscript.exe"; Parameters: """{app}\{#MyAppExeName}"""; WorkingDir: "{app}"
Name: "{userprograms}\{#MyAppName}"; Filename: "{sys}\wscript.exe"; Parameters: """{app}\{#MyAppExeName}"""; WorkingDir: "{app}"

[Run]
Filename: "{sys}\wscript.exe"; Parameters: """{app}\{#MyAppExeName}"""; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent
