@echo off
echo "Atualizando splash screen..."
cd ..\Splash\
call comprime_splash.bat
cd "..\Rotinas ASM\"

echo "Atualizando imagens comprimidas..."
copy "..\Imagens Traduzidas\LogoALttP_FourSwords.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\LogoALttP_FourSwords.gba"

copy "..\Imagens Traduzidas\LogoALttP_FourSwords-Tilemap.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\LogoALttP_FourSwords-Tilemap.gba"

copy "..\Imagens Traduzidas\ChooseGameFs1.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\ChooseGameFs1.gba"

copy "..\Imagens Traduzidas\ChooseGameFs2.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\ChooseGameFs2.gba"

copy "..\Imagens Traduzidas\ChooseGameFs3.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\ChooseGameFs3.gba"

echo "Aplicando patches ASM..."
armips add_intro.asm
armips the_one.asm

del "..\Releases\Zelda ALttP PT-BR Intro.gba"

::echo "Aplicando patch IPS de textos do Four Swords"
::tools/flips.exe -c -b "..\0776.gba" "Four Swords (TEXTS).gba" "Releases/Four Swords (TEXTS).bps"