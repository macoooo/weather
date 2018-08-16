//
//  AddCityViewController.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "AddCityViewController.h"
#import "AddCityTableViewCell.h"
#import "SearchCityViewController.h"

@interface AddCityViewController ()<UITableViewDelegate,UITableViewDataSource,SearchCityViewControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *addNewCityMutableArray;
@property (nonatomic, copy)NSString *cityString;
@property (nonatomic, strong)NSMutableArray *dataMuatbleArray;
@property (nonatomic, strong)NSMutableArray *temperatureMutableArray;
@property (nonatomic, strong)NSMutableArray *timeMutableArray;
@end

@implementation AddCityViewController


- (void)changeCityArray:(NSMutableArray *)newCityString
{
    if(!_addNewCityMutableArray){
        _addNewCityMutableArray = [NSMutableArray array];
    }
    [self.addNewCityMutableArray addObject:newCityString];
    [_cityMutableArray addObject:newCityString];
    NSLog(@"%@hgjjhgj",_addNewCityMutableArray);
    NSLog(@"%@",_cityMutableArray);
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.15f green:0.54f blue:0.75f alpha:1.00f];
    _cityMutableArray = [NSMutableArray array];
    [_cityMutableArray addObjectsFromArray: _middleMutablearray];
    NSLog(@"%ld",_cityMutableArray.count);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tapGesture.numberOfTapsRequired  = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    _temperatureMutableArray = [NSMutableArray array];
    _timeMutableArray = [NSMutableArray array];
    for (int i = 0;i < _cityMutableArray.count; i++){
        NSLog(@"fdsf");
        _cityString  = _cityMutableArray[i];
        [self creatpost:_cityString];
    }
    
    [self loadTableView];
    NSLog(@"%@fffffffff",_temperatureMutableArray);
    // Do any additional setup after loading the view.
}
- (void)creatpost:(NSString *)string
{
    NSString *urlString =[NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=e1066ff38a7346128d608626c1b1477d",string];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSDictionary *firstDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            self.dataMuatbleArray = [NSMutableArray array];
            self.dataMuatbleArray= firstDictionary[@"HeWeather6"];
            [self->_temperatureMutableArray addObject:self->_dataMuatbleArray[0][@"now"][@"tmp"]];
            [self.timeMutableArray addObject:self->_dataMuatbleArray[0][@"update"][@"utc"]];
            NSLog(@"%@",self->_temperatureMutableArray);
            NSLog(@"%@",self->_timeMutableArray);
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
- (void)loadTableView
{
    _tableView= [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[AddCityTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    NSLog(@"%ldd",self.addNewCityMutableArray.count);
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1){
        return 1;
    }
    return _cityMutableArray.count;
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
        return 100;
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
        AddCityTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell == nil){
            cell = [[AddCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        
        if(_timeMutableArray && [_timeMutableArray count] > 0 && ![_timeMutableArray isKindOfClass:[NSNull class]]){
            //cell.littleLabel.text = _timeMutableArray[indexPath.row];
        }
        cell.bigLabel.text = _cityMutableArray[indexPath.row];
        if(_temperatureMutableArray && [_temperatureMutableArray count] > 0 && ![_timeMutableArray isKindOfClass:[NSNull class]]){
            //cell.temperatureLabel.text = _temperatureMutableArray[indexPath.row];
        }
        return cell;
    }
    else{
        UITableViewCell *cell1 = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if(cell1 == nil){
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell1.backgroundColor = [UIColor clearColor];
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(370, 3, 50, 50)];
        [addButton setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.contentView  addSubview:addButton];
        return cell1;
    }
}
- (void)addClick
{
    SearchCityViewController *new = [[SearchCityViewController alloc]init];
    new.middleMutablearray = _cityMutableArray;
    new.delegate = self;
    [self presentViewController:new animated:YES completion:nil];
}
- (void)tapClick
{
    if([self.delegate respondsToSelector:@selector(changeCityArray:)]) {
        [self.delegate changeCityArray:self.addNewCityMutableArray];
    }
    NSLog(@"%@", self.addNewCityMutableArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
