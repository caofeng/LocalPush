//
//  ViewController.m
//  LocationPush
//
//  Created by Caofeng on 2018/7/4.
//  Copyright © 2018年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNiti:) name:@"LOCATIONPUSH" object:nil];
    
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    if (settings.types == UIUserNotificationTypeNone) {
        NSLog(@"未打开通知");
    } else {
        NSLog(@"打开通知权限");
    }
}

- (void)receiveNiti:(NSNotification *)notice {
    
    self.contentLabel.text = notice.userInfo[@"name"];
}


- (IBAction)buttonClick:(id)sender {
    
     if (@available(iOS 10.0, *)) {
         
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         
         [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
             if (granted) {
               
                 UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                 content.title = @"通知标题通知标题通知标题通知标题通知标题通知标题通知标题通知标题通知标题通知标题通知标题通知标题";
                 content.subtitle = @"通知子标题通知子标题通知子标题通知子标题通知子标题通知子标题通知子标题通知子标题通知子标题通知子标题";
                 content.badge = @1;
                 content.body = @"通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容通知内容";
                 content.userInfo = @{@"name":@"caofeng",@"url":@"https://www.baidu.com"};
//                 content.launchImageName = @"icon.png";
                 content.sound =[UNNotificationSound defaultSound];
                 
                 NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"icon_4" withExtension:@"png"];
                 UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
                 content.attachments = @[attachment];
                 
                 content.categoryIdentifier = @"categoryIdentifier";
                 
                 UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30 repeats:NO];
                 
                 UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"categoryIdentifier" content:content trigger:trigger];
                 
                 [center addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                     if (!error) {
                         NSLog(@"已成功加入通知请求");
                     } else {
                         NSLog(@"出错");
                     }
                 }];
             }
         }];
         
     } else {
         //测试本地推送
         UILocalNotification *localNotification = [[UILocalNotification alloc]init];
         localNotification.alertBody = @"本地通知测试";
//         localNotification.alertLaunchImage = @"icon.png";  就是icon图标
         localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:30];
         localNotification.alertAction = @"别磨蹭了";
         localNotification.userInfo = @{@"name":@"caofeng",@"url":@"https://www.zyxr.com"};
         localNotification.category = @"abc";
         localNotification.applicationIconBadgeNumber = 1;
         localNotification.soundName = UILocalNotificationDefaultSoundName;
         [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
     }
}

- (void)cancelLocalPush {
    
   NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *noti in localNotifications) {
       NSDictionary *userInfo = noti.userInfo;
        if (userInfo) {
           NSString *name = userInfo[@"name"];
            if (name) {
                [[UIApplication sharedApplication] cancelLocalNotification:noti];
            }
        }
    }
}


@end
