//
//  ViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) NSDictionary *flickrData;
@property (nonatomic, strong, readwrite) NSArray *photosArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getImagesFromFlickr];
}

-(void)getImagesFromFlickr {
    NSString *apiKey = @"6d7a6ca77380a1c3a8d26ed624f98a4a";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=cat", apiKey];
    NSURL *url = [NSURL URLWithString:urlStr]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        self.flickrData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        self.photosArr = [[self.flickrData objectForKey:@"photos"] objectForKey:@"photo"];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            NSLog(@"stat: %@", [self.flickrData objectForKey:@"stat"]);
            NSLog(@"PhotosArr count: %ld", self.photosArr.count);

        }];
        
    }]; // 5
    
    [dataTask resume]; // 6
}

-(NSString *)photoURL{
    
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
