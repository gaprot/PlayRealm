//
//  Place.h
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <Realm/RLMObject.h>
@class Geometry;

/**
 *  プレイスモデル.
 */
@interface Place : RLMObject

@property Geometry* geometry;
@property NSString* icon;
@property NSString* id;
@property NSString* name;
@property double rating;
@property NSString* reference;
//@property RLMArray<NSString> * types;		// TODO: StringArray は未対応？

@end
