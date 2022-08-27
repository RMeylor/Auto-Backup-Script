﻿Write-host "Welcome to the Backup Utility" -ForegroundColor Magenta
Start-Sleep -s 1
Write-host "Lets choose where you want to backup your data" -ForegroundColor Magenta

#navigation tool
Function Navigation 
 {
  Start-sleep -s 1
 cd C:\
  $directory = get-psdrive -PSProvider FileSystem
    if ($directory.count -gt 1){
      
        for($i = 0; $i -lt $directory.count; $i++){
            Write-Host "$($i): $($directory[$i].SamAccountName) | $($directory[$i].Name)"
        }
        $selection = Read-Host -Prompt "Enter the number of the desired folder"
        $DriveName = $directory[$selection].name
        Write-Host "You selected Drive:" -ForegroundColor Green;
        $DriveName 
        $SelectedDrive = $DriveName + ":\"
        cd $SelectedDrive
        }

        Start-sleep -s 1
        Write-Host "-----------------------------------" -ForegroundColor yellow
        Start-sleep -s 1

    $directory = ls 
    if ($directory.count -gt 1){
       Write-Host "Choose a folder to save your backed-up data:" -ForegroundColor Green
        for($i = 0; $i -lt $directory.count; $i++){
            Write-Host "$($i): $($directory[$i].SamAccountName) | $($directory[$i].Name)"
        }
        $selection = Read-Host -Prompt "Enter the number of the desired folder"
        $selected_folder = $directory[$selection]
       Write-Host "You selected:" -ForegroundColor Green;
       $foldername = $selected_folder.Name
       Write-Host "$foldername" -ForegroundColor yellow;
       cd $selected_folder
    }

    Write-Host “Do you need to further navigate into this folder?”;
    $Yes_No = read-host -prompt “Y/N?”;

    Start-sleep -s 1
    Write-Host "-----------------------------------" -ForegroundColor yellow
    Start-sleep -s 1


If($Yes_No -eq "Y")
{
DO
{$directory = ls 
    if ($directory.count -gt 1){
       Write-Host "Choose your next folder:" -ForegroundColor Green
        for($i = 0; $i -lt $directory.count; $i++){
            Write-Host "$($i): $($directory[$i].SamAccountName) | $($directory[$i].Name)"
        }
        $selection = Read-Host -Prompt "Enter the number of the desired folder"
        $selected_folder = $directory[$selection]
       Write-Host "You selected:" -ForegroundColor Green;
       $foldername = $selected_folder.Name
       Write-Host "$foldername" -ForegroundColor yellow;}
       cd $selected_folder
       Write-Host “Do you need to further navigate into this folder?”
       $Yes_No = read-host -prompt “Y/N?”

       Start-sleep -s 1
       Write-Host "-----------------------------------" -ForegroundColor yellow
       Start-sleep -s 1

       } While ($Yes_No -eq "Y")
    }
   }

#---------------------------------------------------------------------------------------
Write-Host "Select the drive that we will back up your data into:
(we will select the directory path next)" -ForegroundColor Green
Navigation

#save current file path and then create the desired file path
#this will not rerun if the path exists
Set-Content ".\Delete.txt" $pwd
$download = Get-Content '.\Delete.txt'
$folder = $download + "\AutoBackup"
Remove-Item .\Delete.txt

#If the file does not exist, create it.
if (-not(Test-Path -Path $folder -PathType Container)) {
     try {
         $null = New-Item -ItemType Directory -Path $Folder -Force -ErrorAction Stop
         Write-Host "The Folder [$folder] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
 }
# If the file already exists, show the message and do nothing.
 else {
     Write-Host "Cannot create [$folder] because a file with that name already exists."
 }


#saving the file path of where the backup is being downloaded
cd $folder
New-Item ".\Download Path.txt"
Set-Content ".\Download Path.txt" $folder

Write-Host "What are you trying to back up? Lets find it!"
Navigation
Set-Content ".\Delete.txt" $pwd
$backup = Get-Content '.\Delete.txt'

#saving the file path for where the backup came from
cd $folder
New-Item ".\Backup Path.txt"
Set-Content ".\Backup Path.txt" $backup

#creating a variable to name the backup foder as
$date = Get-Date -Format "MM dd yyyy"
$CurrentBackup = "backup " + $date

#backing up the data
Copy-Item -Path $backup -Destination $folder\$CurrentBackup -force -recurse