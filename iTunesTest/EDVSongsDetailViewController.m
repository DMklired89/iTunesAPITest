//
//  SongsDetailViewController.m
//  iTunesTest
//
//  Created by Dmitry Edrenov on 15.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVSongsDetailViewController.h"
#import "EDVSong.h"
#import "EDVNetworkService.h"

@interface EDVSongsDetailViewController ()

// Label для цены трека
@property (weak, nonatomic) IBOutlet UILabel *trackPriceLabel;
// Label для названия трека
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
// Label для имени исполнителя трека
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
// Label для альбома трека
@property (weak, nonatomic) IBOutlet UILabel *collectionNameLabel;
// Обложка альбома
@property (weak, nonatomic) IBOutlet UIImageView *albumCover;


@end

@implementation EDVSongsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Перенос данных из табличного контроллера
    self.trackPriceLabel.text = [NSString stringWithFormat: @"%@$", self.song.price];
    self.trackNameLabel.text = self.song.name;
    self.artistNameLabel.text = self.song.artistName;
    self.collectionNameLabel.text = self.song.collectionName;

    // Если есть предзагруженная картинка..
    if (self.preloadedImage) {
        self.albumCover.image = self.preloadedImage;
    } else {
        // Загрузить, если нет предварительно загруженной
        __weak typeof(self) weakSelf = self;
        [EDVNetworkService loadImageByURL:self.song.imageURL completion:^(UIImage *image) {
            weakSelf.albumCover.image = image;
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
