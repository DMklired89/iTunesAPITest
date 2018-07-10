//
//  EDVNetworkService.h
//  iTunesTest
//
//  Created by Dmitry Edrenov on 10.07.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EDVSong;

@interface EDVNetworkService : NSObject

// Метод для получения Images
+(void) loadImageByURL: (NSURL *) urlToLoad completion: (void(^)(UIImage *image)) completion;

// Метод для получения данных с сервера
+(void) fetchAllSongsByName: (NSString *) nameToSearch completion: (void(^)(NSArray *songs)) completion;
@end
