@echo off
REM ---------------------------------------
REM 1. Schritt: Installiere Python, wenn es nicht vorhanden ist
REM ---------------------------------------

REM Überprüfen, ob Python installiert ist
python --version > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python ist nicht installiert. Installiere jetzt Python...
    REM Installiere Python 3.10.x
    REM Du kannst die Version ändern, falls du eine andere Version benötigst
    curl -o python_installer.exe https://www.python.org/ftp/python/3.10.11/python-3.10.11.exe
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    echo Python wurde erfolgreich installiert.
) ELSE (
    echo Python ist bereits installiert.
)

REM ---------------------------------------
REM 2. Schritt: Installiere pip, wenn es nicht vorhanden ist
REM ---------------------------------------

REM Überprüfen, ob pip installiert ist
pip --version > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo pip ist nicht installiert. Installiere jetzt pip...
    python -m ensurepip --upgrade
    echo pip wurde erfolgreich installiert.
) ELSE (
    echo pip ist bereits installiert.
)

REM ---------------------------------------
REM 3. Schritt: Aktualisiere pip auf die neueste Version
REM ---------------------------------------

echo Aktualisiere pip auf die neueste Version...
python -m pip install --upgrade pip
echo pip wurde auf die neueste Version aktualisiert.

REM ---------------------------------------
REM 4. Schritt: Erstellen der virtuellen Umgebung im gleichen Verzeichnis wie die Batch-Datei
REM ---------------------------------------

REM Wechsle in das Verzeichnis, in dem diese Batch-Datei liegt
cd /d "%~dp0"
REM Erstelle einen neuen Ordner für das Projekt, falls dieser noch nicht existiert
IF NOT EXIST "Rasa_Chatbot" (
    mkdir Rasa_Chatbot
)
cd Rasa_Chatbot

REM Überprüfen, ob die virtuelle Umgebung (.venv) existiert
IF NOT EXIST ".venv\Scripts\activate" (
    REM Erstelle eine virtuelle Umgebung im aktuellen Verzeichnis
    python -m venv .venv
    echo Virtuelle Umgebung wurde erstellt.
) ELSE (
    echo Virtuelle Umgebung wurde gefunden. Sie wird nun aktiviert...
)

REM Aktivieren der virtuellen Umgebung
call .venv\Scripts\activate
echo Virtuelle Umgebung wurde aktiviert.

REM ---------------------------------------
REM 5. Schritt: Installiere Rasa und alle notwendigen Pakete
REM ---------------------------------------

REM Installiere Rasa, falls noch nicht installiert
pip show rasa > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    pip install rasa
    echo Rasa wurde erfolgreich installiert.
) ELSE (
    echo Rasa ist bereits installiert.
)

REM Löschen der Batch-Datei
del "%~f0"

REM Ende des Skripts
pause
