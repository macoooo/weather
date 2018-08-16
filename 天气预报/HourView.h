//
//  HourView.h
//  天气预报
//
//  Created by 强淑婷 on 2018/8/16.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourView : UIView

@property (nonatomic, strong)UILabel *hourLabel;
@property (nonatomic, strong)UIImageView *weatherImageView;
@property (nonatomic, strong)UILabel *temperatureLabel;

- (instancetype)initWithHour:(NSString *)newhour andWeatherImage:(UIImage *)newweatherImage andTemperate:(NSString *)newtemperature;
@end
