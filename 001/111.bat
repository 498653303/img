@echo off  
setlocal enabledelayedexpansion  
  
:: 设置每个文件夹中的文件数量  
set /a filesPerFolder=5000  
  
:: 获取当前目录下的文件数量  
for /f %%x in ('dir /b /a-d ^| find /c /v ""') do set fileCount=%%x  
  
:: 计算需要的文件夹数量  
set /a folderCount=fileCount/filesPerFolder  
if not "!fileCount!%%!filesPerFolder!"=="0" set /a folderCount+=1  
  
:: 创建文件夹并分配文件  
set folderNum=1  
for %%f in (*.*) do (  
    if not exist "Folder!folderNum!" mkdir "Folder!folderNum!"  
    move "%%f" "Folder!folderNum!"  
    set /a fileCount-=1  
    if !fileCount! equ 0 goto :end  
    if !fileCount! leq 0 set /a folderNum+=1  
    if !fileCount!%%!filesPerFolder! equ 0 set /a folderNum+=1  
)  
  
:end  
echo 文件已分配到各文件夹中。  
pause