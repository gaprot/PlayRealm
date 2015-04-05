//
//  Location.h
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <Realm/RLMObject.h>

/**
 *  ロケーションモデル.
 */
@interface Location : RLMObject

@property double lat;
@property double lng;

@end
