$folder = "C:\Users\$Env:USERNAME\Documents\AutoBackup"
$backup = "G:\My Drive"

Copy-Item -Path $backup -Destination $folder -force -recurse