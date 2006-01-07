//
//  BSRoundedBox
//
//  Updated by Blake Seely on 01/05/2006
//  Copyright 2006 Blake Seely (http://www.blakeseely.com) and Matt Gemmell (see below)
//  Permissions and License are the same as below, but please include credit to me (Blake Seely) as well as Matt.
//
//
//  RoundedBox
//
//  Created by Matt Gemmell on 01/11/2005.
//  Copyright 2005 Matt Gemmell. http://mattgemmell.com/
//
//  Permission to use this code:
//
//  Feel free to use this code in your software, either as-is or 
//  in a modified form. Either way, please include a credit in 
//  your software's "About" box or similar, mentioning at least 
//  my name (Matt Gemmell). A link to my site would be nice too.
//
//  Permission to redistribute this code:
//
//  You can redistribute this code, as long as you keep these 
//  comments. You can also redistribute modified versions of the 
//  code, as long as you add comments to say that you've made 
//  modifications (keeping these original comments too).
//
//  If you do use or redistribute this code, an email would be 
//  appreciated, just to let me know that people are finding my 
//  code useful. You can reach me at matt.gemmell@gmail.com
//

#import "BSRoundedBox.h"


@implementation BSRoundedBox


#pragma mark -
#pragma mark initialize & dealloc

+ (void)initialize
{
	[self exposeBinding:@"borderColor"];
	[self exposeBinding:@"titleColor"];
	[self exposeBinding:@"gradientStartColor"];
	[self exposeBinding:@"gradientEndColor"];
	[self exposeBinding:@"backgroundColor"];
	[self exposeBinding:@"drawsFullTitleBar"];
	[self exposeBinding:@"selected"];
	[self exposeBinding:@"drawsGradientBackground"];
	
}

/* I don't think I need this - the palette uses -finishInstantiate, and everything created from the palette will use the coder methods
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		NSLog(@"Inside the default init");
        [self setDefaults];
    }
    return self;
}
*/
- (void)dealloc
{
    [borderColor release];
    [titleColor release];
    [gradientStartColor release];
    [gradientEndColor release];
    [backgroundColor release];
    [titleAttrs release];
    
    [super dealloc];
}

