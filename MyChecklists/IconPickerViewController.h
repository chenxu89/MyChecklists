//
//  IconPickerViewController.h
//  MyChecklists
//
//  Created by 陈旭 on 5/7/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

- (void)iconPicker:(IconPickerViewController *)picker
       didPickIcon:(NSString *)iconName;
@end


@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id <IconPickerViewControllerDelegate>delegate;

@end
