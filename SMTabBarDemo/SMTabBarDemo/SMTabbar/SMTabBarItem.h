//
//  SMTabBarItem.h
//  SMTabBarDemo
//
//  Created by SmileSun on 16-5-26.
//  Copyright (c) 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SMTabBarItemType)
{
    SMTabBarItemNormalType = 0,
    SMTabBarItemCenterType,
};


@interface SMTabBarItem : UIButton

@property(nonatomic,assign) SMTabBarItemType tabBarItemType;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(SMTabBarItemType)tabBarItemType;
@end
