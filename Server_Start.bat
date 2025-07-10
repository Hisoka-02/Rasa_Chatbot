@echo off
REM ---------------------------------------
REM Wechsle in das Verzeichnis, in dem die Batch-Datei liegt
REM ---------------------------------------
cd /d "%~dp0"

REM ---------------------------------------
REM Überprüfen, ob die virtuelle Umgebung (.venv) existiert
REM ---------------------------------------
if exist ".venv\Scripts\activate" (
    echo Die virtuelle Umgebung wurde gefunden. Sie wird nun aktiviert...
    call .venv\Scripts\activate
) else (
    echo Keine virtuelle Umgebung gefunden. Der Server wird ohne Aktivierung gestartet.
)

REM ---------------------------------------
REM Überprüfen, ob das Modell im "models"-Verzeichnis existiert
REM ---------------------------------------
if exist "models\*" (
    echo Modell wurde gefunden! Der Server wird jetzt gestartet...
    rasa run -m models --enable-api --cors "*" --debug
) else (
    echo Kein Modell im "models"-Verzeichnis gefunden. Bitte stellen Sie sicher, dass das Modell vorhanden ist.
)

REM Ende des Skripts
pause
