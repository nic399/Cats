//
//  SearchViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-24.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "SearchViewController.h"
#import "Photo.h"
#import "SharedData.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong, readwrite) NSMutableString *searchTagsStr;
@property (nonatomic, strong, readwrite) NSMutableArray<Photo *> *photoObjectsArr;

@end

@implementation SearchViewController

- (IBAction)savePressed:(id)sender {
    if (![[self.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
        if (self.searchTagsStr.length > 0) {
            [self.searchTagsStr appendString:@"+"];
        }
        
        [self.searchTagsStr appendString:self.searchTextField.text];
        self.searchTextField.text = @"";
        
    }
    NSLog(@"Search Terms: %@", self.searchTagsStr);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchTagsStr = [NSMutableString new];
    self.photoObjectsArr = [NSMutableArray new];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)home:(UIBarButtonItem *)sender {
    if (self.searchTagsStr.length > 0) {
        [self getImagesFromFlickr];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self.delegate showView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getImagesFromFlickr {
    NSString *searchStr = [self.searchTagsStr stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlStr = [NSString stringWithFormat:@"%@search&%@&api_key=%@&tags=%@&has_geo=1&extras=url_m&per_page=100", kAPI_REST_REQUEST_PHOTO, kAPI_JSON_OPTIONS, kAPI_KEY, searchStr];
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
        for (NSDictionary *thisPhoto in self.photosArr) {
            Photo *photo = [[Photo alloc] initWithDict:thisPhoto];
            
            [self.photoObjectsArr addObject:photo];
        }
        self.delegate.photoObjectsArr = self.photoObjectsArr;

        dispatch_async(dispatch_get_main_queue(), ^{
            // This will run on the main queue
            
            NSLog(@"stat: %@", [self.flickrData objectForKey:@"stat"]);
            NSLog(@"PhotosArr count: %ld", (unsigned long)self.photosArr.count);
            [self.navigationController popToRootViewControllerAnimated:YES];

//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//
//                [self backgroundCoordinateLoading:0];
//            });
            
        });
        
    }]; // 5
    
    [dataTask resume]; // 6
}

-(void)backgroundCoordinateLoading:(int)next {
    if (next < self.photoObjectsArr.count) {
        [self.photoObjectsArr[next] coordinate];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self backgroundCoordinateLoading:next+1];
        });
    }
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
