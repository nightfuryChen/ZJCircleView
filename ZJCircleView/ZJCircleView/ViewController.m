//
//  ViewController.m
//  ZJCircleView
//
//  Created by Chen on 16/7/4.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 网络图片
//    CircleView *circleView = [[CircleView alloc] initWithFrame:self.view.frame time:3];
    
    NSArray *imgArr = @[@"S1.jpg",@"S2.jpg",@"S3.jpg",@"S4.jpg",@"S5.jpg",@"S6.jpg"];
    
    // 本地图片初始化方法
    CircleView *circleView = [[CircleView alloc] initWithFrame:self.view.frame time:3 picNameDataArr:imgArr];
    // 添加点击方法
    circleView.clickBlock = ^(NSInteger i){
        NSLog(@"点击的是第几张图片%ld",i);
    };
    
    [self.view addSubview:circleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
