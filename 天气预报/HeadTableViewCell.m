//
//  HeadTableViewCell.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/13.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.cityLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_cityLabel];
        
        self.dayLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_dayLabel];
        
        self.temperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_temperatureLabel];
        
        self.weekLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_weekLabel];
        
        self.nowdayLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nowdayLabel];
        
        self.highTemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_highTemperatureLabel];
        
        self.lowTemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_lowTemperatureLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _cityLabel.frame = CGRectMake(60, 50, 300, 50);
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.font = [UIFont systemFontOfSize:35];
    _cityLabel.textColor = [UIColor whiteColor];
    
    _dayLabel.frame = CGRectMake(190, 90, 80, 40);
    _dayLabel.textColor = [UIColor whiteColor];
    
    _temperatureLabel.frame = CGRectMake(150, 130, 160, 100);
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont systemFontOfSize:100];
    
    _weekLabel.frame = CGRectMake(10, 270, 80, 50);
    _weekLabel.textColor = [UIColor whiteColor];
    _weekLabel.font = [UIFont systemFontOfSize:20];
    
    _nowdayLabel.frame = CGRectMake(100, 275, 50, 40);
    _nowdayLabel.text = @"今天";
    _nowdayLabel.textColor = [UIColor whiteColor];
    
    _highTemperatureLabel.frame = CGRectMake(330, 270, 30, 50);
    _highTemperatureLabel.textColor = [UIColor whiteColor];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _lowTemperatureLabel.frame = CGRectMake(370, 270, 30, 50);
    _lowTemperatureLabel.textColor = [UIColor whiteColor];
    _lowTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
