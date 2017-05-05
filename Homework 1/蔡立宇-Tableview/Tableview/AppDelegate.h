//
//  AppDelegate.h
//  Tableview
//
//  Created by john on 5/2/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UINavigationController *navigationController;//if I donnot set it as a property,how could I reference it from the tableview controller?

@end

