//
//  DataModel.h
//  MyChecklists
//
//  Created by 陈旭 on 5/6/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveChecklists;

- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(NSInteger)index;

- (void)sortChecklists;

+ (NSInteger)nextChecklistItemId;

@end
