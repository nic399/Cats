//
//  DetailViewController.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface DetailViewController : UIViewController

@property (nonatomic, strong, readwrite) Photo *photo;

@end
