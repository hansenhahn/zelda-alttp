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

copy "..\Imagens Traduzidas\P1P2P3P4Diagram.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\P1P2P3P4Diagram.gba"

copy "..\Imagens Traduzidas\LogoFs1.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\LogoFs1.gba"

copy "..\Imagens Traduzidas\LogoFs2.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\LogoFs2.gba"

copy "..\Imagens Traduzidas\PressStartFS.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\PressStartFS.gba"

copy "..\Imagens Traduzidas\PleaseWaitFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\PleaseWaitFs.gba"

copy "..\Imagens Traduzidas\P1P2P3P4Title.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\P1P2P3P4Title.gba"

copy "..\Imagens Traduzidas\ChooseStageFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\ChooseStageFs.gba"

copy "..\Imagens Traduzidas\ChambersOfInsightFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\ChambersOfInsightFs.gba"

copy "..\Imagens Traduzidas\TalusCaveFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\TalusCaveFs.gba"

copy "..\Imagens Traduzidas\SeaOfTreesFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\SeaOfTreesFs.gba"

copy "..\Imagens Traduzidas\VaatisPalaceFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\VaatisPalaceFs.gba"

copy "..\Imagens Traduzidas\DeathMountainFs.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\DeathMountainFs.gba"

copy "..\Imagens Traduzidas\P1P2P3P4You_LevelFinish.gba" "..\Imagens Comprimidas\"
.\lzss.exe -evn "..\Imagens Comprimidas\P1P2P3P4You_LevelFinish.gba"

echo "Aplicando patches ASM..."
armips add_intro.asm
armips the_one.asm

del "..\Releases\Zelda ALttP PT-BR Intro.gba"

::echo "Aplicando patch IPS de textos do Four Swords"
::tools/flips.exe -c -b "..\0776.gba" "Four Swords (TEXTS).gba" "Releases/Four Swords (TEXTS).bps"