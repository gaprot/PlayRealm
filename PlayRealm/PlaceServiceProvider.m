//
//  PlaceServiceProvider.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Realm/Realm.h>

#import "PlaceServiceProvider.h"
#import "Place.h"
#import "Geometry.h"
#import "Location.h"

#define GOOGLE_PLACE_API @"https://maps.googleapis.com/maps/api/place/nearbysearch/json"
#define GOOGLE_STATIC_MAP_API @"https://maps.googleapis.com/maps/api/staticmap"

// TODO: Google APIs の API キーを設定
#define GOOGLE_API_KEY @"YOUR-API-KEY"

@implementation PlaceServiceProvider

static PlaceServiceProvider* _sharedProvider;

+ (void)initialize
{
    if ([PlaceServiceProvider class] == self) {
        _sharedProvider = [self new];
    }
}

+ (instancetype)sharedProvider
{
    return _sharedProvider;
}

- (void)searchPlaceWithParameters:(NSDictionary*)params_ completionHandler:(void (^)(NSArray* places, NSError* error))completionHandler
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:params_];
    params[@"language"] = @"ja";
    params[@"key"] = GOOGLE_API_KEY;
    
    [manager GET:GOOGLE_PLACE_API parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        // JSON -> RLMObject Model
        NSArray* results = responseObject[@"results"];
        NSMutableArray* places = [NSMutableArray arrayWithCapacity:results.count];
        RLMRealm* realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
        [realm deleteObjects:[Place allObjectsInRealm:realm]];
        [realm deleteObjects:[Geometry allObjectsInRealm:realm]];
        [realm deleteObjects:[Location allObjectsInRealm:realm]];
        
        for (NSDictionary* result in results) {
            Place* place = [Place createOrUpdateInDefaultRealmWithObject:result];
            [places addObject:place];
        }
        [realm commitWriteTransaction];
        
        if (completionHandler) {
            completionHandler(places, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(@[], error);
        }
    }];
}

- (NSURL*)mapImageURLForPlace:(Place*)place
                         size:(CGSize)size
                    zoomLevel:(int)zoomLevel
{

    NSString* URLString = [NSString stringWithFormat:
        GOOGLE_STATIC_MAP_API \
        @"?center=%f,%f" \
        @"&zoom=%d" \
        @"&size=%gx%g" \
        @"&scale=%g" \
        @"&markers=size:%@|color:%@|%f,%f" \
        @"&key=%@",
        place.geometry.location.lat, place.geometry.location.lng,
        zoomLevel,
        size.width, size.height,
        [UIScreen mainScreen].scale,
        @"mid", @"red", place.geometry.location.lat, place.geometry.location.lng,
        GOOGLE_API_KEY
    ];

    return [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
