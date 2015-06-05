//
//  ViewController.m
//  MyChecklists
//
//  Created by 陈旭 on 5/2/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.checklist sortItems];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.checklist.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}

//两个configure method将item（data）的两个property（text和checked）数据传递给cell（view）
- (void)configureCheckmarkForCell:(UITableViewCell *)cell
                withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if (item.checked){
        label.text = @"√";
    }else{
        label.text = @"";
    }
    label.textColor = self.view.tintColor;
}
- (void)configureTextForCell:(UITableViewCell *)cell
           withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
    //label.text = [NSString stringWithFormat:@"%ld: %@", (long)item.itemId, item.text];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    UILabel *dueDateLabel = (UILabel *)[cell viewWithTag:1002];
    if (item.shouldRemind && [item.dueDate compare:[NSDate date]] == NSOrderedDescending && !item.checked) {
        dueDateLabel.text = [formatter stringFromDate:item.dueDate];
    }else{
        dueDateLabel.text = @"";
    }

}


//cellForRowAtIndexPath:和didSelectRowAtIndexPath:是UITableView自带的两个delegate method
//给tableview的每个row配置一个cell,并在cell中显示row的内容
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通过identifier找到对应cell，并重新启用它，放入tableview
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];

    //通过indexPath.row提取self.checklist.items的item，并给cell配置好这些item对应的两个性质
    ChecklistItem *item = self.checklist.items[indexPath.row];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [self configureTextForCell:cell withChecklistItem:item];
    
    return cell;
}

//点击row后checkmark变化
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = self.checklist.items[indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [self configureTextForCell:cell withChecklistItem:item];
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//删除一个item和对应的row
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

//告诉ItemDetailViewController，它的delegate是ChecklistViewController，当然你需要先找到ItemDetailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = self.checklist.items[indexPath.row];
    }
    
}


//定义delegate的methods
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//将新增的item放入self.checklist.items，并插入一个row用于显示新增的item，最后关闭ItemDetailViewController
- (void)itemDetailViewController:(ItemDetailViewController *)controller
             DidFinishAddingItem:(ChecklistItem *)item
{
    
    NSInteger newRowIndex = [self.checklist.items count];
    [self.checklist.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller
            DidFinishEditingItem:(ChecklistItem *)item
{
    NSInteger index = [self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
