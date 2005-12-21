//
//  BSRoundedBox
//
//  Created by Blake Seely on 11/19/05.
//  Copyright __MyCompanyName__ 2005 . All rights reserved.
//

#import <InterfaceBuilder/InterfaceBuilder.h>
#import "BSRoundedBox.h"

@interface BSRoundedBoxPalette : IBPalette
{
	IBOutlet BSRoundedBox *roundedBox;
}
@end

@interface BSRoundedBox (BSRoundedBoxPaletteInspector)
- (NSString *)inspectorClassName;
@end
