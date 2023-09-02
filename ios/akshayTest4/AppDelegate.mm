#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTLinkingManager.h>

//#import "CleverTap.h"
#import "CleverTapReactManager.h"
//#import <UserNotifications/UserNotifications.h>
//#import <CTNotificationService/CTNotificationService.h>
#import <CleverTapSDK/CleverTapInstanceConfig.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"main"
                                            initialProperties:launchOptions];
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  
  // Add CleverTap Account ID and Account Token in your .plist file)
  // initialize CleverTap
//#ifdef DEBUG
//  [CleverTap setDebugLevel:CleverTapLogDebug];
//#endif
  [CleverTap setDebugLevel:CleverTapLogDebug];
  [CleverTap autoIntegrate];
  [self registerPush];
  [[CleverTapReactManager sharedInstance] applicationDidLaunchWithOptions:launchOptions];
  // Set the URL Delegate
  [[CleverTap sharedInstance]setUrlDelegate:self];
//  [[CleverTap sharedInstance]setUrlDelegate:self];
  
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
     center.delegate = self;
  
  return YES;
}

- (void)registerPush {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  
  UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action_1" title:@"Back" options:UNNotificationActionOptionNone];
  UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action_2" title:@"Next" options:UNNotificationActionOptionNone];
  UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"action_3" title:@"View In App" options:UNNotificationActionOptionNone];
  UNNotificationCategory *cat = [UNNotificationCategory categoryWithIdentifier:@"CTNotification" actions:@[action1, action2, action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
  [center setNotificationCategories:[NSSet setWithObjects:cat, nil]];
  
      
     [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
          if( !error ){
              dispatch_async(dispatch_get_main_queue(), ^(void) {
                  [[UIApplication sharedApplication] registerForRemoteNotifications];
              });
          }
      }];
  
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

/// This method controls whether the `concurrentRoot`feature of React18 is turned on or off.
///
/// @see: https://reactjs.org/blog/2022/03/29/react-v18.html
/// @note: This requires to be rendering on Fabric (i.e. on the New Architecture).
/// @return: `true` if the `concurrentRoot` feature is enabled. Otherwise, it returns `false`.
- (BOOL)concurrentRootEnabled
{
  return true;
}

//Handle Deeplink
-(BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [RCTLinkingManager application:app openURL:url options:options];
    
}

-(BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
  
  
  NSLog(@"%@",userActivity.webpageURL);
  
  return TRUE;
  
}

-(BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType{
  
  return TRUE;
}


-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  NSLog(@"%@: failed to register for remote notifications: %@", self.description, error.localizedDescription);
}

-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  NSLog(@"%@: registered for remote notifications: %@", self.description, deviceToken.description);
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
  NSLog(@"%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo);
  completionHandler();
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"%@: will present notification: %@", self.description, notification.request.content.userInfo);
  [[CleverTap sharedInstance] recordNotificationViewedEventWithData:notification.request.content.userInfo];
    completionHandler(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"%@: did receive remote notification completionhandler: %@", self.description, userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)pushNotificationTappedWithCustomExtras:(NSDictionary *)customExtras{
  NSLog(@"pushNotificationTapped: customExtras: ", customExtras);
}

// CleverTapURLDelegate method
- (BOOL)shouldHandleCleverTapURL:(NSURL *)url forChannel:(CleverTapChannel)channel {
    NSLog(@"Handling URL: \(%@) for channel: \(%d)", url, channel);
    return YES;
}

@end
