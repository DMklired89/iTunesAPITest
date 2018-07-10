//
//  TableViewCell.h
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDVTableViewCell : UITableViewCell

// Labels for track name, price and artist
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;

@property (strong, nonatomic) void(^onPlayTap)();

@end
