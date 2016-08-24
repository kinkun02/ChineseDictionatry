//
//  FontViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/28.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "FontViewController.h"
#import "FontTableViewCell.h"
#import "WordsModel.h"
#import "WordsViewController.h"



@interface FontViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *fontTableView;
    NSMutableArray *dataSource;
}
@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setDataSource];
}

-(void)setUI{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        self.navigationController.navigationBar.barTintColor = COLOR(134, 35, 41, 1);
        self.navigationController.navigationBar.tintColor = COLOR(134, 35, 41, 1);
    }else{
        self.navigationController.navigationBar.tintColor = COLOR(134, 35, 41, 1);
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 33)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _titleText;
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(homeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    fontTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    fontTableView.delegate = self;
    fontTableView.dataSource = self;
    [fontTableView registerNib:[UINib nibWithNibName:@"FontTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([FontTableViewCell class])];
    fontTableView.rowHeight = 36;
    fontTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:fontTableView];
    
    fontTableView.rowHeight = 70;
    
}

-(void)setDataSource{
    dataSource = [NSMutableArray array];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *str1 = @"http://www.chazidian.com/service/";
    NSString *str2 = [str1 stringByAppendingString:_sendText];
    NSString *urlString = [str2 stringByAppendingString:@"/0/100"];
    NSLog(@"url = %@",urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArray = dic[@"data"][@"words"];
        for (NSDictionary *wordsDic in dataArray) {
            WordsModel *wordsM = [WordsModel new];
            wordsM.wordText = wordsDic[@"simp"];
            wordsM.alphabetText = wordsDic[@"yin"][@"pinyin"];
            wordsM.radicalText = wordsDic[@"bushou"];
            wordsM.numberText = wordsDic[@"num"];
            [dataSource addObject:wordsM];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            fontTableView.hidden = NO;
            [fontTableView  reloadData];
        });
    }];
    [dataTask resume];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FontTableViewCell *cell = (FontTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FontTableViewCell class])];
    WordsModel *wordsM = dataSource[indexPath.row];
    cell.fontLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banmizige"]];
    cell.fontLabel.layer.borderWidth = 2;
    cell.fontLabel.layer.borderColor = COLOR(134, 35, 41, 0.8).CGColor;
    [cell.soundButton addTarget:self action:@selector(soundButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.fontLabel.text = wordsM.wordText;
    cell.soundLabel.text = wordsM.alphabetText;
    cell.radicalLabel.text = wordsM.radicalText;
    cell.numberLabel.text = wordsM.numberText;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FontTableViewCell *cell = (FontTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    WordsViewController *wordsVC = [WordsViewController new];
    wordsVC.pageTitle = cell.fontLabel.text;
    
    [self.navigationController pushViewController:wordsVC animated:YES];
}

-(void)soundButton:(UIButton *)sender{
    
}
-(void)backButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)homeButton:(UIButton *)sender{
    
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
