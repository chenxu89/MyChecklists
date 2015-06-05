//
//  Checklist.h
//  MyChecklists
//
//  Created by 陈旭 on 5/5/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *iconName;

- (int)countUncheckedItems;
- (void)sortItems;

@end
