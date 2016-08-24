//
//  RadicalViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/25.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "RadicalViewController.h"
#import "IndexPageTableViewCell.h"
#import "SQLiteManager.h"
#import <sqlite3.h>
#import "FontViewController.h"

@interface RadicalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    NSMutableArray *radicalArray;
    NSMutableArray *allArray;
    NSArray *titleArray;
}
@end

@implementation RadicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    [self findAll];
    
    [self setRadicalData];
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
    titleLabel.text = @"部首检索";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    UITableView *radicalTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    radicalTableView.delegate = self;
    radicalTableView.dataSource = self;
    [radicalTableView registerNib:[UINib nibWithNibName:@"IndexPageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([IndexPageTableViewCell class])];
    radicalTableView.rowHeight = 36;
    radicalTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:radicalTableView];
    
    radicalTableView.sectionIndexColor = COLOR(134, 35, 41, 1);
    radicalTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
//    [radicalTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_section-1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(NSArray *)findAll{
    radicalArray = [NSMutableArray array];
    NSString *dbPath = [[NSBundle mainBundle]pathForResource:@"aaaaa2" ofType:@"sqlite"];
    sqlite3 *db;
    sqlite3_open(dbPath.UTF8String,&db);
    NSString *sql = @"select * from ol_bushou";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            SQLiteManager *sqlManager = [SQLiteManager new];
            sqlManager.radicalTitle = [NSString stringWithCString:(char *)sqlite3_column_text(stmt,2) encoding:NSUTF8StringEncoding];
            sqlManager.radicalNumber = sqlite3_column_int(stmt,1);
            sqlManager.radicalID = sqlite3_column_int(stmt, 0);
            [radicalArray addObject:sqlManager];
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return radicalArray;
}

-(void)setRadicalData{
    dataSource = [NSMutableArray array];
    for (int i=0; i<17; i++) {
        allArray = [NSMutableArray array];
        for (SQLiteManager *sqlite in radicalArray) {
            if (sqlite.radicalNumber == i+1) {
                [allArray addObject:sqlite.radicalTitle];
            }
        }
        [dataSource addObject:allArray];
        NSLog(@"%@",dataSource);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexPageTableViewCell *cell = (IndexPageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndexPageTableViewCell class])];
    NSMutableArray *array = [NSMutableArray array];
    NSString *string;
    array = dataSource[indexPath.section];
    string = array[indexPath.row];
    cell.indexText.text = string;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *arr = dataSource[section];
    return arr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    titleArray = @[@"1笔",@"2笔",@"3笔",@"4笔",@"5笔",@"6笔",@"7笔",@"8笔",@"9笔",@"10笔",@"11笔",@"12笔",@"13笔",@"14笔",@"15笔",@"16笔",@"17笔"];
    return [titleArray objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 17;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexPageTableViewCell *cell = (IndexPageTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *string = [NSString string];
    NSMutableArray *array = [NSMutableArray array];
    array = dataSource[indexPath.section];
    string = array[indexPath.row];
    FontViewController *fontVC = [FontViewController new];
    fontVC.titleText = string;
    int number = 1;
    for (SQLiteManager *sqlM in radicalArray) {
        if (![sqlM.radicalTitle isEqualToString:cell.indexText.text]) {
            number++;
        }else{
            break;
        }
    }
    NSString *str1 =[NSString stringWithFormat:@"%d",number];
    fontVC.sendText = [@"bushou/" stringByAppendingString:str1];
    [self.navigationController pushViewController:fontVC animated:YES];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return titleArray;
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
