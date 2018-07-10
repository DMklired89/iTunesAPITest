//
//  SongAttributes.m
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVSong.h"

@implementation EDVSong

-(id) initWithAllSongsAttributes: (NSDictionary *) songsAttributes {
    self = [super init];
    if (self) {
        // Извлечение названия песни по ключу trackName
        _name = [songsAttributes objectForKey: @"trackName"];
        // Извлечение цены песни по ключу trackName
        _price = [songsAttributes objectForKey: @"trackPrice"];
        // Выбор валюты по ключу currency
        _currency = [songsAttributes objectForKey: @"currency"];
        // Имя артиста
        _artistName = [songsAttributes objectForKey: @"artistName"];
        // Название альбома
        _collectionName = [songsAttributes objectForKey: @"collectionName"];
        // Обложка альбома
        NSString *urlString = [songsAttributes objectForKey: @"artworkUrl60"];
        
        // Если есть картинка.. 
        if (urlString) {
            _imageURL = [NSURL URLWithString: urlString];
        }
        
        // Audio
        NSString *urlAudioString = [songsAttributes objectForKey: @"previewUrl"];
        _audioURL = [NSURL URLWithString: urlAudioString];
    }
    return self;
}


@end
