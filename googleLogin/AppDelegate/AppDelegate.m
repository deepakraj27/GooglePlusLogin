//
//  AppDelegate.m
//  googleLogin
//
//  Created by Deepakraj Murugesan on 09/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "AppDelegate.h"
#define kClientID @"1067267679621-h4a1jdc5s8dtm5iigruharokk5nl5kq9.apps.googleusercontent.com"

@interface AppDelegate (){
    UIStoryboard *mainStoryboard;
    UIViewController *homeScreen;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GIDSignIn sharedInstance].clientID = kClientID;
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginType"]isEqualToString: @"Gmail"])
    {
        /*setting the Gmail login to dashboard starts*/
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                   bundle: nil];
        homeScreen = (UIViewController*)[mainStoryboard
                                               instantiateViewControllerWithIdentifier: @"Dashboard"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = homeScreen;
        [self.window makeKeyAndVisible];
        /*setting the Gmail login to dashboard ends*/
        
    }
    
    
   else{
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                   bundle: nil];
        homeScreen = (UIViewController*)[mainStoryboard
                                         instantiateViewControllerWithIdentifier: @"home"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = homeScreen;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
