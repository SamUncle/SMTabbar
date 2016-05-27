//
//  SMTabBar.h
//  SMTabBarDemo
//
//  Created by SmileSun on 16-5-26.
//  Copyright (c) 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//设置代理

@protocol SMTabBarDelegate <NSObject>

-(void)tabBarDidSelectedAtCenter;

@end

@interface SMTabBar : UIView

@property(nonatomic,copy) NSArray * tabBarItems;
#warning mark -- 这里代理用retain修饰,用assign修饰会内存泄露,用weak修饰会自动释放,网上看的demo是用weak修饰可以实现,我把实现过程放到了视图控制器,网上是在APPdelegate上实现的
@property(nonatomic,retain) id<SMTabBarDelegate> delegate;

@end
