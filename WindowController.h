/*
 * This file is part of the Tile project.
 *
 * Copyright 2009-2013 Crazor <crazor@gmail.com>
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

@class UIElement;
@class Application;
@class Window;

@interface WindowController : NSObject

@property(readonly)   NSMutableArray  *applications;

+ (WindowController *)sharedInstance;

- (NSArray *)windows;
- (void)populateAppList;
- (void)registerWithNotificationCenter;

- (void)addApp:(NSRunningApplication *)application;
- (void)removeApp:(NSRunningApplication *)application;

- (void)appLaunched:(NSNotification *)notification;
- (void)appTerminated:(NSNotification *)notification;

- (Application *)applicationFromElement:(UIElement *)e;

- (Window *)focusedWindow;
- (void)lockCurrentWindow;
- (void)maximizeCurrentWindow;
- (void)centerCurrentWindow;

@end
