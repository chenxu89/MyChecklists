//
//  ListDetailViewController.h
//  MyChecklists
//
//  Created by 陈旭 on 5/6/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;

- (void)listDetailViewController:(ListDetailViewController *)controller
        DidFinishAddingChecklist:(Checklist *)checklist;
- (void)listDetailViewController:(ListDetailViewController *)controller
       DidFinishEditingChecklist:(Checklist *)checklist;
@end

@interface ListDetailViewController : UITableViewController<UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate>delegate;
@property (nonatomic, weak) IBOutlet Checklist *checklistToEdit;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
