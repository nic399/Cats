//
//  Photo.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "Photo.h"
#import "SharedData.h"

@interface Photo ()

@property (nonatomic, strong, readonly) NSDictionary *photoDict;
@property (nonatomic, assign, readonly) NSInteger farm;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;

@end



@implementation Photo

@synthesize coordinate = _coordinate;

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
        _subtitle = @"";
        _thumbnail = nil;
        //_coordinate = [self getCoordinate];
    }
    return self;
}

-(CLLocationCoordinate2D)getCoordinate {
    if (self.coordinate.latitude != 0.00 || self.coordinate.longitude != 0.00) {
        return self.coordinate;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@geo.getLocation&api_key=%@&photo_id=%@&%@", kAPI_REST_REQUEST_PHOTO, kAPI_KEY, self.photoId, kAPI_JSON_OPTIONS];
    NSURL *geoURL = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:geoURL]; // 2

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *geoData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        NSDictionary *locationData = [[geoData objectForKey:@"photo"] objectForKey:@"location"];
        NSString *lon = [locationData objectForKey:@"longitude"];
        NSString *lat = [locationData objectForKey:@"latitude"];
        NSLog(@"longitude: %@, latitude:%@", lon, lat);
        CLLocationCoordinate2D photoLoc = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^()
        {
            // This will run on the main queue
            NSLog(@"%@, %@", lon, lat);
            _coordinate = photoLoc;
        }];
        
    }]; // 5
    
    [dataTask resume]; // 6
    return self.coordinate;
}

-(UIImage *)getPhoto {
    if (_photoImage == nil) {
        _photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self getimageURL]]];
        [self getCoordinate];
    }
    return _photoImage;
}

-(NSURL *)getimageURL {
    NSString *url = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%@/%@_%@.jpg", self.farm, self.server, self.photoId, self.secret];
    NSURL *photoURL = [NSURL URLWithString:url];
    
    return  photoURL;
}

-(UIImage *)getThumbnail {
    if (_thumbnail == nil) {
        _thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self getThumbnailURL]]];
        [self getCoordinate];
    }
    return _thumbnail;
}

-(NSURL *)getThumbnailURL {
    NSString *url = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%@/%@_%@_t.jpg", self.farm, self.server, self.photoId, self.secret];
    NSURL *thumbnailURL = [NSURL URLWithString:url];
    
    return  thumbnailURL;
    
}

@end


























