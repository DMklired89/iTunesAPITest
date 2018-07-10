//
//  TableViewCell.m
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVTableViewCell.h"

@implementation EDVTableViewCell

// Button for player
- (IBAction)playAction:(id)sender {
    if (self.onPlayTap) {
        self.onPlayTap();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
