@echo off
del "[GBA] The Legend of Zelda - A Link to the Past & Four Swords (U)[T-BR] [T-Vários G-Vários](Revisão 3.1).*"
cd ".\Arquivos Four Swords\"
.\flips.exe -c -i "..\0776.gba" "..\Releases\Zelda ALttP PT-BR.gba" "..\[GBA] The Legend of Zelda - A Link to the Past & Four Swords (U)[T-BR] [T-Vários G-Vários](Revisão 3.1).ips"
.\xdelta.exe -e -s "..\0776.gba" "..\Releases\Zelda ALttP PT-BR.gba" "..\[GBA] The Legend of Zelda - A Link to the Past & Four Swords (U)[T-BR] [T-Vários G-Vários](Revisão 3.1).xdelta"