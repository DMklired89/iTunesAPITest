//
//  SongAttributes.h
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDVSong: NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSURL *imageURL;
// Audio
@property (nonatomic, strong) NSURL *audioURL;

// Имя исполнителя трека
@property (strong, nonatomic) NSString *artistName;
// Альбом трека
@property (strong, nonatomic) NSString *collectionName;
// SearchBar
@property (strong, nonatomic) NSMutableArray *itemsArray;

-(id) initWithAllSongsAttributes: (NSDictionary *) songsAttributes;

@end
