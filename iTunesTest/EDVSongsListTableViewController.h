//
//  SongsListTableViewController.h
//  iTunesTest
//
//  Created by Dmitry Edrenov on 13.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDVSongsListTableViewController : UITableViewController <NSURLSessionDelegate, UISearchBarDelegate>

// Свойство для searchBar
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
