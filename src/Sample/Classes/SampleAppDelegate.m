//
//  SampleAppDelegate.m
//  Sample
//
//  Created by Kirby Turner on 2/8/10.
//  Copyright White Peak Software Inc 2010. All rights reserved.
//

#import "SampleAppDelegate.h"
#import "RootViewController.h"
#import "LocalImageRootViewController.h"

@implementation SampleAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];

   UINavigationController *newNavController;   
   
   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
      RootViewController *newController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
      [newController setWindow:window];
      newNavController = [[UINavigationController alloc] initWithRootViewController:newController];
   } else {
      LocalImageRootViewController *newController = [[LocalImageRootViewController alloc] init];
      newNavController = [[UINavigationController alloc] initWithRootViewController:newController];
   }
   
   [[newNavController navigationBar] setBarStyle:UIBarStyleBlack];
   [[newNavController navigationBar] setTranslucent:YES];

   [window addSubview:[newNavController view]];
   
    // Override point for customization after application launch
    [window makeKeyAndVisible];
   
   return YES;
}




@end
