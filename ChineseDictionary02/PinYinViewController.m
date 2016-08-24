//
//  PinYinViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/19.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "PinYinViewController.h"
#import "MoreViewController.h"
#import "AlphabetViewController.h"
#import "RadicalViewController.h"
#import "WordsViewController.h"
#import "UIViewController+ShowText.h"

@interface PinYinViewController ()<UITextFieldDelegate>
{
    UISegmentedControl *segmented;
    UITextField *inputTextField;
    UIImageView *searchListView;
    UILabel *textLabel2;
    int index;
    UIImageView *historySearch;
}

@end

@implementation PinYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self.view addSubview:segmented];

    [self setHistorySearchData];
    
    [self setAlphabetData];
    
}

-(void)moreButton:(UIButton *)sender{
    MoreViewController *moreVC = [MoreViewController new];
    [self.navigationController pushViewController:moreVC animated:YES];
}

-(void)setUI{
//    self.view.backgroundColor = [UIColor whiteColor];
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(moreButton:)];
    self.navigationItem.rightBarButtonItem = moreButton;
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    segmented = [[UISegmentedControl alloc]initWithItems:@[@"拼音检字",@"部首检字"]];
    segmented.frame = CGRectMake(40, 100, SCREEN_WIDTH-80, 40);
    segmented.selectedSegmentIndex = 0;
    segmented.tintColor = COLOR(134, 35, 41, 1);
    [segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    
    inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 150, SCREEN_WIDTH-80, 40)];
    inputTextField.layer.borderColor = COLOR(78, 78, 78, 0.5).CGColor;
    inputTextField.layer.borderWidth = 2;
    inputTextField.layer.cornerRadius = 15;
    inputTextField.textColor = COLOR(134, 35, 41, 1);
    inputTextField.placeholder = @"请输入...";
    inputTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    inputTextField.delegate = self;
    [self.view addSubview:inputTextField];
    
    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 210, SCREEN_WIDTH-60, 20)];
    textLabel1.text = @"最近搜索:";
    [self.view addSubview:textLabel1];
    
    UIView *underLine1 = [[UIView alloc]initWithFrame:CGRectMake(30, 235, SCREEN_WIDTH-60, 1)];
    underLine1.backgroundColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:underLine1];
    
    historySearch = [[UIImageView alloc]initWithFrame:CGRectMake(30, 245, SCREEN_WIDTH-60, 40)];
    historySearch.image = [UIImage imageNamed:@"Key-frame1"];
    historySearch.userInteractionEnabled = YES;
    [self.view addSubview:historySearch];
    
    UIView *underLine2 = [[UIView alloc]initWithFrame:CGRectMake(30, 320, SCREEN_WIDTH-60, 1)];
    underLine2.backgroundColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:underLine2];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)segmentedAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        [textLabel2 removeFromSuperview];
        [searchListView removeFromSuperview];
        [self setAlphabetData];
    }else if(sender.selectedSegmentIndex == 1){
        [textLabel2 removeFromSuperview];
        [searchListView removeFromSuperview];
        [self setRadicalData];
    }
}

-(void)setHistorySearchData{
    for (UIView *view in historySearch.subviews) {
        [view removeFromSuperview];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:[userDefaults valueForKey:@"historySearch"]];
    
    for (int i=0; i<mArray.count; i++) {
        UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        historyButton.frame = CGRectMake(((SCREEN_WIDTH-60)/6)*i, 0, (SCREEN_WIDTH-80)/6, 40);
        historyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        historyButton.titleLabel.textColor = COLOR(134, 35, 41, 1);
        [historyButton setTitleColor:COLOR(134, 35, 41, 1) forState:UIControlStateNormal];
        [historyButton setTitle:mArray[i] forState:UIControlStateNormal];
        [historyButton addTarget:self action:@selector(historySearch:) forControlEvents:UIControlEventTouchUpInside];
        [historySearch addSubview:historyButton];
    }
}
-(void)historySearch:(UIButton *)sender{
    inputTextField.text = sender.titleLabel.text;
    WordsViewController *wordVC = [WordsViewController new];
    wordVC.pageTitle = inputTextField.text;
    [self.navigationController pushViewController:wordVC animated:YES];
    inputTextField.text = @"";
}
-(void)insertUserDefaults:(NSString *)text{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:[userDefaults valueForKey:@"historySearch"]];
    if (!mArray) {
        [userDefaults setObject:[NSArray array] forKey:@"historySearch"];
    }
    [mArray insertObject:text atIndex:0];
    if (mArray.count == 7) {
        [mArray removeLastObject];
    }
    [userDefaults setObject:mArray forKey:@"historySearch"];
    [userDefaults synchronize];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length == 1) {
        int a = [textField.text characterAtIndex:0];
        if(a > 0x4e00 && a < 0x9fff) {
            [self insertUserDefaults:textField.text];
            [self setHistorySearchData];
            WordsViewController *wordsVC = [WordsViewController new];
            wordsVC.pageTitle = textField.text;
            [self.navigationController pushViewController:wordsVC animated:YES];
            textField.text = @"";
            return  YES;
        }
    }
    [self showTextWithString:@"请输入单个汉字"];
    return YES;
}

