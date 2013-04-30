//
//  SMHC_AppDelegate.h
//  NTBELabs
//
//  Created by dai yun on 13-4-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMHC_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - Start-up
- (void)Startup;
- (void)CheckAndCreateDatabae;

#pragma mark - Lauching App with URL 


@end