- (void)setDefaults
{
    borderWidth = 2.0;
    [self setBorderColor:[NSColor grayColor]];
    [self setTitleColor:[NSColor whiteColor]];
    [self setGradientStartColor:[NSColor colorWithCalibratedWhite:0.92 alpha:1.0]];
    [self setGradientEndColor:[NSColor colorWithCalibratedWhite:0.82 alpha:1.0]];
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.90 alpha:1.0]];
    [self setTitleFont:[NSFont boldSystemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
    
    // Set up text attributes for drawing
    NSMutableParagraphStyle *paragraphStyle;
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    [paragraphStyle setAlignment:NSLeftTextAlignment];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    titleAttrs = [[NSMutableDictionary dictionaryWithObjectsAndKeys:
        [self titleFont], NSFontAttributeName,
        [self titleColor], NSForegroundColorAttributeName,
        [paragraphStyle autorelease], NSParagraphStyleAttributeName,
        nil] retain];
    
    [self setDrawsFullTitleBar:NO];
    [self setSelected:NO];
    [self setDrawsGradientBackground:YES];
}

#pragma mark -
#pragma mark serialization

// adding serialization methods to suppport IB palette
- (id)initWithCoder:(NSCoder *)coder
{
	if (self = [super initWithCoder:coder]) {
		if ([coder allowsKeyedCoding]) {
			[self setBorderWidth:[[coder decodeObjectForKey:@"borderWidth"] floatValue]];
			[self setBorderColor:[coder decodeObjectForKey:@"borderColor"]];
			[self setTitleColor:[coder decodeObjectForKey:@"titleColor"]];
			[self setGradientStartColor:[coder decodeObjectForKey:@"gradientStartColor"]];
			[self setGradientEndColor:[coder decodeObjectForKey:@"gradientEndColor"]];
			[self setBackgroundColor:[coder decodeObjectForKey:@"backgroundColor"]];
			[self setDrawsFullTitleBar:[coder decodeBoolForKey:@"drawsFullTitleBar"]];
			[self setSelected:[coder decodeBoolForKey:@"selected"]];
			[self setDrawsGradientBackground:[coder decodeBoolForKey:@"drawsGradientBackground"]];
			[self setTitleAttrs:[coder decodeObjectForKey:@"titleAttrs"]];
		} else {
			[self setBorderWidth:[[coder decodeObject] floatValue]];
			[self setBorderColor:[coder decodeObject]];
			[self setTitleColor:[coder decodeObject]];			
			[self setGradientStartColor:[coder decodeObject]];
			[self setGradientEndColor:[coder decodeObject]];
			[self setBackgroundColor:[coder decodeObject]];
			[self setDrawsFullTitleBar:[[coder decodeObject] boolValue]];
			[self setSelected:[[coder decodeObject] boolValue]];
			[self setDrawsGradientBackground:[[coder decodeObject] boolValue]];
			[self setTitleAttrs:[coder decodeObject]];
		}
		return self;
	} else {
		return nil;
	}
	
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	if ([coder allowsKeyedCoding]) {
		[coder encodeObject:[NSNumber numberWithFloat:[self borderWidth]] forKey:@"borderWidth"];
		[coder encodeObject:[self borderColor] forKey:@"borderColor"];
		[coder encodeObject:[self titleColor] forKey:@"titleColor"];
		[coder encodeObject:[self gradientStartColor] forKey:@"gradientStartColor"];
		[coder encodeObject:[self gradientEndColor] forKey:@"gradientEndColor"];
		[coder encodeObject:[self backgroundColor] forKey:@"backgroundColor"];
		[coder encodeBool:[self drawsFullTitleBar] forKey:@"drawsFullTitleBar"];
		[coder encodeBool:[self selected] forKey:@"selected"];
		[coder encodeBool:[self drawsGradientBackground] forKey:@"drawsGradientBackground"];
		[coder encodeObject:[self titleAttrs] forKey:@"titleAttrs"];
	} else {
		[coder encodeObject:[NSNumber numberWithFloat:[self borderWidth]]];
		[coder encodeObject:[self borderColor]];
		[coder encodeObject:[self titleColor]];
		[coder encodeObject:[self gradientStartColor]];
		[coder encodeObject:[self gradientEndColor]];
		[coder encodeObject:[self backgroundColor]];
		[coder encodeObject:[NSNumber numberWithBool:[self drawsFullTitleBar]]];
		[coder encodeObject:[NSNumber numberWithBool:[self selected]]];
		[coder encodeObject:[NSNumber numberWithBool:[self drawsGradientBackground]]];
		[coder encodeObject:[self titleAttrs]];
	}
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(NSRect)rect {
	NSLog([[NSNumber numberWithFloat:borderWidth] stringValue]);
	NSLog([titleColor description]);
	NSLog([gradientStartColor description]);
	NSLog([gradientEndColor description]);
	
    // Construct rounded rect path
    NSRect boxRect = [self bounds];
    NSRect bgRect = boxRect;
    bgRect = NSInsetRect(boxRect, borderWidth - 1.0, borderWidth - 1.0);
    int minX = NSMinX(bgRect);
    int midX = NSMidX(bgRect);
    int maxX = NSMaxX(bgRect);
    int minY = NSMinY(bgRect);
    int midY = NSMidY(bgRect);
    int maxY = NSMaxY(bgRect);
    float radius = 4.0;
    NSBezierPath *bgPath = [NSBezierPath bezierPath];
    
    // Bottom edge and bottom-right curve
    [bgPath moveToPoint:NSMakePoint(midX, minY)];
    [bgPath appendBezierPathWithArcFromPoint:NSMakePoint(maxX, minY) 
                                     toPoint:NSMakePoint(maxX, midY) 
                                      radius:radius];
    
    // Right edge and top-right curve
    [bgPath appendBezierPathWithArcFromPoint:NSMakePoint(maxX, maxY) 
                                     toPoint:NSMakePoint(midX, maxY) 
                                      radius:radius];
    
    // Top edge and top-left curve
    [bgPath appendBezierPathWithArcFromPoint:NSMakePoint(minX, maxY) 
                                     toPoint:NSMakePoint(minX, midY) 
                                      radius:radius];
    
    // Left edge and bottom-left curve
    [bgPath appendBezierPathWithArcFromPoint:NSMakePoint(minX, minY) 
                                     toPoint:NSMakePoint(midX, minY) 
                                      radius:radius];
    [bgPath closePath];
    
    
    // Draw background
    
    if ([self drawsGradientBackground]) {
        // Draw gradient background using Core Image
        
        // Wonder if there's a nicer way to get a CIColor from an NSColor...
        CIColor* startColor = [CIColor colorWithRed:[gradientStartColor redComponent] 
                                              green:[gradientStartColor greenComponent] 
                                               blue:[gradientStartColor blueComponent] 
                                              alpha:[gradientStartColor alphaComponent]];
        CIColor* endColor = [CIColor colorWithRed:[gradientEndColor redComponent] 
                                            green:[gradientEndColor greenComponent] 
                                             blue:[gradientEndColor blueComponent] 
                                            alpha:[gradientEndColor alphaComponent]];
        
        CIFilter *myFilter = [CIFilter filterWithName:@"CILinearGradient"];
        [myFilter setDefaults];
        [myFilter setValue:[CIVector vectorWithX:(minX) 
                                               Y:(minY)] 
                    forKey:@"inputPoint0"];
        [myFilter setValue:[CIVector vectorWithX:(minX) 
                                               Y:(maxY)] 
                    forKey:@"inputPoint1"];
        [myFilter setValue:startColor 
                    forKey:@"inputColor0"];
        [myFilter setValue:endColor 
                    forKey:@"inputColor1"];
        CIImage *theImage = [myFilter valueForKey:@"outputImage"];
        
        
        // Get a CIContext from the NSGraphicsContext, and use it to draw the CIImage
        CGRect dest = CGRectMake(minX, minY, maxX - minX, maxY - minY);
        
        CGPoint pt = CGPointMake(bgRect.origin.x, bgRect.origin.y);
        
        NSGraphicsContext *nsContext = [NSGraphicsContext currentContext];
        [nsContext saveGraphicsState];
        
        [bgPath addClip];
        
        [[nsContext CIContext] drawImage:theImage 
                                 atPoint:pt 
                                fromRect:dest];
        
        [nsContext restoreGraphicsState];
    } else {
        // Draw solid color background
        [backgroundColor set];
        [bgPath fill];
    }
    
    
    [borderColor set];
    
    
    // Create drawing rectangle for title
    
    float titleHInset = 6.0;
    float titleVInset = 2.0;
    NSSize titleSize = [[self title] sizeWithAttributes:titleAttrs];
    NSRect titleRect = NSMakeRect(titleHInset + 0, 
                                  (0.0 - titleVInset) + boxRect.size.height - titleSize.height, 
                                  titleSize.width, 
                                  titleSize.height);
    titleRect.size.width = MIN(titleRect.size.width, boxRect.size.width - (2.0 * titleHInset));
    
    
    if ([self selected]) {
        [[NSColor alternateSelectedControlColor] set];
        // We use the alternate (darker) selectedControlColor since the regular one is too light.
        // The alternate one is the highlight color for NSTableView, NSOutlineView, etc.
        // This mimics how Automator highlights the selected action in a workflow.
    } else {
        [borderColor set];
    }
    
    
    // Draw title background
    [[self titlePathWithinRect:bgRect cornerRadius:radius titleRect:titleRect] fill];
    
    
    // Draw title text
    [[self title] drawInRect:titleRect withAttributes:titleAttrs];
    
    
    // Draw rounded rect around entire box
    
    // Set colors again since drawing the title text will have changed the foreground color
    if ([self selected]) {
        [[NSColor alternateSelectedControlColor] set];
    } else {
        [borderColor set];
    }
    
    if (borderWidth > 0.0) {
        [bgPath setLineWidth:borderWidth];
        [bgPath stroke];
    }
}


- (NSBezierPath *)titlePathWithinRect:(NSRect)rect cornerRadius:(float)radius titleRect:(NSRect)titleRect
{
    // Construct rounded rect path
    
    NSRect bgRect = rect;
    int minX = NSMinX(bgRect);
    int maxX = minX + titleRect.size.width + ((titleRect.origin.x - rect.origin.x) * 2.0);
    int maxY = NSMaxY(bgRect);
    int minY = NSMinY(titleRect) - (maxY - (titleRect.origin.y + titleRect.size.height));
    float titleExpansionThreshold = 20.0;
    // i.e. if there's less than 20px space to the right of the short titlebar, just draw the full one.
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    [path moveToPoint:NSMakePoint(minX, minY)];
    
    if (bgRect.size.width - titleRect.size.width >= titleExpansionThreshold && ![self drawsFullTitleBar]) {
        // Draw a short titlebar
        [path appendBezierPathWithArcFromPoint:NSMakePoint(maxX, minY) 
                                       toPoint:NSMakePoint(maxX, maxY) 
                                        radius:radius];
        [path lineToPoint:NSMakePoint(maxX, maxY)];
    } else {
        // Draw full titlebar, since we're either set to always do so, or we don't have room for a short one.
        [path lineToPoint:NSMakePoint(NSMaxX(bgRect), minY)];
        [path appendBezierPathWithArcFromPoint:NSMakePoint(NSMaxX(bgRect), maxY) 
                                       toPoint:NSMakePoint(NSMaxX(bgRect) - (bgRect.size.width / 2.0), maxY) 
                                        radius:radius];
    }
    
    [path appendBezierPathWithArcFromPoint:NSMakePoint(minX, maxY) 
                                   toPoint:NSMakePoint(minX, minY) 
                                    radius:radius];
    
    [path closePath];
    
    return path;
}

#pragma mark -
#pragma mark Accessors

// added accessors for borderWidth so I could call them in finishInstantiate
- (void)setBorderWidth:(float)width
{
	borderWidth = width;
	[self display];
}

- (float)borderWidth
{
	return borderWidth;
}

// added setTitleAttrs so I could call it in finishInstantiate in the palette/framework

- (void)setTitle:(NSString *)newTitle
{
    [super setTitle:newTitle];
    [self display];
}

- (NSDictionary *)titleAttrs
{
	return titleAttrs;
}

- (void)setTitleAttrs:(NSDictionary *)newAttrs
{
	if (titleAttrs != newAttrs) {
		[titleAttrs release];
	}
	titleAttrs = [newAttrs mutableCopy];
	[self display];
	
}
- (BOOL)drawsFullTitleBar
{
    return drawsFullTitleBar;
}


- (void)setDrawsFullTitleBar:(BOOL)newDrawsFullTitleBar
{
    drawsFullTitleBar = newDrawsFullTitleBar;
    [self display];
}


- (BOOL)selected
{
    return selected;
}


- (void)setSelected:(BOOL)newSelected
{
    selected = newSelected;
	[self display];
}


- (NSColor *)borderColor
{
    return borderColor;
}


- (void)setBorderColor:(NSColor *)newBorderColor
{
    [newBorderColor retain];
    [borderColor release];
    borderColor = newBorderColor;
	[self display];
}


- (NSColor *)titleColor
{
    return titleColor;
}


- (void)setTitleColor:(NSColor *)newTitleColor
{
	// I have no idea why this is coming in nil sometimes!
	if (newTitleColor == nil)
		newTitleColor = [NSColor whiteColor];
	
	[newTitleColor retain];
    [titleColor release];
    titleColor = newTitleColor;
    
    [titleAttrs setObject:newTitleColor forKey:NSForegroundColorAttributeName];
    
	[self display];
}

// added this to continue supporting NSBox's ability to change the title font 
// this method simply passes the call up the chain, but saves the font in the attributes
- (void)setTitleFont:(NSFont *)newTitleFont
{
	[super setTitleFont:newTitleFont];
	[titleAttrs setObject:newTitleFont forKey:NSFontAttributeName];
}

- (NSColor *)gradientStartColor
{
    return gradientStartColor;
}


- (void)setGradientStartColor:(NSColor *)newGradientStartColor
{
    // Must ensure gradient colors are in NSCalibratedRGBColorSpace, or Core Image gets angry.
    NSColor *newCalibratedGradientStartColor = [newGradientStartColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    [newCalibratedGradientStartColor retain];
    [gradientStartColor release];
    gradientStartColor = newCalibratedGradientStartColor;
    if ([self drawsGradientBackground]) {
		[self display];
    }
}


- (NSColor *)gradientEndColor
{
    return gradientEndColor;
}


- (void)setGradientEndColor:(NSColor *)newGradientEndColor
{
    // Must ensure gradient colors are in NSCalibratedRGBColorSpace, or Core Image gets angry.
    NSColor *newCalibratedGradientEndColor = [newGradientEndColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    [newCalibratedGradientEndColor retain];
    [gradientEndColor release];
    gradientEndColor = newCalibratedGradientEndColor;
    if ([self drawsGradientBackground]) {
		[self display];
    }
}


- (NSColor *)backgroundColor
{
    return backgroundColor;
}


- (void)setBackgroundColor:(NSColor *)newBackgroundColor
{
    [newBackgroundColor retain];
    [backgroundColor release];
    backgroundColor = newBackgroundColor;
    if (![self drawsGradientBackground]) {
		[self display];
    }
}


- (BOOL)drawsGradientBackground
{
    return drawsGradientBackground;
}


- (void)setDrawsGradientBackground:(BOOL)newDrawsGradientBackground
{
    drawsGradientBackground = newDrawsGradientBackground;
	[self display];
}

#pragma mark -
#pragma mark Other

- (BOOL)preservesContentDuringLiveResize
{
    // NSBox returns YES for this, but doing so would screw up the gradients.
    return NO;
}




@end
