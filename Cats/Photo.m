//
//  Photo.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "Photo.h"

@interface Photo ()

@property (nonatomic, strong, readonly) NSDictionary *photoDict;
@property (nonatomic, assign, readonly) NSInteger farm;
@property (nonatomic, strong, readonly) NSString *photoId;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;

@end

@implementation Photo

-(instancetype)initWithDict:(NSDictionary *)photoDict {
    self = [super init];
    if (self) {
        _photoDict = photoDict;
        _photoId = [_photoDict objectForKey:@"id"];
        _owner = [_photoDict objectForKey:@"owner"];
        _secret = [_photoDict objectForKey:@"secret"];
        _server = [_photoDict objectForKey:@"server"];
        _title = [_photoDict objectForKey:@"title"];
        NSNumber *farm = [_photoDict objectForKey:@"farm"];
        _farm = [farm integerValue];
        _photoImage = nil;
    }
    return self;
}

-(UIImage *)getPhoto {
    if (_photoImage == nil) {
        _photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self getURL]]];
    }
    return _photoImage;
}

-(NSURL *)getURL {
    NSString *url = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%@/%@_%@.jpg", self.farm, self.server, self.photoId, self.secret];
    NSURL *photoURL = [NSURL URLWithString:url];
    
    return  photoURL;
}

@end


























