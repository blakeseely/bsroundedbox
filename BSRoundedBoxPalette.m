//
//  RoundedBox
//
//  Created by Blake Seely on 11/19/05.
//  Copyright __MyCompanyName__ 2005 . All rights reserved.
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
