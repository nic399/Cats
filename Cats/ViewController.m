//
//  ViewController.m
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CatViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) NSDictionary *flickrData;
@property (nonatomic, strong, readwrite) NSArray *photosArr;
@property (nonatomic, strong, readwrite) NSMutableArray<Photo *> *photoObjectsArr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoObjectsArr = [NSMutableArray new];
    self.collectionView.allowsMultipleSelection = false;
    self.navigationItem.title = @"Cats";
    // Do any additional setup after loading the view, typically from a nib.
    [self getImagesFromFlickr];
}

-(void)getImagesFromFlickr {
    NSString *apiKey = @"6d7a6ca77380a1c3a8d26ed624f98a4a";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=cat&has_geo=1&extras=url_m&per_page=100", apiKey];
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

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            NSLog(@"stat: %@", [self.flickrData objectForKey:@"stat"]);
            NSLog(@"PhotosArr count: %ld", self.photosArr.count);
            
            [self.collectionView reloadData];
        }];
        
    }]; // 5
    
    [dataTask resume]; // 6
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CatViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    Photo *photo = self.photoObjectsArr[indexPath.row];
    cell.titleLabel.text = photo.title;
    cell.photoImageView.image = photo.getPhoto;
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoObjectsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destination = segue.destinationViewController;
    NSIndexPath *itemPath = self.collectionView.indexPathsForSelectedItems[0];
    destination.photo = self.photoObjectsArr[itemPath.row];
    [self.collectionView deselectItemAtIndexPath:self.collectionView.indexPathsForSelectedItems[0] animated:true];
}

//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
