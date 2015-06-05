//
//  AllListsViewController.m
//  MyChecklists
//
//  Created by 陈旭 on 5/5/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "DataModel.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.dataModel sortChecklists];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
    
    if (index >=0 && index < [self.dataModel.lists count]) {
        Checklist *checklist = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

//configure cell for each row
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    int count = [checklist countUncheckedItems];
    if ([checklist.items count] == 0) {
        cell.detailTextLabel.text = @"No Item";
    }else if(count == 0){
        cell.detailTextLabel.text = @"All Done!";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaning", count];
    }
    
    cell.imageView.image = [UIImage imageNamed:checklist.iconName];
                
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    
}

//show or add checklist
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
        ChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    }else if([segue.identifier isEqualToString:@"AddChecklist"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

//edit checklist
- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    
    controller.delegate = self;
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    controller.checklistToEdit = checklist;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

//delete checklist
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

//定义listDetailViewController的delegate的methods
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller
        DidFinishAddingChecklist:(Checklist *)checklist
{

    [self.dataModel.lists addObject:checklist];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller
       DidFinishEditingChecklist:(Checklist *)checklist
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//navigation controller's delegate method
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedChecklist:-1];
    }
}


@end

