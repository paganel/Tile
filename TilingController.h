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

#import <Foundation/Foundation.h>
#import "TilingStrategy.h"

@interface TilingController : NSObject

@property (nonatomic)id<TilingStrategy> tilingStrategy;
@property (readonly) NSMutableArray *strategies;
@property (readonly) Area *toplevelArea;
@property (readonly) NSSize screenResolution;

+ (TilingController *)sharedInstance;

- (void)addStrategy:(id<TilingStrategy>)aStrategy;
- (void)addWindow:(Window *)w;
- (void)discoverScreens;

@end
