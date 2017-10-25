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
#import "MapViewController.h"
#import "SharedData.h"
#import "ShowAllViewController.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) NSDictionary *flickrData;
@property (nonatomic, strong, readwrite) NSArray *photosArr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Cat view loaded");
    self.photoObjectsArr = [NSMutableArray new];
    self.collectionView.allowsMultipleSelection = false;
    self.navigationItem.title = @"Results";
    UIBarButtonItem *showAllButton = [[UIBarButtonItem alloc] initWithTitle:@"Show All" style:UIBarButtonItemStylePlain target:self action:@selector(showAllPressed)];
    self.navigationItem.rightBarButtonItem = showAllButton;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(searchPressed)];
    self.navigationItem.leftBarButtonItem = searchButton;
    // Do any additional setup after loading the view, typically from a nib.
//    [self getImagesFromFlickr];
    [self searchPressed];
    
}

-(void)showView {
    [self backgroundCoordinateLoading:0];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CatViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    Photo *photo = self.photoObjectsArr[indexPath.row];
    cell.titleLabel.text = photo.title;
    cell.photoImageView.image = photo.thumbnail;
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoObjectsArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toMap" sender:self];
}

-(void)searchPressed {
    [self performSegueWithIdentifier:@"toSearch" sender:self];
}

-(void)showAllPressed {
    [self performSegueWithIdentifier:@"toShowAll" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //DetailViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toMap"]) {
        MapViewController *destination = segue.destinationViewController;
        NSIndexPath *itemPath = self.collectionView.indexPathsForSelectedItems[0];
        destination.photo = self.photoObjectsArr[itemPath.row];
        [self.collectionView deselectItemAtIndexPath:self.collectionView.indexPathsForSelectedItems[0] animated:true];
    }
    else if ([segue.identifier isEqualToString:@"toShowAll"]) {
        ShowAllViewController *destination = segue.destinationViewController;
        destination.photoArr = [self.photoObjectsArr copy];
    }
    else if ([segue.identifier isEqualToString:@"toSearch"]) {
        SearchViewController *destination = segue.destinationViewController;
        destination.delegate = self;
    }
}

-(void)backgroundCoordinateLoading:(int)next {
    if (next < self.photoObjectsArr.count) {
        [self.photoObjectsArr[next] coordinate];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self backgroundCoordinateLoading:next+1];
        });
    }
}






@end
