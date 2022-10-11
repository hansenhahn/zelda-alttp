#!/usr/bin/env python
# -*- coding: utf-8 -*-

# maps.py

# Copyright 2009 Diego Hansen Hahn (aka DiegoHH) <diegohh90 [at] hotmail [dot] com>

# Monkeys Maps is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License.

# Monkeys Maps is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Monkeys Maps. If not, see <http://www.gnu.org/licenses/>.

import os
import sys
import struct


# TODO - Suporte a paleta de cores compostas e dados 8bpp

def vertical( buffer ):
	c = ''
	for y in range( 8 )[::-1]:
		c += buffer[4 * y:4 * ( y + 1 )]
	return c

def horizontal( buffer ):
	c = ''
	for y in range( 8 ):
		reverse = buffer[4 * y:4 * ( y + 1 )][::-1]
		for w in range( 4 ):
			c += chr( ( ord( reverse[w] ) << 4 | ord( reverse[w] ) >> 4 ) & 0xFF )
	return c

def diagonal( buffer ):
	return horizontal( vertical( buffer ) )

def maps_generate( raw, bg, tm, codec = 4 ):
	raw = open( raw, 'rb' )
	bg = open( bg, 'wb' )
	tm = open( tm, 'wb' )

	# xx = open( '005.gba', 'rb' )  # <-- paleta, eu acho

	tilesdict = {}
	buffer = raw.read()

	if codec == 4:
		lenght = len( buffer ) / 32
		for x in range( lenght ):
			tilesdict.update( {x + 16:buffer[32 * x:32 * ( x + 1 )]} )
	else:
		lenght = len( buffer ) / 64
		for x in range( lenght ):
			tilesdict.update( {x + 16:buffer[64 * x:64 * ( x + 1 )]} )

	dc = {}
	w = 0

	for x in tilesdict:
		if dc.has_key( tilesdict[x] ):
			pass
		elif dc.has_key( horizontal( tilesdict[x] ) ):
			pass
		elif dc.has_key( vertical( tilesdict[x] ) ):
			pass
		else:
			dc.update( {tilesdict[x]:w} )
			w += 1

	newdc = {}

	for x in dc:
		newdc.update( {dc[x]:x} )

	for x in range( 0, ( 0 + len( newdc ) ) - 0 ):
		bg.write( newdc[x] )

	for x in tilesdict:
		pal = 0x8000  # struct.unpack( '<H', xx.read( 2 ) )[0]	 & 0xF000
		if dc.has_key( tilesdict[x] ):
			tm.write( struct.pack( "<H", ( dc[tilesdict[x]] | pal ) ) )
		elif dc.has_key( horizontal( tilesdict[x] ) ):
			tm.write( struct.pack( "<H", ( 0x400 + dc[horizontal( tilesdict[x] )] ) | pal ) )
		elif dc.has_key( vertical( tilesdict[x] ) ):
			tm.write( struct.pack( "<H", ( 0x800 + dc[vertical( tilesdict[x] )] ) | pal ) )
		elif dc.has_key( diagonal( tilesdict[x] ) ):
			tm.write( struct.pack( "<H", ( 0xC00 + dc[diagonal( tilesdict[x] )] ) | pal ) )
		else:
			raw_input( "Erro na hora de criar mapa" )
			sys.exit( 1 )

	raw.close()
	bg.close()
	tm.close()
	# xx.close()

	raw_input( "Arquivos gerados com sucesso" )
	return True

def maps_extract( raw, bg, tm, codec = 4 ):
	raw = open( raw, 'wb' )
	bg = open( bg, 'rb' )
	tm = open( tm, 'rb' )

	tilesdict = {}
	buffer = bg.read()

	# tilesdict.update({0:'\x00'*32})
	# tilesdict.update({1:'\x11'*32})
	# tilesdict.update({2:'\x22'*32})
	# tilesdict.update({3:'\x33'*32})
	# tilesdict.update({4:'\x44'*32})
	# tilesdict.update({5:'\x55'*32})
	# tilesdict.update({6:'\x66'*32})
	# tilesdict.update({7:'\x77'*32})
	# tilesdict.update({8:'\x88'*32})
	# tilesdict.update({9:'\x99'*32})
	# tilesdict.update({10:'\xAA'*32})
	# tilesdict.update({11:'\xBB'*32})
	# tilesdict.update({12:'\xCC'*32})
	# tilesdict.update({13:'\xDD'*32})
	# tilesdict.update({14:'\xEE'*32})
	# tilesdict.update({15:'\xFF'*32})
	# for x in range(16, 0x100):
		# tilesdict.update({x:'\x00'*32})

	if codec == 4:
		lenght = len( buffer ) / 32
		for x in range( lenght ):
			tilesdict.update( {x:buffer[32 * x:32 * ( x + 1 )]} )
	else:
		lenght = len( buffer ) / 64
		for x in range( lenght ):
			tilesdict.update( {x:buffer[64 * x:64 * ( x + 1 )]} )

	try:
		for x in range( os.path.getsize( tm.name ) / 2 ):
			key = struct.unpack( "<H", tm.read( 2 ) )[0]

			# TODO - Imagens com multiplas paletas
			key &= 0xFFF

			if ( key & 0xC00 ) == 0xC00 :
				raw.write( diagonal( tilesdict[( key & 0x3FF )] ) )
			elif ( key & 0x800 ) == 0x800:
				raw.write( vertical( tilesdict[( key & 0x3FF )] ) )
			elif ( key & 0x400 ) == 0x400:
				raw.write( horizontal( tilesdict[( key & 0x3FF )] ) )
			else:
				raw.write( tilesdict[( key & 0x3FF )] )
	except KeyError:
		raw_input( "Erro com a chave %04X" % ( key & 0x3FF ) )
		sys.exit( 1 )

	raw.close()
	bg.close()
	tm.close()

	raw_input( "Arquivo extraido com sucesso" )
	return True

if __name__ == "__main__":
	print "Monkeys Maps - Script escrito por Diego H. Hahn - 2009\n"
	choose = raw_input( "Modo [1] Extrair [2] Gerar : " )
	if int( choose ) == 1:
		bg = raw_input( "Informe o nome do arquivo com o background: " )
		tm = raw_input( "Informe o nome do arquivo com o tilesmap: " )
		raw = raw_input( "Informe o nome do arquivo de saida: " )
		maps_extract( raw, bg, tm )
		sys.exit( 1 )
	elif int( choose ) == 2:
		raw = raw_input( "Informe o nome do arquivo de entrada: " )
		bg = raw_input( "Informe o nome do arquivo para o background: " )
		tm = raw_input( "Informe o nome do arquivo para o tilesmap: " )
		maps_generate( raw, bg, tm )
		sys.exit( 1 )
	else:
		sys.exit( 1 )
