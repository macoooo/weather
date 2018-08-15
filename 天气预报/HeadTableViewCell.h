//
//  HeadTableViewCell.h
//  天气预报
//
//  Created by 强淑婷 on 2018/8/13.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *cityLabel;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *temperatureLabel;
@property (nonatomic, strong)UILabel *weekLabel;
@property (nonatomic, strong)UILabel *nowdayLabel;
@property (nonatomic, strong)UILabel *highTemperatureLabel;
@property (nonatomic, strong)UILabel *lowTemperatureLabel;

@end
