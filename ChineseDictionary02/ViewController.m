//
//  ViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/19.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "ViewController.h"
#import "PinYinViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *startPage = [[UIImageView alloc]initWithFrame:self.view.frame];
    startPage.image = [UIImage imageNamed:@"startup-interface"];
    [self.view addSubview:startPage];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.frame = self.view.frame;
    startButton.backgroundColor = [UIColor clearColor];
    [startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    

    
}

-(void)startButtonAction:(UIButton *)sender{
    PinYinViewController *pinyinVC = [PinYinViewController new];
    [self.navigationController pushViewController:pinyinVC animated:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
