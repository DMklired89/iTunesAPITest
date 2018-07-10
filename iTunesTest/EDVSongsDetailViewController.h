//
//  SongsDetailViewController.h
//  iTunesTest
//
//  Created by Dmitry Edrenov on 15.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVViewController.h"

@class EDVSong;

@interface EDVSongsDetailViewController : EDVViewController

@property (strong, nonatomic) EDVSong *song;
@property (strong, nonatomic) UIImage *preloadedImage;


@end
