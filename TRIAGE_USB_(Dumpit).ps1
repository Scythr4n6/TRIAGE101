Write-Host -Fore Gray "------------------------------------------------------"
Write-Host -Fore Cyan "                   TRIAGE101 - USB v1.0" 
Write-Host -Fore Cyan "         https://github.com/Scythr4n6/TRIAGE101"
Write-Host -Fore Gray "------------------------------------------------------"
Start-Sleep -Seconds 3

## Establish collection directory
Set-Location E:\Collections
mkdir $env:computername -Force
Set-Location E:\Collections

## Capture Memory
$dumpit = "E:\Collections\Memory\DumpIt.exe"
$output = "E:\Collections\Memory\memdump"

# Automating the execution of DumpIt
Write-Host -Fore Cyan "Capturing RAM Image..."
Start-Process $dumpit -ArgumentList "-y -o $output" -Wait
if ($?) {
    Write-Host "DumpIt execution completed successfully."
} else {
    Write-Host "DumpIt execution failed."
}

## Document the OS build information
Write-Host -Fore Cyan "Determining OS build info..."
[System.Environment]::OSVersion.Version > windows_build.txt
Write-Host -Fore Cyan "Cleaning up"
Get-ChildItem -Filter '*windows_build*' -Recurse | Rename-Item -NewName {$_.name -replace 'windows', $env:computername }
Move-Item -Path E:\*.txt -Destination E:\Collections\$env:COMPUTERNAME\
Set-Location E:\Collections\Memory
Get-ChildItem -Filter 'memdump*' -Recurse | Rename-Item -NewName {$_.name -replace 'memdump', $env:computername }
Get-ChildItem -Filter '*.raw' -Recurse | Rename-Item -NewName {$_.name -replace ' - ', '_' }
Get-ChildItem -Filter '*.raw' -Recurse | Rename-Item -NewName {$_.name -replace ' ', '_' }
Move-Item -Path E:\*.raw -Destination E:\Collections\$env:COMPUTERNAME\

## execute the KAPE collection
Set-Location E:\Collections\KAPE
Write-Host -Fore Cyan "Collecting OS artifacts..."
Start-Sleep -Seconds 3
E:\Collections\KAPE\kape.exe --tsource C: --tdest E:\Collections\$env:COMPUTERNAME --target !SANS_Triage --vhdx $env:COMPUTERNAME --zv false --module MagnetForensics_EDD --mdest E:\Collections\$env:computername\Decrypt

## Encryption Detection & Recovery
get-content E:\Collections\$env:COMPUTERNAME\Decrypt\LiveResponse\EDD.txt
Write-Host -fore cyan "Retrieving BitLocker Keys"
(Get-BitLockerVolume -MountPoint C).KeyProtector > bitlocker_recovery.txt
Get-ChildItem -Filter 'bitlocker*' -Recurse | Rename-Item -NewName {$_.name -replace 'bitlocker', $env:computername }
Move-Item -Path E\*.txt -Destination E:\Collections\$env:COMPUTERNAME\Decrypt\LiveResponse

## Completion Indication
Set-Content -Path E:\Collections\$env:COMPUTERNAME\collection-complete.txt -Value "Collection complete: $((Get-Date).ToString())"
Write-Host -Fore Cyan "** Process Complete **"
