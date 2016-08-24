//
//  AlphabetViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/25.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "AlphabetViewController.h"
#import "IndexPageTableViewCell.h"
#import "SQLiteManager.h"
#import <sqlite3.h>
#import "FontViewController.h"

@interface AlphabetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    NSMutableArray *alphabetArray;
    NSMutableArray *arrAll;
    NSArray *titleArray;
}
@end

@implementation AlphabetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self findAll];
    [self setAlphabetData];
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
    titleLabel.text = @"拼音检索";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    UITableView *alphabetTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    alphabetTableView.delegate = self;
    alphabetTableView.dataSource = self;
    [alphabetTableView registerNib:[UINib nibWithNibName:@"IndexPageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([IndexPageTableViewCell class])];
    alphabetTableView.rowHeight = 36;
    alphabetTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:alphabetTableView];
    
    alphabetTableView.sectionIndexColor = COLOR(134, 35, 41, 1);
    alphabetTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    if (_section == 9 || _section == 22) {
        _section++;
    }
    if (_section == 21) {
        _section--;
    }
//    [alphabetTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_section - 1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(NSArray *)findAll{
    alphabetArray = [NSMutableArray array];
    NSString *dbPath = [[NSBundle mainBundle]pathForResource:@"aaaaa2" ofType:@"sqlite"];
    sqlite3 *db;
    sqlite3_open(dbPath.UTF8String,&db);
    NSString *sql = @"select * from ol_pinyins";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            SQLiteManager *sqlManager = [SQLiteManager new];
            sqlManager.alphabetText = [NSString stringWithCString:(char *)sqlite3_column_text(stmt,1) encoding:NSUTF8StringEncoding];
            [alphabetArray addObject:sqlManager];
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return alphabetArray;
}

-(void)setAlphabetData{
    dataSource = [NSMutableArray array];
    NSArray *array = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    for (int i=0; i<alphabetArray.count && i<26; i++) {
        [alphabetArray removeObject:alphabetArray[0]];
    }
    for (int i=0; i<array.count; i++) {
        arrAll = [NSMutableArray array];
        for (SQLiteManager *sqli in alphabetArray) {
            if ([sqli.alphabetText hasPrefix:array[i]]){
                [arrAll addObject:sqli.alphabetText];
            }
        }
        [dataSource addObject:arrAll];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexPageTableViewCell *cell = (IndexPageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndexPageTableViewCell class])];
    NSMutableArray *arr = [NSMutableArray array];
    NSString *str1;
    arr = dataSource[indexPath.section];
    str1 = arr[indexPath.row];
    cell.indexText.text = str1;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *arr = dataSource[section];
    return arr.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return [titleArray objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 26;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return titleArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = [NSString string];
    NSMutableArray *array = [NSMutableArray array];
    array = dataSource[indexPath.section];
    string = array[indexPath.row];
    FontViewController *fontVC = [FontViewController new];
    fontVC.titleText = string;
    fontVC.sendText = [@"pinyin/" stringByAppendingString:string];
    [self.navigationController pushViewController:fontVC animated:YES];
}

-(void)backButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
