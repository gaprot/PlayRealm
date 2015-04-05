//
//  SearchOptionViewController.m
//  PlayRealm
//
//  Created by Gaprot Dev Team
//  Copyright (c) 2015 Up-frontier, Inc. All rights reserved.
//

#import "SearchOptionViewController.h"
#import "SearchOptionMapViewController.h"
@import MapKit;

@interface SearchOptionViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *centerCellLabel;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@end

@implementation SearchOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    CLLocationCoordinate2D center = [self.options[@"center"] MKCoordinateValue];
    self.centerCellLabel.text = [NSString stringWithFormat:@"(%f, %f)", center.latitude, center.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"chooseCenter"]) {
        // 中心地点選択画面へ
        SearchOptionMapViewController* mapViewController = segue.destinationViewController;
        mapViewController.centerChanged = ^(CLLocationCoordinate2D coordinate) {
            self.options[@"center"] = [NSValue valueWithMKCoordinate:coordinate];
        };
    } else if ([segue.identifier isEqualToString:@"done"]) {
        // 設定完了
        [self.view endEditing:YES];
    }
}

- (NSMutableDictionary*)options
{
    if (!_options) {
        _options = [NSMutableDictionary new];
    }
    return _options;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 入力内容の確定
    [self.view endEditing:YES];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // 入力内容を取得
    if (textField == self.radiusTextField) {
        self.options[@"radius"] = @([self.radiusTextField.text integerValue]);
    } else if (textField == self.keywordTextField) {
        self.options[@"keyword"] = self.keywordTextField.text;
    }
}

@end
