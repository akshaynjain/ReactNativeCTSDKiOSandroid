#import <RCTAppDelegate.h>
#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>
#import <Expo/Expo.h>
#import <CleverTap.h>
#import <UserNotifications/UserNotifications.h>
#import <CTNotificationService/CTNotificationService.h>
#import <CleverTapSDK/CleverTapURLDelegate.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate,UNUserNotificationCenterDelegate,CleverTapURLDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic,strong) NSDictionary *resp;

@end

