//
//  ViewController.h
//  MyChecklists
//
//  Created by 陈旭 on 5/2/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end

