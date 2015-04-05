//
//  SearchOptionMapViewController.h
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

/**
 *  検索オプションの中心地点選択画面.
 */
@interface SearchOptionMapViewController : UIViewController

@property (strong, nonatomic) void (^centerChanged)(CLLocationCoordinate2D coordinate);

@end
