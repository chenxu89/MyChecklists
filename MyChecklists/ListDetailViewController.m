//
//  ListDetailViewController.m
//  MyChecklists
//
//  Created by 陈旭 on 5/6/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"
#import "IconPickerViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *_iconName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.checklistToEdit != nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        _iconName = self.checklistToEdit.iconName;
    }else{
        self.title = @"Add Checklist";
    }
    self.iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender{
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        checklist.iconName = _iconName;
        [self.delegate listDetailViewController:self DidFinishAddingChecklist:checklist];
    }else{
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = _iconName;
        [self.delegate listDetailViewController:self DidFinishEditingChecklist:self.checklistToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return indexPath;
    }else{
        return nil;
    }
    
}

//textField 发生变化后doneBarButton是否enabled
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender{
    if ([segue.identifier isEqualToString:@"IconPIcker"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
    // Set this in the view controller that is pushing on to the stack so that the back button displays Back instead of the root view controller name
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)iconPicker:(IconPickerViewController *)picker
       didPickIcon:(NSString *)iconName{
    _iconName = iconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        _iconName = @"Folder";
    }
    return self;
}
@end
