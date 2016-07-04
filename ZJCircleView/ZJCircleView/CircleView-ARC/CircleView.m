//
//  CircleView.m
//  轮播图
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 LanOu. All rights reserved.
//

#import "CircleView.h"
#import "CircleCollectionViewCell.h"


@interface CircleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , assign)  BOOL isDrag;
@property (nonatomic , strong)  NSMutableArray *imgArr;
@property (nonatomic , assign)  NSInteger time;
@property (nonatomic , assign)  NSInteger type;
@property (nonatomic , assign)  CGRect collectionframe;
@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame time:(NSInteger)time picNameDataArr:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = 1;
        
        self.collectionframe = frame;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self createCollectionView];
        
        [self createPage];
        
        self.time = time;
        
        self.dataArr = dataArr;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame time:(NSInteger)time;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = 2;
        
        self.collectionframe = frame;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self createCollectionView];
        
        [self createPage];
        
        self.time = time;
        
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    if (dataArr.count) {
        [self dataHandle];
        _page.numberOfPages = dataArr.count;
        [self.collectionView reloadData];
        _collectionView.contentOffset = CGPointMake(self.frame.size.width, 0);
        if (self.timer) {
            [self.timer invalidate];
        }
        [self createTimer];
    }
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = self.collectionframe.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.collectionframe collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    _collectionView.contentOffset = CGPointMake(self.collectionframe.size.width, 0);
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CircleCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
}

- (void)createPage{
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 200) / 2.0, _collectionView.frame.size.height - 40, 200, 40)];
    _page.currentPageIndicatorTintColor = [UIColor whiteColor];
    _page.pageIndicatorTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    _page.userInteractionEnabled = NO;
    [self addSubview:_page];
}

- (void)dataHandle{
    if (self.type == 1) {
        NSMutableArray *tempImgArr = [NSMutableArray array];
        for (NSString *imageName in _dataArr) {
            UIImage *image = [UIImage imageNamed:imageName];
            [tempImgArr addObject:image];
        }
        self.imgArr = [NSMutableArray array];
        [_imgArr addObject:[tempImgArr lastObject]];
        for (UIImage *image in tempImgArr) {
            [_imgArr addObject:image];
        }
        [_imgArr addObject:[tempImgArr firstObject]];
    } else {
        NSMutableArray *tempImgArr = [NSMutableArray array];
        for (NSString *str in _dataArr) {
            NSURL *url = [NSURL URLWithString:str];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            [tempImgArr addObject:image];
        }
        self.imgArr = [NSMutableArray array];
        [_imgArr addObject:[tempImgArr lastObject]];
        for (UIImage *img in tempImgArr) {
            [_imgArr addObject:img];
        }
        [_imgArr addObject:[tempImgArr firstObject]];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.imgView.image = _imgArr[indexPath.item];
    // 图片的填充方式
    cell.imgView.contentMode = UIViewContentModeScaleToFill;
    return cell;
}

#pragma mark - scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_collectionView.contentOffset.x == (_imgArr.count - 1) * self.frame.size.width) {
        _collectionView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (!_isDrag&&self.time) {
        [self.timer invalidate];
        _isDrag = YES;
    }
}

- (void)createTimer{
    if (self.dataArr.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(play) userInfo:nil repeats:YES];
    }
}

- (void)dropTimer{
    if (self.time) {
        [self.timer invalidate];
    }
}

- (void)play{
    if (_collectionView.contentOffset.x == (_imgArr.count - 1) * self.frame.size.width) {
        _collectionView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (_collectionView.contentOffset.x == 0) {
        _collectionView.contentOffset = CGPointMake((_imgArr.count - 2) * self.frame.size.width, 0);
    }
    NSInteger item = (_collectionView.contentOffset.x / self.frame.size.width) + 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionRight) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == (_imgArr.count - 1) * self.frame.size.width) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake((_imgArr.count - 2) * self.frame.size.width, 0);
    }
    _page.currentPage = _collectionView.contentOffset.x / self.frame.size.width - 1;
    [self createTimer];
    _isDrag = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_collectionView.contentOffset.x == (_imgArr.count - 1) * self.frame.size.width) {
        _page.currentPage = 0;
    } else{
        _page.currentPage = _collectionView.contentOffset.x / self.frame.size.width - 1;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger i = 0;
    if (indexPath.item > _dataArr.count ) {
        i = 0;
    } else if (indexPath.item == 0){
        i = _dataArr.count - 1;
    } else {
        i = indexPath.item - 1;
    }
    
    if (_clickBlock) {
        _clickBlock(i);
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
