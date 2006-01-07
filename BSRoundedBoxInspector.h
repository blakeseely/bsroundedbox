//
//  BSRoundedBox
//
//  Created by Blake Seely on 01/05/2006
//  Copyright 2006 Blake Seely (http://www.blakeseely.com)
//  For use with BSRoundedBox code, originally published as RoundedBox by Matt Gemmell.
//  This file must be distributed with code in BSRoundedBox.h and BSRoundedBox.m and follows the
//  same permissions and license.
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
