# TRIAGE101

This repository contains a PowerShell script that automates the process of collecting RAM and triaging a suspect machine to an attached external storage (using USB interface). The script captures a memory image with Magnet RAM Capture or DumpIt based upon the script variant employed, captures a triage image with KAPE, checks for encrypted disks, and recovers the active BitLocker Recovery key, all directly to an attached USB device. The script also extracts the Bitlocker recovery key which can then be presented to the concerned legal authority.

# Getting Started:

To use the script, you will need to have the following tools installed:
Collections folder, including:
- A subdirectory named "KAPE" that should contain a copy of an existing KAPE installation.
- A subdirectory named "MEMORY" that should contain either Magnet RAM Capture or Old DumpIt (Windows version)

# Usage:

- Connect the external storage device to the suspect machine.
- Run the script using PowerShell as an Administrator.
- The script will automatically collect RAM and triage the machine to the external storage device.
- The Bitlocker recovery key will be extracted.

# Prerequisites:

To use the script, the following must be present on the root of the USB device:
- The script, named "TRIAGE_USB_(MRC).ps1/TRAIGE_USB_(DumpIt).ps1"
- A folder (empty to start) titled "Collections"
- A subdirectory within "Collections" folder named "KAPE" containing a copy of the KAPE installation, including EDDv310.exe (or the version of EDD mentioned in MagnetForensics_EDD.mkape) in the \modules\bin\EDD directory.
- A subdirectory within "Collections" folder named "MEMORY" containing MRC.exe/DumpIt.exe (Not Magnet DumpIt).

# Execution:

- Open PowerShell as an Administrator.
- Navigate to the USB device.
- Execute the script by running ./CSIRT-Collect_USB.ps1.
- Follow the prompts to specify the location of the external storage device and the collections folder.
- The script will automatically capture a memory image with Magnet RAM Capture, capture a triage image with KAPE, check for encrypted disks, and recover the active BitLocker Recovery key, all directly to the USB device.

# Note: 
It is important to run this script under the context of an Administrator to have the necessary permissions to execute the commands.

# Credits:
This script was inspired by the work of dwmetz and other developers. We would like to give credit to them for igniting the idea for this script.
