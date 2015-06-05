//
//  ItemDetailViewController.h
//  MyChecklists
//
//  Created by 陈旭 on 5/3/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;

- (void)itemDetailViewController:(ItemDetailViewController *)controller
          DidFinishAddingItem:(ChecklistItem *)item;

- (void)itemDetailViewController:(ItemDetailViewController *)controller
         DidFinishEditingItem:(ChecklistItem *)item;

@end


@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ItemDetailViewControllerDelegate>delegate;
@property (strong, nonatomic) ChecklistItem *itemToEdit;
@property (weak, nonatomic) IBOutlet UISwitch *switchControll;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;



- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
