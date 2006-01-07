//
//  BSRoundedBox
//
//  Created by Blake Seely on 01/05/2006
//  Copyright 2006 Blake Seely (http://www.blakeseely.com)
//  For use with BSRoundedBox code, originally published as RoundedBox by Matt Gemmell.
//  This file must be distributed with code in BSRoundedBox.h and BSRoundedBox.m and follows the
//  same permissions and license.
//

#import "BSRoundedBoxPalette.h"

@implementation BSRoundedBoxPalette

- (void)finishInstantiate
{
	[roundedBox setDefaults];
}

@end

@implementation BSRoundedBox (BSRoundedBoxPaletteInspector)

- (NSString *)inspectorClassName
{
    return @"BSRoundedBoxInspector";
}

@end
