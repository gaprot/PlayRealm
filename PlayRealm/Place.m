//
//  Place.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import "Place.h"

@implementation Place

+ (NSString*)primaryKey {
    return @"id";
}

+ (NSDictionary*)defaultPropertyValues
{
    // Google Places API のレスポンスに rating が含まれない場合がある
    return @{@"rating": @(0)};
}

@end
