/*
 * This file is part of the Tile project.
 *
 * Copyright 2009-2012 Crazor <crazor@gmail.com>
 *
 * Tile is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Tile is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Tile.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "Area.h"
#import "Window.h"

@implementation Area
{
	NSMutableArray  *children;
	NSRect          rect;
    BOOL            verticallySplit;
}

@synthesize children;
@synthesize rect;
@synthesize verticallySplit;

static NSWindow *overlay;


// TODO: Especially the ToplevelArea should really really acquire its rect and
// origin dynamically from NSScreen, since they are subject to changes, e.g.
// when the Dock is switched from/to autohide.
- (id)initWithRect:(NSRect)r
{
	if ((self = [super init]))
	{
		children = [[NSMutableArray alloc] init];
		rect = r;
		NSLog(@"Creating Area with origin: %@, size: %@", NSStringFromPoint(r.origin), NSStringFromSize(r.size));
	}
	return self;
}

- (void)dealloc
{
	[self children];
}

- (int)width
{
	return [self rect].size.width;
}

- (int)height
{
	return [self rect].size.height;
}

- (void)drawOverlay
{
	NSRect contentRect = [NSWindow contentRectForFrameRect:rect styleMask:NSBorderlessWindowMask];
	overlay = [[NSWindow alloc] initWithContentRect:contentRect
                                          styleMask:NSBorderlessWindowMask
                                            backing:NSBackingStoreBuffered
                                              defer:NO];
	[overlay setBackgroundColor:[NSColor lightGrayColor]];
	[overlay setOpaque:NO];
	[overlay setLevel:NSMainMenuWindowLevel + 1]; //Alternative: NSFloatingWindowLevel
	[overlay setAlphaValue:0.4];
	[overlay setHasShadow:NO];
	[overlay setIgnoresMouseEvents:YES];
	[overlay makeKeyAndOrderFront:overlay];
}

- (void)addChild:(Window *)w
{
	[children addObject:w];
    [w setArea:self];
	[self resizeChildren];
}

- (void)removeChild:(Window *)w
{
    [children removeObject:w];
    [self resizeChildren];
}

- (void)resizeChildren
{
    if ([children count] == 0)
        return;
    
    if (verticallySplit)
    {
        int heightPerWindow = [self height] / [children count];
        
        int i = 0;
        for (Window *w in children)
        {
            NSRect newRect;
            newRect.size.width = [self width];
            newRect.size.height = heightPerWindow;
            
            NSPoint newOrigin = rect.origin;
            newOrigin.y += i++ * heightPerWindow;
            
            newRect.origin = newOrigin;
            
            [w setRect:newRect];
        }
    }
    else
    {
        int widthPerWindow = [self width] / [children count];
        
        int i = 0;
        for (Window *w in children)
        {
            NSRect newRect;
            newRect.size.width = widthPerWindow;
            newRect.size.height = [self height];
            
            NSPoint newOrigin = rect.origin;
            newOrigin.x += i++ * widthPerWindow;
            
            newRect.origin = newOrigin;
            
            [w setRect:newRect];
        }
    }
}

@end
