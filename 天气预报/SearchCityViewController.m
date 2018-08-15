//
//  SearchCityViewController.m
//  天气预报
//
//  Created by 强淑婷 on 2018/8/14.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "SearchCityViewController.h"
#import "ViewController.h"

@interface SearchCityViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UISearchBar *citySearchBar;
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *displayArray;
@property (nonatomic, strong)NSMutableArray *oldDataArray;
//@property (nonatomic, copy)NSString *cityString;
@property (nonatomic, strong)NSMutableArray *addNewCityMutableArray;
//@property (nonatomic, copy)NSArray *cityNameArray;
//@property (nonatomic, strong)NSMutableArray *addCityMutableArray;

@end

@implementation SearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.24f green:0.25f blue:0.27f alpha:1.00f];
    _cityArray = _middleMutablearray;
    NSLog(@"%ld",_cityArray.count);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    view.backgroundColor = [UIColor colorWithRed:0.10f green:0.13f blue:0.15f alpha:1.00f];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 250, 40)];
    _titleLabel.text = @"输入城市，邮政编码或机场位置";
    _titleLabel.textColor = [UIColor whiteColor];
    [view addSubview:_titleLabel];
    
    _citySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 60, 330, 40)];
    _citySearchBar.backgroundColor = [UIColor clearColor];
    _citySearchBar.showsCancelButton = NO;
    _citySearchBar.barTintColor = [UIColor colorWithRed:0.15f green:0.19f blue:0.23f alpha:1.00f];
    _citySearchBar.layer.cornerRadius = 7;
    _citySearchBar.layer.masksToBounds = YES;
    _citySearchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _citySearchBar.delegate = self;
    [view addSubview:_citySearchBar];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(345, 60, 50, 50)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    
    //NSLog(@"%ldbbb",self.addNewCityMutableArray.count);
    NSLog(@"%lddfg",self.addNewCityMutableArray.count);
    [self.view addSubview:view];
    
   // if(_citySearchBar.text.length > 1){
        //[self creatPost];
        //[self searchFromTableView:_citySearchBar.text];
        [self loadTableView];
    //}
    // Do any additional setup after loading the view.
}

- (void)creatPost
{
        NSString *urlString =[NSString stringWithFormat: @"https://search.heweather.com/find?location=%@&key=e1066ff38a7346128d608626c1b1477d",_citySearchBar.text];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];

        NSURLRequest *request = [NSURLRequest requestWithURL:url];

        NSURLSession *sharedSession = [NSURLSession sharedSession];

        NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(data){
                NSDictionary *firstDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSMutableArray *dataMuatbleArray = [NSMutableArray array];
                dataMuatbleArray= firstDictionary[@"HeWeather6"];
                NSArray *tempDataArray = [NSArray array];
                tempDataArray = dataMuatbleArray[0][@"basic"];
                self.oldDataArray = [NSMutableArray array];
                for(int i = 0;i < tempDataArray.count; i++){
                    [self.oldDataArray addObject:tempDataArray[i][@"location"]];
                    NSLog(@"%@",tempDataArray[i][@"location"]);
                }
                NSLog(@"%@aaa",self.oldDataArray);
                self.displayArray = [[NSMutableArray alloc] initWithArray:self.oldDataArray];
                NSLog(@"%@fff",self.displayArray);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadData];
                }];
            }
        }];


        [dataTask resume];

}
- (BOOL)checkEqual:(NSString *)str
{
    NSLog(@"%@",_cityArray);
    for(int i = 0;i < _cityArray.count;i++){
        if([_cityArray[i] isEqualToString:str]){
            return NO;
        }
    }
    return YES;
}
- (void)loadTableView
{
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(20, 100, 320, 600) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
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
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.displayArray.count == 0){
        return cell;
    }
    cell.textLabel.text = self.displayArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = CGRectMake(20, 100, 330, 0);
    }];
    _citySearchBar.text = self.displayArray[indexPath.row];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self creatPost];
    [self searchFromTableView:searchText];
    //[self creatPost];
}
- (void)searchFromTableView:(NSString *)text
{
    NSLog(@"%@bbb",self.oldDataArray);
    NSString *searchText = text;
    if(searchText.length > 0){
        self.displayArray = [NSMutableArray array];
        [self.displayArray removeAllObjects];
        for(NSString *tempStr in self.oldDataArray){
            NSRange titleResult = [tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(titleResult.length > 0){
                [self.displayArray addObject:tempStr];
            }
        }
    }
    else{
        self.displayArray = [self.oldDataArray mutableCopy];
    }
    NSLog(@"%@",self.displayArray);
    [self.tableView reloadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.citySearchBar resignFirstResponder];
}
- (void)cancelClick
{
    ViewController *new = [[ViewController alloc]init];
    [self presentViewController:new animated:YES completion:nil];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _addNewCityMutableArray = [NSMutableArray array];
    if([self checkEqual:_citySearchBar.text]){
        [_addNewCityMutableArray addObject:_citySearchBar.text];
        NSLog(@"%@",_addNewCityMutableArray);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抱歉，已经有这个城市的天气了" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:deleteAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    if([self.delegate respondsToSelector:@selector(changeCityArray:)]) {
        [self.delegate changeCityArray:self.addNewCityMutableArray];
    }
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
