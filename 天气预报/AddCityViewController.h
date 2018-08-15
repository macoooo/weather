//
//  AddCityViewController.h
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCityViewControllerDelegate <NSObject>
- (void)changeCityArray:(NSMutableArray *)newCityArray;
@end

@interface AddCityViewController : UIViewController

@property (nonatomic, weak)id <AddCityViewControllerDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *middleMutablearray;
@property (nonatomic, strong)NSMutableArray *cityMutableArray;

@end
