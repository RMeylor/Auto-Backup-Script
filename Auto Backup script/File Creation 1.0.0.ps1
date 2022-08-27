$folder = "C:\Users\$Env:USERNAME\Documents\AutoBackup"

cd $folder
New-Item ".\Download Path.txt"
Set-Content ".\Download Path.txt" 'G:\My Drive'

New-Item ".\Upload Path.txt"
Set-Content ".\Upload Path.txt" $folder