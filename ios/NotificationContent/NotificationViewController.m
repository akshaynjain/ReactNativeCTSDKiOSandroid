//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by Akshaya Jain on 25/07/23.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

//- (void)didReceiveNotification:(UNNotification *)notification {
//  NSLog(@"didReceiveNotification");
////    self.label.text = notification.request.content.body;
////}
////
////// optional: implement to get user event type data
////- (void)userDidPerformAction:(NSString *)action withProperties:(NSDictionary *)properties {
////    NSLog(@"user did perform action: %@ with props: %@", action , properties);
////}
////
////// optional: implement to get notification response
////- (void)userDidReceiveNotificationResponse:(UNNotificationResponse *)response {
////    NSLog(@"user did receive notification response: %@:", response);
////}


@end
