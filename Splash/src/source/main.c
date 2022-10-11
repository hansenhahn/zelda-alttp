//---------------------------------------------------------------------------------
// GBA PCXView sample code for devkitARM - http://www.devkit.tk
// Suitable for a splash screen for a game
//---------------------------------------------------------------------------------
#include <stdlib.h>

#include "gba_video.h"
#include "gba_systemcalls.h"
#include "gba_interrupt.h"
#include "gba_dma.h"
#include "fade.h"
#include "gba_compression.h"

//#include "dummy_bin.h"
//#include "bg_palette_bin.h"
//#include "bg_bitmap_rle_bin.h"
#include "part_one_bin.h"
#include "part_two_bin.h"

//---------------------------------------------------------------------------------
// header for binary data generated by bin2o macro in makefile
//---------------------------------------------------------------------------------

#define DELAY 125

//---------------------------------------------------------------------------------
// Program entry point
//---------------------------------------------------------------------------------
int main(void)
//---------------------------------------------------------------------------------
{
	volatile u32 delay;
	u32 loop;
	u16 * ImagePalette;
	u16 * AllBlackPalette;
	
	ImagePalette = (u16*)malloc( sizeof(u16) * 256 );
	AllBlackPalette = (u16*)malloc( sizeof(u16) * 256 );
	// Set up the interrupt handlers	
	irqInit();

	// Enable Vblank Interrupt to allow VblankIntrWait
	irqEnable(IRQ_VBLANK);

	// Allow Interrupts
	REG_IME = 1;
	
	SetMode( MODE_4 | BG2_ON );		// screen mode & background to display
	
	// Black palette.. To make transition!
	for (loop = 0; loop < 256;loop++)
		AllBlackPalette[loop] = RGB8(0, 0, 0);
	dmaCopy(AllBlackPalette, BG_PALETTE, 256*2);

	// Copy palette and decompress image	
	dmaCopy( part_one_bin, ImagePalette, (256 << 1) );	
	LZ77UnCompVram( (void*)& part_one_bin[ 256 << 1 ], (void *)VRAM );		
	VBlankIntrWait();

	FadeToPalette( ImagePalette, 60 );
	dmaCopy(ImagePalette, BG_PALETTE, (256 << 1));
	for ( delay = 0; delay <= DELAY; delay++ )
	{
		VBlankIntrWait();
	}
	
	// Same as part one's palette . Not needed
	//dmaCopy( part_two_bin, ImagePalette, (256 << 1) );
	LZ77UnCompVram( (void*)& part_two_bin[ 256 << 1 ], (void *)VRAM );
	VBlankIntrWait();
	
	for ( delay = 0; delay <= DELAY; delay++ )
	{
		VBlankIntrWait();
	}	
	
	FadeToPalette( AllBlackPalette, 60 );
	dmaCopy(AllBlackPalette, BG_PALETTE, (256<<1));	
	
	free( ImagePalette );
	free( AllBlackPalette );

	// Retornar para a rom!
	__asm("ldr r0,=0x0800b085");
	__asm("mov pc,r0");
	
	// N�o � necess�rio heheh
	return 1;
}

