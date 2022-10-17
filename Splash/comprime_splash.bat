@echo off
echo "==Comprimindo background=="
del bg_splash_lz77.gba
copy bg_splash.gba bg_splash_lz77.gba
.\lzss.exe -evn .\bg_splash_lz77.gba

echo "==Comprimindo tilemap=="
del tm_splash_lz77.gba
copy tm_splash.gba tm_splash_lz77.gba
.\lzss.exe -evn .\tm_splash_lz77.gba