//
//  SMTabBar.m
//  SMTabBarDemo
//
//  Created by SmileSun on 16-5-26.
//  Copyright (c) 2016年 companyName. All rights reserved.
//

#import "SMTabBar.h"
#import "SMTabBarItem.h"
@implementation SMTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}
-(void)configure
{
    //设置背景以及上面的白色条
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH, 5)];
    topLine.image = [UIImage imageNamed:@"tapbar_top_line"];
    [self addSubview:topLine];
}
-(void)setSelectedIndex:(NSUInteger)index
{
    //从数组中找出tabbar然后设置选中状态
    for (SMTabBarItem * item in self.tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
        }else{
            item.selected = NO;
        }
    }
    
    //设置tabbar控制器的索引
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
    if (tabBarController) {
        tabBarController.selectedIndex = index;
    }
}
#pragma mark - Touch Event
-(void)itemSelected:(SMTabBarItem *)item
{
    if (item.tabBarItemType != SMTabBarItemCenterType) {
        [self setSelectedIndex:item.tag];
    }else
    {
        NSLog(@"中间的点击了");
//        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidSelectedAtCenter)]) {
//            [self.delegate tabBarDidSelectedAtCenter];
//        }
        NSLog(@"%@",self.delegate);
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedAtCenter)]) {
                [self.delegate tabBarDidSelectedAtCenter];
            }
        }
    }
}

#warning mark -- Setter (tabbar数组) 这个才是核心代码
//重写set方法
-(void)setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    NSInteger itemTag = 0;
    for (id item in tabBarItems) {
        if ([item isKindOfClass:[SMTabBarItem class]]) {
            //默认第一个tabbar为选中状态
            if (itemTag == 0) {
                ((SMTabBarItem *)item).selected = YES;
            }
#warning mark -- 添加方法
            [((SMTabBarItem *)item) addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:item];
            if (((SMTabBarItem *)item).tabBarItemType != SMTabBarItemCenterType) {
                ((SMTabBarItem *)item).tag = itemTag;
                itemTag ++;
            }
        }

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
