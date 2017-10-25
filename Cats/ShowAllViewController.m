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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //    //////// PIN
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myId"];
    if (!pinView)
    {
        Photo *photo = annotation;
        // If an existing pin view was not available, create one.
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myId"];
        pinView.canShowCallout = YES;
        pinView.pinTintColor = [UIColor redColor];
        
//        UIButton* toDetailViewButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [toDetailViewButton addTarget:self
//                               action:@selector(toDetailViewPressed)
//                     forControlEvents:UIControlEventTouchUpInside];
//        pinView.rightCalloutAccessoryView = toDetailViewButton;
        
        // Add an image to the left callout.
        UIImageView *iconView = [[UIImageView alloc] initWithImage:photo.thumbnail];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        pinView.leftCalloutAccessoryView = iconView;
    }
    return pinView;
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
