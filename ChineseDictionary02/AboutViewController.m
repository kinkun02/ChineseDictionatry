//
//  AboutViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
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
    titleLabel.text = @"关于我们";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"magnifier"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(magnifierButton:)];
    self.navigationItem.rightBarButtonItem = moreButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH, 46)];
    imageView1.image = [UIImage imageNamed:@"z"];
    [self.view addSubview:imageView1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 100, SCREEN_WIDTH-180, 38)];
    label1.font = [UIFont systemFontOfSize:24];
    label1.textColor = COLOR(0, 0, 0, 1);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"指掌无线";
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 146, 120, 30)];
    label2.font = [UIFont systemFontOfSize:18];
    label2.text = @"汉语字典";
    [self.view addSubview:label2];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-80, SCREEN_HEIGHT/2-150, 160, 160)];
    imageView2.image = [UIImage imageNamed:@"zidian"];
    [self.view addSubview:imageView2];
    
//    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(35, SCREEN_HEIGHT/2+20, SCREEN_WIDTH-70, 120)];
//    label3.textColor = COLOR(28, 28, 28, 1);
//    label3.font = [UIFont systemFontOfSize:14];
//    label3.text = @"        汉语是世界上最精密的语言之一,语义丰富,耐人寻味。本词典篇幅简短,内容丰富,既求融科学性、知识性、实用性、规范性于一体,又注意突出时代特色。";
//    label3.numberOfLines = 0;
//    [self.view addSubview:label3];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(35, SCREEN_HEIGHT/2+50, SCREEN_WIDTH-70, SCREEN_HEIGHT-(SCREEN_HEIGHT/2+100))];
    imageView3.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:imageView3];
    
}

-(void)backButtonAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)magnifierButton:(UIBarButtonItem *)sender{
    NSURL *url = [NSURL URLWithString:@"http://www.zhizhang.com"];
    [[UIApplication sharedApplication]openURL:url];
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
