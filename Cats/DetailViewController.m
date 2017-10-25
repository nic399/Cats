//
//  DetailViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"
#import <SafariServices/SafariServices.h>
#import "SharedData.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation DetailViewController
- (IBAction)viewOnlinePressed:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"%@getInfo&api_key=%@&photo_id=%@&%@", kAPI_REST_REQUEST_PHOTO, kAPI_KEY, self.photo.photoId, kAPI_JSON_OPTIONS];
    NSURL *detailURL = [NSURL URLWithString:urlStr];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:detailURL]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *photoInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        NSArray *urlArr = [[[photoInfo objectForKey:@"photo"] objectForKey:@"urls"] objectForKey:@"url"];
        NSLog(@"There should be 1 item: %ld", urlArr.count);
        
        NSString *photoURLStr = [urlArr[0] objectForKey:@"_content"];
        NSLog(@"%@", photoURLStr);
        NSURL *photoURL = [NSURL URLWithString:photoURLStr];
        dispatch_async(dispatch_get_main_queue(), ^{
            // This will run on the main queue
            
            SFSafariViewController *viewOnline = [[SFSafariViewController alloc] initWithURL:photoURL];
            [self presentViewController:viewOnline animated:true completion:nil];
        });
        
    }]; // 5
    
    [dataTask resume]; // 6
    
    
    
    
    
    
    
    //    SFSafariViewController *viewOnline = [[SFSafariViewController alloc] initWithURL:detailURL];
    //    [self showViewController:viewOnline sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailImageView.image = self.photo.photoImage;
    self.navigationItem.title = self.photo.title;
    //[self.photo coordinate];
    //NSLog(@"lat: %f, lon: %f", self.photo.coordinate.latitude, self.photo.coordinate.latitude);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
