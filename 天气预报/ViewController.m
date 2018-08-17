//
//  ViewController.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/13.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ViewController.h"
#import "AddCityViewController.h"
#import "WeatherShowView.h"
#import "SearchCityViewController.h"
@interface ViewController ()<UIScrollViewDelegate, AddCityViewControllerDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, copy)NSString *cityString;
@property (nonatomic, strong)NSMutableArray *cityNameMutableArray;
//@property (nonatomic, copy) NSArray *addCityArray;
@property (nonatomic, strong)NSMutableArray *addNewCityMutableArray;

@end

@implementation ViewController

- (void)changeCityArray:(NSMutableArray *)newCityArray
{
    if(newCityArray.count == 0){
        return;
    }
    NSLog(@"%@qqqqqqq",newCityArray);
    for(int i = 0;i < newCityArray.count;i++){
        NSString *str = nil;
        for(int j = 0;j < _cityNameMutableArray.count;j++){
            if(![newCityArray[i] isEqualToString:_cityNameMutableArray[j]]){
                str = newCityArray[i];
            }
    }
        if(str){
            [_cityNameMutableArray addObject:str];
        }
    }
    //[_cityNameMutableArray addObjectsFromArray:newCityArray];
    NSLog(@"%@kkkkkkk",_cityNameMutableArray);
    NSUInteger count = self.cityNameMutableArray.count;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*self.cityNameMutableArray.count, [UIScreen mainScreen].bounds.size.height - 50);
    
    for(int i = (int)_cityNameMutableArray.count - (int)newCityArray.count;i < _cityNameMutableArray.count;i++){
        WeatherShowView *weather = [[WeatherShowView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width , self.scrollView.frame.size.height - 50 ) andCityName:self.cityNameMutableArray[i]];
        [self.scrollView addSubview:weather];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*(count-1), 0) animated:NO];
    
    self.pageControl.numberOfPages = self.cityNameMutableArray.count;
    int page = self.scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.pageControl.currentPage = page;
    NSLog(@"%lddgh",self.addNewCityMutableArray.count);
    NSLog(@"%@", _cityNameMutableArray);
    NSLog(@"%ldaaaa",_cityNameMutableArray.count);
}
- (void)changeSelect:(NSUInteger)select
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*select, 0)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.54f blue:0.75f alpha:1.00f];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
    footView.backgroundColor = [UIColor colorWithRed:0.27f green:0.60f blue:0.78f alpha:1.00f];
    footView.userInteractionEnabled = YES;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(360, 5, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:rightButton];
    [self.view addSubview:footView];
    
    _cityNameMutableArray = [NSMutableArray arrayWithObjects:@"西安",@"宝鸡",@"北京", nil];
    _addNewCityMutableArray = [NSMutableArray array];
    [_cityNameMutableArray addObjectsFromArray:_addNewCityMutableArray];
    
    NSLog(@"%@", _cityNameMutableArray);
    NSLog(@"%ldccc",_cityNameMutableArray.count);
    [self loadScrollerView];
    
    NSUInteger count = _cityNameMutableArray.count;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 5, 150, 20)];
    _pageControl.numberOfPages = count;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [footView addSubview:_pageControl];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)loadScrollerView
{
    NSUInteger count = _cityNameMutableArray.count;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50)];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, [UIScreen mainScreen].bounds.size.height - 50);
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    for(int i = 0;i < count;i++){
        WeatherShowView *newView  = [[WeatherShowView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) andCityName:_cityNameMutableArray[i]];
        //NSLog(@"%@",newView.tableView);
        [_scrollView addSubview:newView];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
- (void)addClick
{
    NSLog(@"fsg");
    AddCityViewController *new = [[AddCityViewController alloc] init];
    new.delegate  = self;
    new.middleMutablearray = _cityNameMutableArray;
    [self presentViewController:new animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
