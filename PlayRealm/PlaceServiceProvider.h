//
//  PlaceServiceProvider.h
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;

/**
 * プレイス検索を提供.
 */
@interface PlaceServiceProvider : NSObject

+ (instancetype)sharedProvider;

/**
 *  プレイス検索を行う.
 *
 *  @param params            Google Place API 仕様に基づくパラメータ.
 *  @param completionHandler 検索完了時のコールバックハンドラ.
 */
- (void)searchPlaceWithParameters:(NSDictionary*)params completionHandler:(void (^)(NSArray* places, NSError* error))completionHandler;

/**
 *  マップ画像の URL を求める.
 *
 *  @param place     プレイス情報.
 *  @param size      画像サイズ.
 *  @param zoomLevel ズームレベル.
 *
 *  @return 画像取得 URL を返す.
 */
- (NSURL*)mapImageURLForPlace:(Place*)place
                         size:(CGSize)size
                    zoomLevel:(int)zoomLevel;

@end
