//
//  ChecklistItem.m
//  MyChecklists
//
//  Created by 陈旭 on 5/2/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"
#import <UIKit/UIKit.h>

@implementation ChecklistItem


- (void)toggleChecked
{
    self.checked = !self.checked;
    if (self.checked) {
        self.shouldRemind = NO;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind  forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemID"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])){
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

- (void)scheduleNotification{
    
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        //NSLog(@"Found an existing notification %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] == NSOrderedDescending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.dueDate;
        localNotification.alertBody = self.text;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        localNotification.userInfo = @{@"ItemID" : @(self.itemId)};
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        //NSLog(@"Scheduled notification %@ for itemId %ld", localNotification, (long)self.itemId);
        
    }
}

- (UILocalNotification *)notificationForThisItem{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotifications) {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if (number != nil && [number integerValue] == self.itemId) {
            return notification;
        }
    }
    return nil;
}

- (void)dealloc{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        //NSLog(@"removing existing Notification %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}

- (NSComparisonResult)compare:(ChecklistItem *)otherItem{
    return [self.dueDate compare:otherItem.dueDate];
}
@end
