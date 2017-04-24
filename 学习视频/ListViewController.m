//
//  ListViewController.m
//  login
//
//  Created by Paul Jackson on 21/08/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import "ListViewController.h"

#import "DetailViewController.h"

@interface ListViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) NSArray *cellList;
@property (strong, nonatomic) NSMutableArray *cellFilterList;
@property (strong, nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope;
@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.searchBar.showsScopeBar = false;
    [self.searchBar sizeToFit];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"videosample" ofType:@"plist"];
    self.cellList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [self filterContentForSearchText:@"" scope:-1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Content Filtering
-(void) filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope{
    if (searchText.length == 0) {
        self.cellFilterList = [NSMutableArray arrayWithArray:self.cellList];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    tempArray = [self.cellList filteredArrayUsingPredicate:scopePredicate];
    self.cellFilterList = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellFilterList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.cellFilterList objectAtIndex:row];
    NSString *name = [rowDict objectForKey:@"name"];
    cell.textLabel.text = name;
    
    NSString *imagePath = [rowDict objectForKey:@"image"];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    NSString *description = [rowDict objectForKey:@"description"];
    cell.detailTextLabel.text = description;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsScopeBar = true;
    [self.searchBar sizeToFit];
    return true;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsScopeBar = false;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self filterContentForSearchText:self.searchBar.text scope:-1];
    self.searchBar.showsScopeBar = false;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:self.searchBar.text scope:-1];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        NSDictionary *selectedDataDic = [self.cellList objectAtIndex:selectedIndex];
        detailViewController.dataDic = selectedDataDic;
    }
}

- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:self.username, @"username", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification" object:nil userInfo:datadic];
    }];
}

@end
