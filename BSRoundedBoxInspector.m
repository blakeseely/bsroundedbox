//
//  RoundedBox
//
//  Created by Blake Seely on 11/19/05.
//  Copyright __MyCompanyName__ 2005 . All rights reserved.
//

#import "BSRoundedBoxInspector.h"
#import "BSRoundedBox.h"

@implementation BSRoundedBoxInspector

- (id)init
{
    self = [super init];
    [NSBundle loadNibNamed:@"BSRoundedBoxInspector" owner:self];
    return self;
}

- (void)ok:(id)sender
{
	BSRoundedBox *box = [self object];
	[box setTitle:[title stringValue]];
	[box setBorderColor:[borderColor color]];
	[box setTitleColor:[titleColor color]];
	[box setGradientStartColor:[gradientStartColor color]];
	[box setGradientEndColor:[gradientEndColor color]];
	[box setBackgroundColor:[backgroundColor color]];
	[box setDrawsFullTitleBar:[drawsFullTitleBar state]];
	[box setSelected:[selected state]];
	[box setDrawsGradientBackground:[drawsGradientBackground state]];
	[box setBorderWidth:[borderWidth floatValue]];
	
    [super ok:sender];
}

- (void)revert:(id)sender
{
	BSRoundedBox *box = [self object];
	[title setStringValue:[box title]];
	[borderColor setColor:[box borderColor]];
	[titleColor setColor:[box titleColor]];
	[gradientStartColor setColor:[box gradientStartColor]];
	[gradientEndColor setColor:[box gradientEndColor]];
	[backgroundColor setColor:[box backgroundColor]];
	
	if ([box drawsFullTitleBar]) {
		[drawsFullTitleBar setState:NSOnState];
	} else {
		[drawsFullTitleBar setState:NSOffState];
	}
	
	if ([box selected]) {
		[selected setState:NSOnState];
	} else {
		[selected setState:NSOffState];
	}
	
	if ([box drawsGradientBackground]) {
		[drawsGradientBackground setState:NSOnState];
	} else {
		[drawsGradientBackground setState:NSOffState];
	}
	
	[borderWidth setFloatValue:[box borderWidth]];
	
    [super revert:sender];
}

@end
