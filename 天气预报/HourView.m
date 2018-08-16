//
//  HourView.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/16.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "HourView.h"

@implementation HourView

- (instancetype)initWithHour:(NSString *)newhour andWeatherImage:(UIImage *)newweatherImage andTemperate:(NSString *)newtemperature
{
    if(self = [super init]){
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 4, 80, 40)];
        _hourLabel.font = [UIFont systemFontOfSize:20];
        _hourLabel.textColor = [UIColor whiteColor];
        [self addSubview:_hourLabel];
        
        _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 110, 80, 40)];
        _temperatureLabel.font = [UIFont systemFontOfSize:22];
        _temperatureLabel.textColor = [UIColor whiteColor];
        [self addSubview:_temperatureLabel];
        
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 60, 40, 40)];
        [self addSubview:_weatherImageView];
        
        self.hourLabel.text = newhour;
        self.weatherImageView.image = newweatherImage;
        self.temperatureLabel.text = newtemperature;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
