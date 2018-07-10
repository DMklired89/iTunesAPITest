//
//  SongsListTableViewController.m
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVSongsListTableViewController.h"
#import "EDVTableViewCell.h"
#import "EDVSong.h"
#import "EDVSongsDetailViewController.h"
#import "EDVNetworkService.h"
#import <AVFoundation/AVFoundation.h>

@interface EDVSongsListTableViewController ()  <NSURLSessionDelegate>
// Объект-плеер
@property (nonatomic, strong) AVPlayer *player;
// Массив для песен
@property (nonatomic, strong) NSArray *songs;


@end

@implementation EDVSongsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(refreshSongs) forControlEvents:UIControlEventValueChanged];
    [self.tableView.refreshControl beginRefreshing];
    [self refreshSongs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) refreshSongs {
    __weak typeof(self) weakSelf = self;
    [EDVNetworkService fetchAllSongsByName:@"Muse" completion:^(NSArray *songs) {
        weakSelf.songs = songs;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.refreshControl endRefreshing];
        });
    }];
}


#pragma mark - Table view data source

// Количество секций
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Количество строк в секции.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songs.count;
}

// Ячейки таблицы
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    EDVTableViewCell *cell = (EDVTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    EDVSong *song = [self.songs objectAtIndex: indexPath.row];
    
    // Заполнение ячеек
    cell.nameLabel.text = [NSString stringWithFormat: @"%@", song.name];
    cell.priceLabel.text = [NSString stringWithFormat: @"%@ %@", song.price, song.currency];
    cell.artistNameLabel.text = [NSString stringWithFormat: @"%@ - %@", song.artistName, song.collectionName];
    
    // weak для self.block
    __weak typeof(self) weakSelf = self;

    // Вызов блока onPlayTap для воспроизведения музыки при создании ячейки
    cell.onPlayTap = ^{
        [weakSelf playAudioURL:song.audioURL];
    };
    
    // Заполнение ячеек изображениями в фоновом потоке
    [EDVNetworkService loadImageByURL:song.imageURL completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            EDVTableViewCell *updateCell = (id) [weakSelf.tableView cellForRowAtIndexPath: indexPath];
            if (updateCell) {
                updateCell.imageView.image = image;
            }
        });
    }];

    return cell;
}

#pragma mark - Table Delegate Methods

// Переход на другой экран при нажатии на ячейку
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Объект-новый контроллер
    EDVSongsDetailViewController *songDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"SongDetailViewController"];
   
    EDVSong *song = [self.songs objectAtIndex: indexPath.row];

    // Перенос данных из ячейки на новый экран
    songDetail.song = song;
    
    EDVTableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    // Перенос картинки
    songDetail.preloadedImage = cell.albumImage.image;
    
    [self.navigationController pushViewController: songDetail animated: YES];
}


#pragma mark - UISearchBarDelegate
// Посковик

// При начале редактирования выезжает Cancel (анимированно)
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton: YES animated: YES];
}

// При нажатии Cancel убирается клавиатура
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // убрать клавиатуру
    [searchBar setShowsCancelButton: NO animated: YES];
}

// Фильтрация текста - вызывается когда текст изменился
-(void) searchBar: (UISearchBar *) searchBar textDidChange:(nonnull NSString *)searchText {
    NSLog(@"textDidChange %@", searchText);
}

#pragma mark - AVFoundation
// Воспроизвеление музыки
-(void) playAudioURL: (NSURL *) urlToPlay {
    self.player = [AVPlayer playerWithURL:urlToPlay];
    [self.player play];
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
}

@end
