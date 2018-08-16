//
//  WeatherShowView.h
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadTableViewCell.h"
#import "EverydayTableViewCell.h"
#import "FootTableViewCell.h"

@interface WeatherShowView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataMuatbleArray;
@property (nonatomic, copy)NSDictionary *secondDictionary;
@property (nonatomic, strong)NSMutableArray *dataSecondArray;
@property (nonatomic, copy)NSDictionary *oneDayDictionary;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, strong)NSMutableArray *timeMutableArray;
@property (nonatomic, strong)NSMutableArray *weatherMutableArray;
@property (nonatomic, strong)NSMutableArray *imgMutableArray;
@property (nonatomic, strong)UILabel *label;


- (void)creatpost;
- (void)creatTableView;
- (instancetype)initWithFrame:(CGRect)frame andCityName:(NSString *)cityName;
@end
