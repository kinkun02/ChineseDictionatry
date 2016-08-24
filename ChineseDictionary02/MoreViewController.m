//
//  MoreViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/20.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "AboutViewController.h"
#import "CollectionViewController.h"
#import "FeedBackViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *moreArray;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    moreArray = [NSArray array];
    moreArray = @[@"我的收藏",@"意见反馈",@"关于我们",@"应用打分",@"精品应用",@"分享"];
    
    [self setMoreData];
}

-(void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:134/255.0 green:35/255.0 blue:41/255.0 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:134/255.0 green:35/255.0 blue:41/255.0 alpha:1];
    }else{
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:134/255.0 green:35/255.0 blue:41/255.0 alpha:1];
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 33)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"汉语字典";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
}

-(void)setMoreData{
    UITableView *moreTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    [self.view addSubview:moreTableView];
    
    [moreTableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MoreTableViewCell class])];
    
    moreTableView.rowHeight = 60;
    
    moreTableView.backgroundColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            CollectionViewController *collectionVC = [CollectionViewController new];
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
            break;
        case 1:{
            FeedBackViewController *feedbackVC = [FeedBackViewController new];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case 2:{
            AboutViewController *aboutVC = [AboutViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoreTableViewCell class])];
    NSString *str = moreArray[indexPath.row];
    cell.moreName.text = [NSString stringWithFormat:@"%@",str];
    cell.moreImage.image = [UIImage imageNamed:@"continue"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return moreArray.count;
}

-(void)backButtonAction:(UIBarButtonItem *)sender{
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
