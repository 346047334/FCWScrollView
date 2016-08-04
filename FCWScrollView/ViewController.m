//
//  ViewController.m
//  FCWScrollView
//
//  Created by 方常伟 on 16/8/4.
//  Copyright © 2016年 方常伟. All rights reserved.
//

#import "ViewController.h"
#import "FCWScrollView.h"
@interface ViewController ()
{
    NSMutableArray * _dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource =  [NSMutableArray arrayWithObjects:
                    @"美女01.jpg",
                    @"美女02.jpg",
                    @"美女03.jpg",
                    @"美女04.jpg",
                    @"美女05.jpg",
                    @"美女06.jpg",
                    @"美女07.jpg",
                    @"美女08.jpg",
                    @"美女09.jpg",
                    @"美女11.jpg",
                    @"美女12.jpg",
                    @"美女13.jpg",
                    @"美女14.jpg",
//                    @"美女15.jpg",
//                    @"美女16.jpg",
//                    @"美女17.jpg",
//                    @"美女18.jpg",
//                    @"美女19.jpg",
//                    @"美女20.jpg",
//                    @"美女21.jpg",
//                    @"美女22.jpg",
//                    @"美女23.jpg",
//                    @"美女24.jpg",
//                    @"美女25.jpg",
                    nil];
    FCWScrollView *scrollView = [[FCWScrollView alloc]initWithDataSource:_dataSource];
    [self.view addSubview:scrollView];
    [scrollView addPageControlWith:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
