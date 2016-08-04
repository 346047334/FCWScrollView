//
//  FCWScrollView.h
//  FCWScrollView
//
//  Created by 方常伟 on 16/8/4.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCWScrollView : UIScrollView
@property (nonatomic,strong)NSMutableArray *imageData;
@property (nonatomic,strong)UIPageControl  *pageControl;
//初始化scrollView传入图片名数组
-(instancetype)initWithDataSource:(NSMutableArray *)imageData;
//在scrollView俯视图上添加pageControl
-(void)addPageControlWith:(UIViewController *)superView;
@end
