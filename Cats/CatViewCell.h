//
//  CatViewCell.h
//  Cats
//
//  Created by Nicholas Fung on 2017-10-23.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end
