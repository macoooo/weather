//
//  FootTableViewCell.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "FootTableViewCell.h"

@implementation FootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.littleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_littleLabel];
        
        self.bigLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_bigLabel];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _littleLabel.frame = CGRectMake(15, 3, 200, 30);
    _littleLabel.textColor = [UIColor lightGrayColor];
    
    _bigLabel.frame = CGRectMake(15, 30, 200, 50);
    _bigLabel.textColor = [UIColor whiteColor];
    _bigLabel.font = [UIFont systemFontOfSize:35];
    
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
