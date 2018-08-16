//
//  EverydayTableViewCell.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/13.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "EverydayTableViewCell.h"

@implementation EverydayTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.eyerydayLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_eyerydayLabel];
        
        self.highTemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_highTemperatureLabel];
        
        self.lowtemperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_lowtemperatureLabel];
        
        self.weatherImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_weatherImageView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _eyerydayLabel.frame = CGRectMake(10, 2, 80, 50);
    _eyerydayLabel.font = [UIFont systemFontOfSize:20];
    _eyerydayLabel.textColor = [UIColor whiteColor];
    
    _highTemperatureLabel.frame = CGRectMake(330, 2, 30, 50);
    _highTemperatureLabel.textColor = [UIColor whiteColor];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _lowtemperatureLabel.frame = CGRectMake(370, 2, 30, 50);
    _lowtemperatureLabel.font = [UIFont systemFontOfSize:20];
    _lowtemperatureLabel.textColor = [UIColor lightGrayColor];
    
    _weatherImageView.frame = CGRectMake(180, 4, 35, 35);
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
