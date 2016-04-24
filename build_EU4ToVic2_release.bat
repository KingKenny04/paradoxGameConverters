set /p version=Version Number?:

call "%VS140COMNTOOLS%\vsvars32.bat"
msbuild.exe "Frontend\ParadoxConverters.Frontend\ParadoxConverters.Frontend.sln" /p:Configuration=Release /m
xcopy "Frontend\ParadoxConverters.Frontend\ParadoxConverters.Frontend\bin\Release" "EU4ToVic2-%version%"  /Y /E /I
copy "EU4toV2\Data_Files\Eu4ToVic2DefaultConfiguration.xml" "EU4ToVic2-%version%\Configuration\"
cd "EU4ToVic2-%version%\"
del *.pdb

cd EU4toV2
call "build.bat"
xcopy "Release" "..\EU4ToVic2-%version%\EU4ToVic2"  /Y /E /I
cd ..

cd "EU4ToVic2-%version%"
call "%SEVENZIP_LOC%\7z.exe" a -tzip -r "..\EU4ToV2-%version%.zip" "*" -mx5
cd ..
