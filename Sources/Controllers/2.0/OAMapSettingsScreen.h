//
//  OAMapSettingsScreen.h
//  OsmAnd
//
//  Created by Alexey Kulish on 21/02/15.
//  Copyright (c) 2015 OsmAnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OADashboardScreen.h"

typedef NS_ENUM(NSInteger, EMapSettingsScreen)
{
    EMapSettingsScreenUndefined = -1,
    EMapSettingsScreenMain = 0,
    EMapSettingsScreenGpx,
    EMapSettingsScreenMapType,
    EMapSettingsScreenCategory,
    EMapSettingsScreenParameter,
    EMapSettingsScreenSetting,
    EMapSettingsScreenOverlay,
    EMapSettingsScreenUnderlay,
    EMapSettingsScreenLanguage,
    EMapSettingsScreenPreferredLanguage,
    
};

@protocol OAMapSettingsScreen <NSObject, OADashboardScreen, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) EMapSettingsScreen settingsScreen;
@property (nonatomic, assign) BOOL isOnlineMapSource;

@end
