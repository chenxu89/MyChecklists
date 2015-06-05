//
//  IconPickerViewController.m
//  MyChecklists
//
//  Created by 陈旭 on 5/7/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "IconPickerViewController.h"
#import "Checklist.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController
{
    NSArray *_icons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose Icon";
    
    _icons = @[@"No Icon",@"Appointments",@"Birthdays",@"Chores",@"Drinks",
               @"Folder",@"Groceries",@"Inbox",@"Photos",@"Trips"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [_icons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell" forIndexPath:indexPath];
    
    NSString *icon = _icons[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:icon];
    cell.textLabel.text = icon;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate iconPicker:self didPickIcon:_icons[indexPath.row]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
