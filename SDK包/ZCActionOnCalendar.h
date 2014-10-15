//
//  ZCActionOnCalendar.h
//  事件加入到日历
//
//  Created by ZhangCheng on 14-4-26.
//  Copyright (c) 2014年 张诚. All rights reserved.
//
//添加事件到日历以及提醒事项
//使用日历需要添加EvenKit库
// 版本说明 iOS研究院 305044955
/*
1.0版本示例
初始建立 将事件添加到系统日历中，并且添加到提醒事项中
 */
/*代码示例
 NSDate*startData=[NSDate dateWithTimeIntervalSinceNow:10];
 NSDate*endDate=[NSDate dateWithTimeIntervalSinceNow:20];
 //设置事件之前多长时候开始提醒
 float alarmFloat=-5;
 NSString*eventTitle=@"提醒事件标题";
 NSString*locationStr=@"提醒副标题";
 //isReminder 是否写入提醒事项
 [ZCActionOnCalendar saveEventStartDate:startData endDate:endDate alarm:alarmFloat eventTitle:eventTitle location:locationStr isReminder:YES];
 //注意 在参数第十八行需要设置不同的参数，然后进行判断是事件提醒还是日历事件
 //EKEntityMaskEvent提醒事项参数（该参数只能真机使用）  EKEntityTypeEvent日历时间提醒参数

 */
#import <Foundation/Foundation.h>

@interface ZCActionOnCalendar : NSObject
+ (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location isReminder:(BOOL)isReminder;
@end
