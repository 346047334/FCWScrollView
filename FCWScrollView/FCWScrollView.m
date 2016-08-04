//
//  FCWScrollView.m
//  FCWScrollView
//
//  Created by 方常伟 on 16/8/4.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import "FCWScrollView.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IMAGEVIEW_COUNT 3
@interface FCWScrollView()<UIScrollViewDelegate>

{
    UIImageView  * _leftImageView;
    UIImageView  * _centerImageView;
    UIImageView  * _rightImageView;
    int _currentImageIndex;
    int _imageCount;
}

@end
@implementation FCWScrollView

-(instancetype)initWithDataSource:(NSMutableArray *)imageData{
    if (self = [super init]) {
        _imageData = [NSMutableArray array];
        _imageData = imageData;
        _imageCount = (int)_imageData.count;
        self.frame = [UIScreen mainScreen].bounds;
        self.delegate = self;
        //设置contentSize
        self.contentSize=CGSizeMake(IMAGEVIEW_COUNT*SCREEN_WIDTH, SCREEN_HEIGHT) ;
        //设置当前显示的位置为中间图片
        [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        //设置分页
        self.pagingEnabled=YES;
        //去掉滚动条
        self.showsHorizontalScrollIndicator=NO;
        
        [self addImageViews];
        [self setDefaultImage];
//        [self addPageControl];
    }
    return self;
}
#pragma mark 添加分页控件
-(void)addPageControlWith:(UIViewController *)superView{
    _pageControl=[[UIPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size= [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-50);
    //设置颜色
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor cyanColor];
    //设置总页数
    _pageControl.numberOfPages=_imageCount;
    [superView.view addSubview:_pageControl];
}

-(void)addImageViews{
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_leftImageView];
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _centerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_centerImageView];
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_rightImageView];
    
}
-(void)setDefaultImage{
    //加载默认图片
    _leftImageView.image=[UIImage imageNamed:_imageData[_imageCount -1]];
    _centerImageView.image=[UIImage imageNamed:_imageData[0]];
    _rightImageView.image=[UIImage imageNamed:_imageData[1]];
    _currentImageIndex=0;
    //设置当前页
    _pageControl.currentPage=_currentImageIndex;
}
//将要开始减速的时候禁止交互，停止后开启交互，避免连续拖动导致scrollViewDidEndDecelerating不会被连续调用引起的bug
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.userInteractionEnabled = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.userInteractionEnabled = YES;
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    //设置分页
    _pageControl.currentPage=_currentImageIndex;
}
-(void)reloadImage{
    int leftImageIndex,rightImageIndex;
    CGPoint offset=[self contentOffset];
    if (offset.x>SCREEN_WIDTH) { //向右滑动
        _currentImageIndex=(_currentImageIndex+1)%_imageCount;
    }else if(offset.x<SCREEN_WIDTH){ //向左滑动
        _currentImageIndex=(_currentImageIndex+_imageCount-1)%_imageCount;
    }
    //UIImageView *centerImageView=(UIImageView *)[_scrollView viewWithTag:2];
    _centerImageView.image=[UIImage imageNamed:_imageData[_currentImageIndex]];
    
    //重新设置左右图片
    leftImageIndex=(_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex=(_currentImageIndex+1)%_imageCount;
    _leftImageView.image=[UIImage imageNamed:_imageData[leftImageIndex]];
    _rightImageView.image=[UIImage imageNamed:_imageData[rightImageIndex]];
}
@end
