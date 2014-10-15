//
//  ZCActionOnCalendar.m
//  事件加入到日历
//
//  Created by ZhangCheng on 14-4-26.
//  Copyright (c) 2014年 张诚. All rights reserved.
//

#import "ZCActionOnCalendar.h"
#import <EventKit/EventKit.h>
@implementation ZCActionOnCalendar
+ (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location isReminder:(BOOL)isReminder{
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //6.0及以上通过下⾯面⽅方式写⼊入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        //等待用户是否同意授权日历
        //EKEntityMaskEvent提醒事项参数（该参数只能真机使用）  EKEntityTypeEvent日历时间提醒参数
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                }else if (!granted)
                {
                    //被⽤用户拒绝,不允许访问⽇日历
                    
                }else{
                    //事件保存到⽇日历
                    //创建事件
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    event.title = eventTitle;
                    event.location = location;
                    //设定事件开始时间
                    //[NSDate dateWithTimeIntervalSinceNow:10];
                    event.startDate=startData;
                    
                    //设定事件结束时间
                    //[NSDate dateWithTimeIntervalSinceNow:20];
                    event.endDate=endDate;
                    //添加提醒 可以添加多个，设定事件多久以前开始提醒
                    // event.allDay = YES;
                    //在事件前多少秒开始事件提醒-5.0f
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    NSLog(@"保存成功");
                    
                    
                    
                    
                    
                    //是否写入提醒事项，提醒事项为iOS原生自带的，但是模拟器没有的
                    if (isReminder) {
                        EKCalendar * iDefaultCalendar = [eventStore defaultCalendarForNewReminders];
                        
                        EKReminder *reminder=[EKReminder reminderWithEventStore:eventStore];
                        reminder.calendar=[eventStore defaultCalendarForNewReminders];
                        
                        reminder.title=eventTitle;
                        reminder.calendar = iDefaultCalendar;
                        EKAlarm *alarm=[EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
                        [reminder addAlarm:alarm];
                        NSError *error=nil;
                        
                        
                        [eventStore saveReminder:reminder commit:YES error:&error];
                        if (error) {
                            
                            NSLog(@"error=%@",error);
                            
                        }
                        
                    }
                }
                
            });
        }];
        
    }else{
        //4.0和5.0通过下述⽅方式添加 无需判断用户是否同意访问日历
        //事件保存到⽇日历
        //创建事件
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        event.title = eventTitle;
        event.location = location;
        //设定事件开始时间
        //[NSDate dateWithTimeIntervalSinceNow:10];
        event.startDate=startData;
        
        //设定事件结束时间
        //[NSDate dateWithTimeIntervalSinceNow:20];
        event.endDate=endDate;
        //添加提醒 可以添加多个，设定事件多久以前开始提醒
        // event.allDay = YES;
        //在事件前多少秒开始事件提醒-5.0f
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        NSLog(@"保存成功");
        
        //是否写入提醒事项，提醒事项为iOS原生自带的，但是模拟器没有的
        if (isReminder) {
            EKCalendar * iDefaultCalendar = [eventStore defaultCalendarForNewReminders];
            
            EKReminder *reminder=[EKReminder reminderWithEventStore:eventStore];
            reminder.calendar=[eventStore defaultCalendarForNewReminders];
            
            reminder.title=eventTitle;
            reminder.calendar = iDefaultCalendar;
            EKAlarm *alarm=[EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
            [reminder addAlarm:alarm];
            NSError *error=nil;
            
            
            [eventStore saveReminder:reminder commit:YES error:&error];
            if (error) {
                
                NSLog(@"error=%@",error);
                
            }
            
        }
        
    }
}

@end