-(void)setAlphabetData{
    textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 295, SCREEN_WIDTH-60, 20)];
    textLabel2.text = @"按照拼音字母检字:";
    [self.view addSubview:textLabel2];
    index = 0;
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    searchListView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 335, SCREEN_WIDTH-60, SCREEN_HEIGHT-360)];
    searchListView.image = [UIImage imageNamed:@"Key-frame2"];
    searchListView.userInteractionEnabled = YES;
    [self.view addSubview:searchListView];
    for (int i=0; i<4; i++) {
        for (int j=0; j<7 && index<26; j++) {
            UIButton *alphabetButton = [UIButton buttonWithType:UIButtonTypeCustom];
            alphabetButton.frame = CGRectMake(((SCREEN_WIDTH-60)/7)*j, ((SCREEN_HEIGHT-360)/4)*i, (SCREEN_WIDTH-80)/7, (SCREEN_HEIGHT-360)/4);
            alphabetButton.titleLabel.font = [UIFont systemFontOfSize:30];
            [alphabetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            alphabetButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [alphabetButton setTitleColor:COLOR(134, 35, 41, 1) forState:UIControlStateNormal];
            alphabetButton.backgroundColor = [UIColor clearColor];
            [alphabetButton setTitle:[NSString stringWithFormat:@"%@",array[index]] forState:UIControlStateNormal];
            alphabetButton.tag = index + 1;
            [alphabetButton addTarget:self action:@selector(alphabetButton:) forControlEvents:UIControlEventTouchUpInside];
            [searchListView addSubview:alphabetButton];
            index++;
        }
    }
}
-(void)alphabetButton:(UIButton *)sender{
    AlphabetViewController *alphabetVC = [AlphabetViewController new];
    alphabetVC.section = (int)sender.tag;
    [self.navigationController pushViewController:alphabetVC animated:YES];
}

-(void)setRadicalData{
    textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 295, SCREEN_WIDTH-60, 20)];
    textLabel2.text = @"按照部首笔画检字:";
    [self.view addSubview:textLabel2];
    index = 0;
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17"];
    searchListView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 335, SCREEN_WIDTH-60, SCREEN_HEIGHT-360)];
    searchListView.image = [UIImage imageNamed:@"Key-frame2"];
    searchListView.userInteractionEnabled = YES;
    [self.view addSubview:searchListView];
    for (int i=0; i<3; i++) {
        for (int j=0; j<6 && index<17; j++) {
            UIButton *radicalButton = [UIButton buttonWithType:UIButtonTypeCustom];
            radicalButton.frame = CGRectMake(((SCREEN_WIDTH-60)/6)*j, ((SCREEN_HEIGHT-360)/4)*i, (SCREEN_WIDTH-80)/6, (SCREEN_HEIGHT-360)/3);
            radicalButton.titleLabel.font = [UIFont systemFontOfSize:30];
            [radicalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            radicalButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [radicalButton setTitleColor:COLOR(134, 35, 41, 1) forState:UIControlStateNormal];
            radicalButton.backgroundColor = [UIColor clearColor];
            [radicalButton setTitle:[NSString stringWithFormat:@"%@",array[index]] forState:UIControlStateNormal];
            radicalButton.tag = index + 1;
            [radicalButton addTarget:self action:@selector(radicalButton:) forControlEvents:UIControlEventTouchUpInside];
            [searchListView addSubview:radicalButton];
            index++;
            
        }
    }
}
-(void)radicalButton:(UIButton *)sender{
    RadicalViewController *radicalVC = [RadicalViewController new];
    radicalVC.section = (int)sender.tag;
    [self.navigationController pushViewController:radicalVC animated:YES];
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
