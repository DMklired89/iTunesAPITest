//
//  EDVNetworkService.m
//  iTunesTest
//
//  Created by Dmitry Edrenov on 10.07.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVNetworkService.h"
#import "EDVSong.h"

@implementation EDVNetworkService

// Получение данных об Images (с ключом artworkUrl60)
+(void) loadImageByURL: (NSURL *) urlToLoad completion: (void(^)(UIImage *image)) completion {
    // Запрос на сервер
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL: urlToLoad completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData: data];
            completion(image);
        }
    }];
    [task resume];
}


+(void) fetchAllSongsByName: (NSString *) nameToSearch completion: (void(^)(NSArray *songs)) completion {
    // Сессия
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration
                                                                    defaultSessionConfiguration]];
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:@"http://itunes.apple.com/search"];
    components.query = [NSString stringWithFormat:@"term=%@", nameToSearch];
    // Запрос HTTP GET
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL: components.URL
                                            completionHandler: ^(NSData *data, NSURLResponse *responce, NSError *error) {
                                                
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options:0 error:nil]; NSLog(@"%@", json);
                                                // Инициализация массива для песен
                                                NSMutableArray *songs = [[NSMutableArray alloc] init];
                                                // Извлечение из json массива results
                                                NSArray *results = [json objectForKey: @"results"];
                                                // Перечисление по массиву results c созданием объекта
                                                for (NSMutableDictionary *dictionary in results) {
                                                // Объект песня с ее атрибутами
                                                EDVSong *song = [[EDVSong alloc] initWithAllSongsAttributes: dictionary];
                                                // Добавление объекта-песни в массив
                                                [songs addObject: song];
                                                }
                                                completion(songs);
                                            }];
    // resume - запуск
    [dataTask resume];
}



@end
