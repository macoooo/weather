//
//  WeatherShowView.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "WeatherShowView.h"

@implementation WeatherShowView
- (instancetype)initWithFrame:(CGRect)frame andCityName:(NSString *)cityName
{
    if(self = [super initWithFrame:(CGRect)frame]){
        self.cityName = cityName;
        [self creatpost];
        //[self creatplease];
        [self creatTableView];
    }
    return self;
}
- (void)creatpost
{
    NSString *urlString =[NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=e1066ff38a7346128d608626c1b1477d", self.cityName];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSession *sharedSession = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSDictionary *firstDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            self.dataMuatbleArray = [NSMutableArray array];
            self.dataMuatbleArray= firstDictionary[@"HeWeather6"];
            self->_oneDayDictionary = [[NSDictionary alloc] init];
            self->_oneDayDictionary = self->_dataMuatbleArray[0][@"daily_forecast"][0];
            NSLog(@"%@dddd",self.dataMuatbleArray[0][@"basic"][@"location"]);
            NSLog(@"%@",self->_dataMuatbleArray[0][@"daily_forecast"][0][@"wind_spd"]);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
        else{
            NSLog(@"error = %@",error);
        }
    }];


    [dataTask resume];
}
- (void)creatplease
{
    NSString *urlString =[NSString stringWithFormat:@"https://api.jisuapi.com/weather/query?appkey=eda70385f90c0fba&city=%@", self.cityName];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            self.secondDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",self->_secondDictionary[@"result"][@"week"]);
            NSLog(@"%@",self->_secondDictionary[@"result"][@"daily"][1][@"week"]);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
        else{
            NSLog(@"error = %@",error);
        }
    }];
    
    
    [dataTask resume];
}

- (void)creatTableView
{
    _tableView= [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    
    [_tableView registerClass:[HeadTableViewCell class] forCellReuseIdentifier:@"cellHead"];
    [_tableView registerClass:[EverydayTableViewCell class] forCellReuseIdentifier:@"cellEveryday"];
    [_tableView registerClass:[FootTableViewCell class] forCellReuseIdentifier:@"cellFoot"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    _tableView.tableHeaderView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    [self addSubview:_tableView];
}
- (void)setName:(NSString *)cityName
{
    _cityName = cityName;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2){
        return 3;
    }
    if(section == 4){
        return 10;
    }
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 325;
    }
    if(indexPath.section == 1){
        return 160;
    }
    if(indexPath.section == 3){
        return 80;
    }
    if(indexPath.section == 4){
        return 80;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        HeadTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cellHead" ];
        if(cell == nil){
            cell = [[HeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellHead"];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, [UIScreen mainScreen].bounds.size.width);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.cityLabel.text = _dataMuatbleArray[0][@"basic"][@"location"];
        cell.dayLabel.text = _dataMuatbleArray[0][@"daily_forecast"][0][@"cond_txt_d"];
        cell.temperatureLabel.text = [NSString stringWithFormat:@"%@°",_dataMuatbleArray[0][@"now"][@"tmp"]];
        //cell.weekLabel.text = _secondDictionary[@"result"][@"week"];
        cell.highTemperatureLabel.text = _dataMuatbleArray[0][@"daily_forecast"][0][@"tmp_max"];
        cell.lowTemperatureLabel.text = _dataMuatbleArray[0][@"daily_forecast"][0][@"tmp_min"];
        return cell;
    }
    if(indexPath.section == 1){
        UITableViewCell *cell2 = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell2 == nil){
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell2.backgroundColor = [UIColor clearColor];
        cell2.textLabel.text = @"22";
        return cell2;
    }
    if(indexPath.section == 2){
        EverydayTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cellEveryday" ];
        if(cell == nil){
            cell = [[EverydayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellEveryday"];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSArray *everydayArray = [NSArray arrayWithObjects:_secondDictionary[@"result"][@"week"],_secondDictionary[@"result"][@"daily"][1][@"week"],_secondDictionary[@"result"][@"daily"][2][@"week"] ,nil];
        NSArray *highArray = [NSArray arrayWithObjects: _dataMuatbleArray[0][@"daily_forecast"][0][@"tmp_max"],_dataMuatbleArray[0][@"daily_forecast"][1][@"tmp_max"],_dataMuatbleArray[0][@"daily_forecast"][2][@"tmp_max"], nil];
        NSArray *lowArray = [NSArray arrayWithObjects: _dataMuatbleArray[0][@"daily_forecast"][0][@"tmp_min"],_dataMuatbleArray[0][@"daily_forecast"][1][@"tmp_min"],_dataMuatbleArray[0][@"daily_forecast"][2][@"tmp_min"], nil];
        NSArray *imageArray = [NSArray arrayWithObjects:_dataMuatbleArray[0][@"daily_forecast"][0][@"cond_txt_d"],_dataMuatbleArray[0][@"daily_forecast"][1][@"cond_txt_d"],_dataMuatbleArray[0][@"daily_forecast"][2][@"cond_txt_d"], nil];
        if(imageArray && imageArray.count > 0 && ![imageArray isKindOfClass:[NSNull class]]){
            cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
        }
//        if(everydayArray && everydayArray.count > 0 && ![everydayArray isKindOfClass:[NSNull class]]){
//            cell.eyerydayLabel.text = everydayArray[indexPath.row];
//       }
        if(highArray && highArray.count > 0 && ![highArray isKindOfClass:[NSNull class]]){
            cell.highTemperatureLabel.text = highArray[indexPath.row];
        }
        if(lowArray && lowArray.count > 0 && ![lowArray isKindOfClass:[NSNull class]]){
            cell.lowtemperatureLabel.text = lowArray[indexPath.row];
        }
        return cell;
    }
    if(indexPath.section == 3){
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width, 80)];
        label.text = _dataMuatbleArray[0][@"lifestyle"][0][@"txt"];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
        return cell;
    }
    else{
        FootTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cellFoot"];
        if(cell == nil){
            cell = [[FootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFoot"];
        }
        //NSLog( @"%@dd",_oneDayDictionary);
        cell.tag = indexPath.row;
        cell.backgroundColor = [UIColor clearColor];
        
        NSArray *littleLabelArray = [NSArray arrayWithObjects:@"日出",@"日落",@"降雨概率",@"湿度",@"风速",@"体感温度",@"降水量",@"气压",@"能见度",@"紫外线指数", nil];
        NSArray *bigLabelArray = [NSArray  arrayWithObjects:self.oneDayDictionary[@"sr"],_oneDayDictionary[@"ss"],_oneDayDictionary[@"pop"],_oneDayDictionary[@"hum"],_oneDayDictionary[@"wind_dir"],_dataMuatbleArray[0][@"now"][@"fl"],_oneDayDictionary[@"pcpn"],_oneDayDictionary[@"pres"],_oneDayDictionary[@"vis"],_oneDayDictionary[@"uv_index"],nil];
        NSArray *windArray = [NSArray arrayWithObjects:@" ",@" ",@" ",@" ",_dataMuatbleArray[0][@"daily_forecast"][0][@"wind_spd"],@" ",@" ",@" ",@" ",@" ",nil];
        cell.littleLabel.text  = littleLabelArray[indexPath.row];
        if(bigLabelArray && bigLabelArray.count > 0 && ![bigLabelArray isKindOfClass:[NSNull class]]){
            cell.bigLabel.text = bigLabelArray[indexPath.row];
        }
//        if(windArray && windArray.count > 0 && ![windArray isKindOfClass:[NSNull class]]){
//           cell.windLabel.text = windArray[indexPath.row];
//        }
        return cell;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
