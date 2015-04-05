//
//  PlaceDetailViewController.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "PlaceServiceProvider.h"
#import "Place.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlaceDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // タイトルにプレイス名称を設定
    self.navigationItem.title = self.place.name;

    // マップ画像を URL から読み込み, 表示
    CGSize size = self.mapImageView.bounds.size;
    NSURL* URL = [[PlaceServiceProvider sharedProvider] mapImageURLForPlace:self.place size:size zoomLevel:15];
    
    [self.mapImageView sd_setImageWithURL:URL];
}

@end
