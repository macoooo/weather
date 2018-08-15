//
//  SearchCityViewController.h
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchCityViewControllerDelegate <NSObject>
- (void)changeCityArray:(NSMutableArray *)newCityArray;
@end

@interface SearchCityViewController : UIViewController
@property (nonatomic, weak)id <SearchCityViewControllerDelegate> delegate;

@property (nonatomic, strong)NSMutableArray *middleMutablearray;
@property (nonatomic, copy)NSArray *cityArray;
@end
