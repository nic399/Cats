//
//  ShowAllViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-24.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ShowAllViewController.h"
#import "Photo.h"

@interface ShowAllViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.mapType = MKMapTypeStandard;
    [self.mapView setZoomEnabled: true];
    [self.mapView setRotateEnabled:true];
    [self.mapView setScrollEnabled:true];
    [self.mapView setShowsScale:true];
    self.mapView.delegate = self;
    
    [self.mapView addAnnotations:self.photoArr];
    [self.mapView showAnnotations:self.photoArr animated:true];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
