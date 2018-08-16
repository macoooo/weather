//
//  AddCityTableViewCell.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "AddCityTableViewCell.h"

@implementation AddCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.littleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_littleLabel];
        
        self.bigLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_bigLabel];
        
        self.temperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_temperatureLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _littleLabel.frame = CGRectMake(15, 3, 150, 30);
    _littleLabel.textColor = [UIColor lightGrayColor];
    
    _bigLabel.frame = CGRectMake(15, 30, 250, 50);
    _bigLabel.textColor = [UIColor whiteColor];
    _bigLabel.font = [UIFont systemFontOfSize:35];
    
    _temperatureLabel.frame = CGRectMake(340, 5, 100, 80);
    _temperatureLabel.font = [UIFont systemFontOfSize:40];
    _temperatureLabel.textColor = [UIColor whiteColor];
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
