//
//  SearchViewController.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-24.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

@protocol ShowImagesDelegate <NSObject>

@property (nonatomic, strong, readwrite) NSMutableArray<Photo *> *photoObjectsArr;

-(void)showView;

@end

@interface SearchViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) NSDictionary *flickrData;
@property (nonatomic, strong, readwrite) NSArray *photosArr;
@property (nonatomic, weak, readwrite) id<ShowImagesDelegate> delegate;


@end
