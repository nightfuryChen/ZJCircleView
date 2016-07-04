//
//  CircleCollectionViewCell.m
//  轮播图
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 LanOu. All rights reserved.
//

#import "CircleCollectionViewCell.h"

@implementation CircleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    _imgView.frame = layoutAttributes.bounds;
}

@end
