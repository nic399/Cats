//
//  DetailViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation DetailViewController
- (IBAction)viewOnlinePressed:(id)sender {
    NSLog(@"View Online");
    NSString *apiKey = @"6d7a6ca77380a1c3a8d26ed624f98a4a";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&format=json&nojsoncallback=1&api_key=%@&tags=cat", apiKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailImageView.image = self.photo.photoImage;
    self.navigationItem.title = self.photo.title;
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
