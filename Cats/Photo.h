//
//  Photo.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, getter=getPhoto) UIImage *photoImage;
@property (nonatomic, strong, readonly) NSString *photoId;


-(instancetype)initWithDict:(NSDictionary *)photoDict;

@end
