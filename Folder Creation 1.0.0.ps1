$folder = "C:\Users\$Env:USERNAME\Documents\AutoBackup"

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
