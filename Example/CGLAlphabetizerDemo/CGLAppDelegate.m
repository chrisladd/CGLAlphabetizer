//
//  CGLAppDelegate.m
//  CGLAlphabetizerDemo
//
//  Created by Chris Ladd on 4/26/14.
//  Copyright (c) 2014 Chris Ladd. All rights reserved.
//

#import "CGLAppDelegate.h"
#import "CGLContactParser.h"
#import "CGLContactsTableViewController.h"

@implementation CGLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    CGLContactsTableViewController *contactsViewController = [[CGLContactsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    NSArray *contacts = [CGLContactParser contactsWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"humans-in-space" ofType:@"txt"]];
    contactsViewController.contacts = contacts;
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:contactsViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
