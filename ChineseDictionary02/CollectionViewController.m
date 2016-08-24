//
//  CollectionViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "CollectionViewController.h"
#import "FontTableViewCell.h"
#import "SQLiteManager.h"
#import "WordsViewController.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    UITableView *collectionList;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    titleLabel.text = @"我的收藏";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    collectionList = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    collectionList.delegate = self;
    collectionList.dataSource = self;
    collectionList.backgroundColor = [UIColor clearColor];
    collectionList.rowHeight = 70;
    [collectionList registerNib:[UINib nibWithNibName:@"FontTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([FontTableViewCell class])];
    [self.view addSubview:collectionList];
    
}

-(void)viewDidAppear:(BOOL)animated{
    dataSource = [NSMutableArray new];
    dataSource = [NSMutableArray arrayWithArray:[SQLiteManager findALLCollection]];
    [collectionList reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FontTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    WordsModel *m = dataSource[indexPath.row];
    
    cell.fontLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banmizige"]];
    cell.fontLabel.layer.borderWidth = 2;
    cell.fontLabel.layer.borderColor = COLOR(134, 35, 41, 0.8).CGColor;
    [cell.soundButton addTarget:self action:@selector(soundButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.fontLabel.text = m.wordText;
    cell.soundLabel.text = m.alphabetText;
    cell.radicalLabel.text = m.radicalText;
    cell.numberLabel.text = m.numberText;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    FontTableViewCell *cell = (FontTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    WordsViewController *wordVC = [WordsViewController new];
    wordVC.model = dataSource[indexPath.row];
//    wordVC.pageTitle = cell.fontLabel.text;
    [self.navigationController pushViewController:wordVC animated:YES];
}

-(void)soundButton:(UIButton *)sender{
    
}
-(void)backButtonAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
