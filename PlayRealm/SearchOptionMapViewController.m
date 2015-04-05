//
//  SearchOptionMapViewController.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import "SearchOptionMapViewController.h"
@import MapKit;

@interface SearchOptionMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SearchOptionMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ユーザの現在位置を表示
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // マップの中心位置をコールバック
    if (self.centerChanged) {
        self.centerChanged(mapView.region.center);
    }
}

@end
