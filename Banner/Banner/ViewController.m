//
//  ViewController.m
//  Banner
//
//  Created by yrc on 2018/4/13.
//  Copyright © 2018年 zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

/** scrollView */
@property (nonatomic, strong) UIScrollView   *scrollView;
/** leftImg */
@property (nonatomic, strong) UIImageView    *leftImg;
/** centerImg */
@property (nonatomic, strong) UIImageView    *centerImg;
/** rightImg */
@property (nonatomic, strong) UIImageView    *rightImg;
/** arr */
@property (nonatomic, copy)   NSArray        *imgArr;
/** index */
@property (nonatomic, assign) NSInteger       currentIndex;
/** timer */
@property (nonatomic, strong) NSTimer        *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imgArr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];

    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.width*0.6);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3*self.view.frame.size.width,_scrollView.frame.size.height);
    [self.view addSubview:_scrollView];
    
    _leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _leftImg.contentMode = UIViewContentModeScaleAspectFill;
    _leftImg.clipsToBounds = YES;
    _leftImg.image = [UIImage imageNamed:_imgArr.lastObject];
    [_scrollView addSubview:_leftImg];
    
    _centerImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _centerImg.contentMode = UIViewContentModeScaleAspectFill;
    _centerImg.clipsToBounds = YES;
    _centerImg.image = [UIImage imageNamed:_imgArr[0]];
    [_scrollView addSubview:_centerImg];
    
    _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _rightImg.contentMode = UIViewContentModeScaleAspectFill;
    _rightImg.clipsToBounds = YES;
    _rightImg.image = [UIImage imageNamed:_imgArr[1]];
    [_scrollView addSubview:_rightImg];
    
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
    [self creatTimer];

    
}


- (void)creatTimer{
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction{
    [_scrollView scrollRectToVisible:CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

// 自动定时器滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 2*self.view.frame.size.width) {
        // 滑到最右边的时候
        _currentIndex ++ ;
        [self resetImages];
        // 重置图片内容、修改偏移量
    }else if (scrollView.contentOffset.x == 0){
        _currentIndex --;
        [self resetImages];
    }
    
}


// 手动滑动停止结束的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 2*self.view.frame.size.width) {
        // 滑到最右边的时候
        _currentIndex ++ ;
        [self resetImages];
        // 重置图片内容、修改偏移量
    }else if (scrollView.contentOffset.x == 0){ // 向右滑动
        
        _currentIndex = _currentIndex + _imgArr.count;
        _currentIndex --;
        
        [self resetImages];
    }
    
}

- (void)resetImages{
    
    NSLog(@"%zd",(_currentIndex)%_imgArr.count);
    
    _leftImg.image = [UIImage imageNamed:_imgArr[(_currentIndex-1)%_imgArr.count]];
    _centerImg.image = [UIImage imageNamed:_imgArr[(_currentIndex)%_imgArr.count]];
    _rightImg.image = [UIImage imageNamed:_imgArr[(_currentIndex+1)%_imgArr.count]];
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0.f);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_timer invalidate];
    _timer = nil;
    
}

// 停止拖动的时候  启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self creatTimer];
}



@end
