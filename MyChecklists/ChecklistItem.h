//
//  ChecklistItem.h
//  MyChecklists
//
//  Created by 陈旭 on 5/2/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) NSInteger itemId;

- (void)toggleChecked;
- (void)scheduleNotification;

@end
