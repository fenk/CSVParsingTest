//
//  ViewController.m
//  CSVParsingTest
//
//  Created by Jacek Grygiel on 26/11/13.
//  Copyright (c) 2013 Jacek Grygiel. All rights reserved.
//

#import "ViewController.h"
#import "CHCSVParser.h"
#import "CDCityData.h"

@interface ViewController ()
@property(nonatomic, strong) NSMutableArray *orginalData;
@property(nonatomic, strong) NSMutableArray *visibleData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"START PARSING");
    [self.indicatorView startAnimating];
    self.orginalData = [NSMutableArray array];
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();

    dispatch_queue_t myQueue = dispatch_queue_create("com.jacekgrygiel.parsing.csv", NULL);
    dispatch_async(myQueue, ^{
        NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:@"GeoLiteCity-Location" ofType:@"csv"];
        NSArray *readFromFile = [NSArray arrayWithContentsOfCSVFile:file];
        for (NSArray *array in readFromFile) {
            CDCityData *cityData = [[CDCityData alloc] init];
            [cityData fillWithArray:array];
            [self.orginalData addObject:cityData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];

            self.visibleData = [self.orginalData mutableCopy];
            [self.tableView reloadData];

            NSLog(@"END PARSING = %f", CFAbsoluteTimeGetCurrent()-startTime);
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table View Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.visibleData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *defaultIdentifier = @"DefaultCellIdentifier";
    
    UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier];
    
    if (defaultCell == nil) {
        defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
    }
    
    CDCityData *cityData = [self.visibleData objectAtIndex:indexPath.row];
    defaultCell.textLabel.text = [NSString stringWithFormat:@"%@ , %@, %@",cityData.name, cityData.country, cityData.region];
    
    return defaultCell;
    
    
}

#pragma mark Search Delegate methods

- (void)resetTableData {
    self.visibleData = nil;
    self.visibleData = [self.orginalData mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchText];
            
            
            self.visibleData = [NSMutableArray arrayWithArray:[self.orginalData filteredArrayUsingPredicate:p]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    } else if(searchText.length == 0){
        [self resetTableData];
    }
}

@end
