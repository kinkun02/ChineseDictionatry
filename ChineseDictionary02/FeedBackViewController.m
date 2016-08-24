//
//  FeedBackViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIViewController+ShowText.h"

@interface FeedBackViewController ()<UITextViewDelegate>
{
    UITextView *feedBackTextView;
    UILabel *sexLabel;
    UIView *sexView;
    UIButton *sexButton1;
    UIButton *sexButton2;
    UILabel *ageLabel;
    NSArray *array;
    UIButton *ageButton;
    UIView *ageView;
    UIButton *ageChangeButton1;
    UIButton *ageChangeButton2;
    NSString *iAge;
    NSString *jAge;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
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
    titleLabel.text = @"意见反馈";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *magnifierButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"magnifier"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(magnifierButton:)];
    self.navigationItem.rightBarButtonItem = magnifierButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-60, 50, 30);
    submitButton.layer.cornerRadius = 5;
    [submitButton setTitle:@"提 交" forState:0];
    [submitButton setBackgroundColor:COLOR(134, 35, 41, 1)];
    [submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    [self feedback];
    
    [self sexChangeButton];
    
    [self ageChangeButton];
    
    
}
-(void)backButtonAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)magnifierButton:(UIBarButtonItem *)sender{
    NSURL *url = [NSURL URLWithString:@"http://www.zhizhang.com"];
    [[UIApplication sharedApplication]openURL:url];
}
-(void)submitButtonAction:(UIButton *)sender{
    [self showTextWithString:@"提交成功！"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ageChangeButton{
    ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, SCREEN_HEIGHT-60, 90, 30)];
    ageLabel.backgroundColor = COLOR(255, 255, 255, 1);
    ageLabel.font = [UIFont systemFontOfSize:18];
    ageLabel.layer.cornerRadius = 5;
    ageLabel.layer.borderColor = COLOR(0, 0, 0, 0.5).CGColor;
    ageLabel.layer.borderWidth = 1;
    ageLabel.text = @"  年龄:";
    [self.view addSubview:ageLabel];
    
    ageView = [[UIView alloc]initWithFrame:CGRectMake(150, SCREEN_HEIGHT-260, 90, 200)];
    
    UIView *chooseButtonView = [[UIView alloc]initWithFrame:CGRectMake(150, SCREEN_HEIGHT-60, 90, 30)];
    [self.view addSubview:chooseButtonView];
    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseButton setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
    chooseButton.frame = CGRectMake(20, 7, 70, 15);
    [chooseButton addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [chooseButtonView addSubview:chooseButton];
}
-(void)setAgeChangeButton{
    array = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9];
    for (int i=0; i<array.count; i++) {
        ageChangeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [ageChangeButton1 setTitleColor:COLOR(134, 35, 41, 1) forState:0];
        [ageChangeButton1 setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        ageChangeButton1.frame = CGRectMake(5, i * 20, 40, 20);
        [ageChangeButton1 setBackgroundColor:COLOR(126, 126, 126, 0.5)];
//        [ageChangeButton1 setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateSelected];
        [ageChangeButton1 addTarget:self action:@selector(ageChangeButton1:) forControlEvents:UIControlEventTouchUpInside];
        [ageView addSubview:ageChangeButton1];
    }
    for (int i=0; i<array.count; i++) {
        ageChangeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [ageChangeButton2 setTitleColor:COLOR(134, 35, 41, 1) forState:0];
        [ageChangeButton2 setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        ageChangeButton2.frame = CGRectMake(45, i * 20, 40, 20);
        [ageChangeButton2 setBackgroundColor:COLOR(126, 126, 126, 0.5)];
        [ageChangeButton2 addTarget:self action:@selector(ageChangeButton2:) forControlEvents:UIControlEventTouchUpInside];
        [ageView addSubview:ageChangeButton2];
    }
}
-(void)chooseButton:(UIButton *)sender{
    [self.view addSubview:ageView];
    [self setAgeChangeButton];
}
-(void)ageChangeButton1:(UIButton *)sender{
    iAge = sender.titleLabel.text;
    [sender setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateSelected];
    sender.selected = !sender.selected;
    NSLog(@"%@",sender.titleLabel.text);
}
-(void)ageChangeButton2:(UIButton *)sender{
    jAge = sender.titleLabel.text;
    if ([iAge isEqualToString:@"0"]) {
        ageLabel.text = [@"    " stringByAppendingString:jAge];
    }else if (!iAge){
        ageLabel.text = [@"    " stringByAppendingString:jAge];
    }else{
        NSString *string = [@"    " stringByAppendingString:iAge];
        ageLabel.text = [string stringByAppendingString:jAge];
    }
    [ageView removeFromSuperview];
    NSLog(@"%@",sender.titleLabel.text);
}

-(void)sexChangeButton{
    sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT-60, 80, 30)];
    sexLabel.layer.cornerRadius = 5;
    sexLabel.backgroundColor = COLOR(255, 255, 255, 1);
    sexLabel.layer.borderColor = COLOR(0, 0, 0, 0.5).CGColor;
    sexLabel.layer.borderWidth = 1;
    sexLabel.font = [UIFont systemFontOfSize:18];
    sexLabel.text = @"  性别:";
    [self.view addSubview:sexLabel];
    
    sexView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT-120, 80, 90)];
    [self.view addSubview:sexView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 67, 60, 15);
    [button1 setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    button1.titleLabel.textAlignment = NSTextAlignmentRight;
    [sexView addSubview:button1];
    
    sexButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [sexButton1 setTintColor:COLOR(134, 35, 41, 1)];
    [sexButton1 setTitle:@"男" forState:0];
    sexButton1.frame = CGRectMake(0, 0, 80, 30);
    sexButton1.layer.backgroundColor = COLOR(0, 0, 0, 0.5).CGColor;
    [sexButton1 addTarget:self action:@selector(sexButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    sexButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [sexButton2 setTintColor:COLOR(134, 35, 41, 1)];
    [sexButton2 setTitle:@"女" forState:0];
    sexButton2.frame = CGRectMake(0, 30, 80, 30);
    sexButton2.layer.backgroundColor = COLOR(255, 255, 255, 0.5).CGColor;
    [sexButton2 addTarget:self action:@selector(sexButton2:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)button1Action:(UIButton *)sender{
    [sexView addSubview:sexButton1];
    [sexView addSubview:sexButton2];
}
-(void)sexButton1:(UIButton *)sender{
    sexLabel.text = [@"    " stringByAppendingString:[NSString stringWithFormat:@"%@",sexButton1.titleLabel.text]];
    [sexButton1 removeFromSuperview];
    [sexButton2 removeFromSuperview];
}
-(void)sexButton2:(UIButton *)sender{
    sexLabel.text = [@"    " stringByAppendingString:[NSString stringWithFormat:@"%@",sexButton2.titleLabel.text]];
    [sexButton1 removeFromSuperview];
    [sexButton2 removeFromSuperview];
}

-(void)feedback{
    feedBackTextView = [[UITextView alloc]init];
    feedBackTextView.frame = CGRectMake(20, 90, SCREEN_WIDTH-40, SCREEN_HEIGHT-220);
    feedBackTextView.backgroundColor = COLOR(126, 126, 126, 0.4);
    feedBackTextView.layer.borderColor = COLOR(126, 126, 126, 0.8).CGColor;
    feedBackTextView.layer.borderWidth = 2;
    feedBackTextView.layer.cornerRadius = 7;
    self.automaticallyAdjustsScrollViewInsets = NO;
    feedBackTextView.textColor = COLOR(134, 35,41 , 0.5);
    feedBackTextView.text = @"    请输入您的反馈意见......";
    feedBackTextView.font = [UIFont systemFontOfSize:18];
    feedBackTextView.hidden = NO;
    feedBackTextView.delegate = self;
    [self.view addSubview:feedBackTextView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tapGesture];
}
-(void)textViewDidBeginEditing:(UITextView*)textView{
    if ([feedBackTextView.text isEqualToString:@"    请输入您的反馈意见......"]) {
        feedBackTextView.text = @"";
        feedBackTextView.font = [UIFont systemFontOfSize:14];
        feedBackTextView.textColor = [UIColor blackColor];
    }
}
-(void)tapGesture:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
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
