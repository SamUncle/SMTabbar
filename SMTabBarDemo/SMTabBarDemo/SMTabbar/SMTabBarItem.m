//
//  SMTabBarItem.m
//  SMTabBarDemo
//
//  Created by SmileSun on 16-5-26.
//  Copyright (c) 2016年 companyName. All rights reserved.
//

#import "SMTabBarItem.h"

@implementation SMTabBarItem

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self contentModeFit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self contentModeFit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self contentModeFit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(SMTabBarItemType)tabBarItemType
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self contentModeFit];
    }
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];
#warning mark -- tabbar标题大小可在这里更改
    self.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateSelected];
    [self setImage:selectedImage forState:UIControlStateHighlighted];
#warning mark -- tabbar标题颜色可在这里更改
    [self setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    self.tabBarItemType = tabBarItemType;
    
    return self;
}
//设置图片的显示方式
-(void)contentModeFit
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //先让tabbar的名字自适应大小
    [self.titleLabel sizeToFit];
    
    //然后获取它的title的size
    CGSize titleSize = self.titleLabel.frame.size;
    //获取正常图片的图片size
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    
    //下面进行判断
    //只有当图片大小存在的情况下
    if (imageSize.width !=0 && imageSize.height != 0) {
        CGFloat centerY = CGRectGetHeight(self.frame) - titleSize.height - 3 - 5 - imageSize.height / 2;// 3 是title与底边的间距  5 是 图和title之间的间距
        self.imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, centerY);
    }else{
        CGPoint center = self.imageView.center;
        center.x = CGRectGetWidth(self.frame) / 2;
        center.y = (CGRectGetHeight(self.frame) - titleSize.height) / 2;
        self.imageView.center = center;
    }
    CGPoint titleCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 3 - titleSize.height / 2);
    
    self.titleLabel.center = titleCenter;
}


//重写系统的高亮状态,此函数里不用写任何代码
-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
