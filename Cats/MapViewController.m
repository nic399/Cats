//
//  MapViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-24.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "MapViewController.h"
#import "Photo.h"
#import "DetailViewController.h"

@interface MapViewController ()

//@property (nonatomic) CLLocationManager *locationManager;
//@property (nonatomic) CLLocation *currentLocation;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.mapType = MKMapTypeStandard;
    [self.mapView setZoomEnabled: true];
    [self.mapView setRotateEnabled:true];
    [self.mapView setScrollEnabled:true];
    [self.mapView setShowsScale:true];
    self.mapView.delegate = self;
    
    Photo *myAnn = self.photo;
    [self.mapView addAnnotation: myAnn];
    
    MKCoordinateRegion myRegion = MKCoordinateRegionMakeWithDistance(myAnn.coordinate, 500, 500);
    
    [self.mapView setRegion:myRegion animated:true];
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
        // If an existing pin view was not available, create one.
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myId"];
        pinView.canShowCallout = YES;
        pinView.pinTintColor = [UIColor redColor];
        
        UIButton* toDetailViewButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [toDetailViewButton addTarget:self
                               action:@selector(toDetailViewPressed)
                     forControlEvents:UIControlEventTouchUpInside];
        pinView.rightCalloutAccessoryView = toDetailViewButton;
        
        // Add an image to the left callout.
        UIImageView *iconView = [[UIImageView alloc] initWithImage:self.photo.thumbnail];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        pinView.leftCalloutAccessoryView = iconView;
    }
    return pinView;
}

-(void)toDetailViewPressed {
    NSLog(@"to details");
    [self performSegueWithIdentifier:@"toDetails" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetailViewController *destination = segue.destinationViewController;
    destination.photo = self.photo;
}


@end





//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    _locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
//
//    _locationManager.delegate = self;
//    [_locationManager requestAlwaysAuthorization];
//
//    NSLog(@"You probably should place this in a separate class and use a singleton for it");
//
//    [_locationManager startUpdatingLocation];


// coordinates


//    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
//    myAnnotation.coordinate = CLLocationCoordinate2DMake(49.281838, -123.108151);
//    [myAnnotation setTitle:@"LHL"];
//    [myAnnotation setSubtitle:@"Where we currently are"];
//    [self.mapView addAnnotation: myAnnotation];


//    [_myMapView addAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>];
// _myMapView showAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#> animated:<#(BOOL)#>










//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
////////// VIEW
//        MKAnnotationView *anView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pinId"];
//        if (!anView)
//        {
//            // If an existing pin view was not available, create one.
//            anView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinId"];
//            anView.canShowCallout = YES;
//            anView.image = [UIImage imageNamed:@"lhlLogo.png"];
//            anView.calloutOffset = CGPointMake(0, 32);
//        }
//        else
//        {
//            anView.annotation = annotation;
//        }
//        return anView;
////    }














//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    CLLocation * loc = [locations lastObject];
//
//    NSLog(@"Time %@, latitude %+.6f, longitude %+.6f currentLocation accuracy %1.2f loc accuracy %1.2f timeinterval %f",[NSDate date],loc.coordinate.latitude,
//          loc.coordinate.longitude,
//          loc.horizontalAccuracy,
//          loc.verticalAccuracy,
//          fabs([loc.timestamp timeIntervalSinceNow]));
//
//    NSTimeInterval locationAge = -[loc.timestamp timeIntervalSinceNow];
//    if (locationAge > 10.0){
//        NSLog(@"locationAge is %1.2f",locationAge);
//        return;
//    }
//
//    if (loc.horizontalAccuracy < 0){
//        NSLog(@"loc.horizontalAccuracy is %1.2f",loc.horizontalAccuracy);
//        return;
//    }
//
//    if (self.currentLocation == nil || self.currentLocation.horizontalAccuracy >= loc.horizontalAccuracy)
//    {
//        self.currentLocation = loc;
//        CLLocationCoordinate2D zoomToLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude,
//                                                                           _currentLocation.coordinate.longitude);
//
//        MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomToLocation, 500, 500);
//
//        [self.mapView setRegion:adjustedRegion animated:YES];
//
//        if (loc.horizontalAccuracy <= self.locationManager.desiredAccuracy)
//        {
//            if ([CLLocationManager locationServicesEnabled])
//            {
//                if (_locationManager)
//                {
//                    [_locationManager stopUpdatingLocation];
//                    NSLog(@"Stop Regular Location Manager");
//                }
//            }
//        }
//    }
//}


