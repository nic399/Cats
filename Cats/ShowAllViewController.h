//
//  ShowAllViewController.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-24.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Photo;

@interface ShowAllViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong, readwrite) NSArray <Photo *> *photoArr;

@end
