//
//  BSRoundedBox
//
//  Created by Blake Seely on 11/19/05.
//  Copyright __MyCompanyName__ 2005. All rights reserved.
//

#import <InterfaceBuilder/InterfaceBuilder.h>

@interface BSRoundedBoxInspector : IBInspector
{
	IBOutlet NSTextField *title;
	IBOutlet NSColorWell *borderColor;
	IBOutlet NSColorWell *titleColor;
	IBOutlet NSColorWell *gradientStartColor;
	IBOutlet NSColorWell *gradientEndColor;
	IBOutlet NSColorWell *backgroundColor;
	IBOutlet NSButton *drawsFullTitleBar;
	IBOutlet NSButton *selected;
	IBOutlet NSButton *drawsGradientBackground;
	IBOutlet NSTextField *borderWidth;
}

@end
