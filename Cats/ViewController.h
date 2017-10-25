//
//  ViewController.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, ShowImagesDelegate>

@property (nonatomic, strong, readwrite) NSMutableArray<Photo *> *photoObjectsArr;

@end

