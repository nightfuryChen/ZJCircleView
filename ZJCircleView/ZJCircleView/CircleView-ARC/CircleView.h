//
//  CircleView.h
//  轮播图
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 LanOu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void(^ClickBlock)(NSInteger);

@interface CircleView : UIView

/// 本地图片
- (instancetype)initWithFrame:(CGRect)frame time:(NSInteger)time picNameDataArr:(NSArray *)dataArr;

/// 网络图片 图片未知
- (instancetype)initWithFrame:(CGRect)frame time:(NSInteger)time;

@property (nonatomic , strong)  UICollectionView *collectionView;
@property (nonatomic , strong)  NSArray *dataArr;
@property (nonatomic , strong)  UIPageControl *page;
@property (nonatomic , strong)  NSTimer *timer;

@property (nonatomic , copy)  ClickBlock clickBlock;

- (void)createTimer;

- (void)dropTimer;

@end
