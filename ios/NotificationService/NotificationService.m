//
//  NotificationService.m
//  NotificationService
//
//  Created by Akshaya Jain on 25/07/23.
//

#import "NotificationService.h"
//#import <clevertap-react-native/CleverTapReactManager.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService



- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
  NSLog(@"Push Template Recieved \(%@)", request.content.userInfo);
//    self.contentHandler = contentHandler;
//    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
//    self.contentHandler(self.bestAttemptContent);
  
//  [[CleverTap sharedInstance] recordNotificationViewedEventWithData:request.content.userInfo];
  [super didReceiveNotificationRequest:request withContentHandler:contentHandler];
}

//- (void)serviceExtensionTimeWillExpire {
//    // Called just before the extension will be terminated by the system.
//    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//    self.contentHandler(self.bestAttemptContent);
//}

@end
