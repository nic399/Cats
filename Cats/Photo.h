//
//  Photo.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, getter=getPhoto, nullable) UIImage *photoImage;
@property (nonatomic, strong, readonly, nullable) NSString *photoId;

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;


-(instancetype _Nonnull )initWithDict:(NSDictionary *_Nonnull)photoDict;

@end
