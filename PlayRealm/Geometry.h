//
//  Geometry.h
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <Realm/RLMObject.h>
@class Location;

/**
 *  ジオメトリモデル.
 */
@interface Geometry : RLMObject

@property Location* location;

@end
