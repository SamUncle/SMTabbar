//
//  ViewController.m
//  SMTabBarDemo
//
//  Created by SmileSun on 16-5-26.
//  Copyright (c) 2016年 companyName. All rights reserved.
//

#import "ViewController.h"
#import "SMTabBar.h"
#import "SMTabBarItem.h"
//#import "FirstViewController.h"
//#import "SecondViewController.h"
//#import "ThirdViewController.h"
//#import "FourViewController.h"


@interface ViewController ()<UIActionSheetDelegate,SMTabBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray * array = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourViewController"];
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        Class aClass = NSClassFromString(array[i]);
        UIViewController * vc = [[aClass alloc]init];
        [viewControllers addObject:vc];
    }
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    SMtabBarVC = tabBarVC;
    tabBarVC.viewControllers = viewControllers;
    
    //移除tabBar顶部的阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGRect bounds = tabBarVC.tabBar.bounds;
#pragma mark -- 注册设备通知
#warning mark -- 此方法未完善底部tabbar的布局问题,如果项目没有横屏需求可忽略此方法
    /**********************          SmileSun               ********************/
    //注册状态栏状态通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusDidChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    //注册设备旋转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidChanged:) name:UIDeviceOrientationDidChangeNotification object:nil ];
    /**********************          SmileSun              ********************/
    
    SMTabBar * tabBar = [[SMTabBar alloc]initWithFrame:bounds];
    _tabBar = tabBar;
#warning mark -- 布局tabbar (可自己调试一下)
    CGFloat normalButtonWidth = (SCREEN_WIDTH * 3 / 4) / 4;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = (SCREEN_WIDTH / 4);
    
    SMTabBarItem *homeItem = [[SMTabBarItem alloc] initWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"home_normal"
                                     selectedImageName:@"home_highlight" tabBarItemType:SMTabBarItemNormalType];
    SMTabBarItem *sameCityItem = [[SMTabBarItem alloc] initWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"同城"
                                           normalImageName:@"mycity_normal"
                                         selectedImageName:@"mycity_highlight" tabBarItemType:SMTabBarItemNormalType];
    //中间的tabbar
    SMTabBarItem *publishItem = [[SMTabBarItem alloc] initWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                    title:@"发布"
                                          normalImageName:@"post_normal"
                                        selectedImageName:@"post_normal" tabBarItemType:SMTabBarItemCenterType];
    
    SMTabBarItem *messageItem = [[SMTabBarItem alloc] initWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"消息"
                                          normalImageName:@"message_normal"
                                        selectedImageName:@"message_highlight" tabBarItemType:SMTabBarItemNormalType];
    SMTabBarItem *mineItem = [[SMTabBarItem alloc] initWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我的"
                                       normalImageName:@"account_normal"
                                     selectedImageName:@"account_highlight" tabBarItemType:SMTabBarItemNormalType];
    
    tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
    tabBar.delegate = self;
    
    [tabBarVC.tabBar addSubview:tabBar];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    keyWindow.rootViewController = tabBarVC;
    
    
}
#pragma mark -- 废弃的方法(已经调到封装的tabbar里面)
//此方法我已放到自定义tabbar里面,在这里将不再使用
- (SMTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(SMTabBarItemType)tabBarItemType
{
    
    SMTabBarItem *item = [[SMTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}
#pragma mark -- SMTabbarDelegate (自定义的)
-(void)tabBarDidSelectedAtCenter
{
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"自定义", @"SmileSun", nil];
    
    [actionSheet showInView:viewController.view];
}
#pragma mark -- UIActionSheetDelegate (系统的)
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
}
#pragma mark -- 设备旋转通知
#warning mark -- 此方法未完善底部tabbar的布局问题,如果项目没有横屏需求可忽略此方法
//设备通知(用这个处理横屏)
-(void)deviceDidChanged:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    switch (orientation) {
        case UIDeviceOrientationUnknown:
            NSLog(@"UIDeviceOrientationUnknown  %@",notification.object);
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"UIDeviceOrientationPortrait %@",notification.object);
            
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"UIDeviceOrientationPortraitUpsideDown %@",notification.object);
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"UIDeviceOrientationLandscapeLeft %@",notification.object);
            _tabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SMtabBarVC.tabBar.bounds.size.height);

            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"UIDeviceOrientationLandscapeRight %@",notification.object);
            _tabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, SMtabBarVC.tabBar.bounds.size.height);

            break;
            case UIDeviceOrientationFaceUp:
            NSLog(@"UIDeviceOrientationFaceUp %@",notification.object);
            break;
            case UIDeviceOrientationFaceDown:
            NSLog(@"UIDeviceOrientationFaceDown %@",notification.object);
            break;
        default:
            break;
    }

}
//状态栏通知(在这里不用)
-(void)statusDidChanged:(NSNotification *)notification
{
   UIInterfaceOrientation  orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"UIInterfaceOrientationPortrait");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"UIInterfaceOrientationLandscapeLeft");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"UIInterfaceOrientationLandscapeRight");
            break;
        case UIInterfaceOrientationUnknown:
            NSLog(@"UIInterfaceOrientationUnknown");
            break;
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
