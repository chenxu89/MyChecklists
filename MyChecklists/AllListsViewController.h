//
//  AllListsViewController.h
//  MyChecklists
//
//  Created by 陈旭 on 5/5/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end
