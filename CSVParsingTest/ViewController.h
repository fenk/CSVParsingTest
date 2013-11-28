//
//  ViewController.h
//  CSVParsingTest
//
//  Created by Jacek Grygiel on 26/11/13.
//  Copyright (c) 2013 Jacek Grygiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end
