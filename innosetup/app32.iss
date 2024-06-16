[Setup]
AppName=Renegade Launcher
AppPublisher=Renegade
UninstallDisplayName=Renegade
AppVersion=${project.version}
AppSupportURL=https://renegade.net/
DefaultDirName={localappdata}\Renegade

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Renegade.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=RenegadeSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x86\Renegade.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\Renegade.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"

[Icons]
; start menu
Name: "{userprograms}\Renegade\Renegade"; Filename: "{app}\Renegade.exe"
Name: "{userprograms}\Renegade\Renegade (configure)"; Filename: "{app}\Renegade.exe"; Parameters: "--configure"
Name: "{userprograms}\Renegade\Renegade (safe mode)"; Filename: "{app}\Renegade.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Renegade"; Filename: "{app}\Renegade.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Renegade.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Renegade.exe"; Description: "&Open Renegade"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Renegade.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.renegade\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"