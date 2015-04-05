//
//  PlaceListViewController.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import "PlaceListViewController.h"
#import "PlaceDetailViewController.h"
#import "SearchOptionViewController.h"
#import "PlaceServiceProvider.h"
#import "Place.h"
#import "Geometry.h"
#import "Location.h"
#import <Realm/Realm.h>
@import MapKit;

@interface PlaceListViewController ()

@property (strong, nonatomic) NSArray* places;

@end

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self reloadPlaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doSearch:(UIStoryboardSegue*)segue
{
    // 検索オプションを取得
    SearchOptionViewController* searchOptionViewController = segue.sourceViewController;
    NSDictionary* options = searchOptionViewController.options;
    CLLocationCoordinate2D center = [options[@"center"] MKCoordinateValue];
    NSInteger radius = [options[@"radius"] integerValue];
    NSString* keyword = options[@"keyword"];

    // プレイス検索パラメータを構築して検索実行
    NSDictionary* params = @{
        @"location": [NSString stringWithFormat:@"%.6f,%.6f", center.latitude, center.longitude],
        @"radius": [NSString stringWithFormat:@"%ld", radius],
        @"types": @"",
        @"keyword": keyword ?: @""
    };
    
    [[PlaceServiceProvider sharedProvider] searchPlaceWithParameters:params completionHandler:^(NSArray *places, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.places = places;
            [self.tableView reloadData];
            [self reloadPlaces];
        }
    }];
}

- (IBAction)cancelSearch:(UIStoryboardSegue*)segue
{
    
}

- (void)reloadPlaces
{
    RLMRealm* realm = [RLMRealm defaultRealm];
    RLMResults* results = [Place allObjectsInRealm:realm];
    NSMutableArray* places = [NSMutableArray arrayWithCapacity:results.count];
    for (Place* place in results) {
        [places addObject:place];
    }
    self.places = places;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.places) ? self.places.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Place* place = self.places[indexPath.row];
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.6f, %.6f", place.geometry.location.lat, place.geometry.location.lng];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // 詳細画面にプレイス情報を渡す
        UITableViewCell* cell = sender;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        
        PlaceDetailViewController* placeDetailViewController = (PlaceDetailViewController*)segue.destinationViewController;
        placeDetailViewController.place = self.places[indexPath.row];
    }
}

@end
