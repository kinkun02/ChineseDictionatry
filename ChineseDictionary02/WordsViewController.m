//
//  WordsViewController.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/29.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "WordsViewController.h"
#import "UIViewController+ShowText.h"
#import "SQLiteManager.h"


@interface WordsViewController ()
{
    NSMutableDictionary *dataDic;
    WordsModel *m;
    UITextView *textView;
    UIImageView *imageView3;
    UILabel *toolLabel3;
}
@end

@implementation WordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    if (!_model) {
        [self setDataArray];
        
    }else{
        m = _model;
        [self setData];
        
    }
    
    [self setControls];
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
    titleLabel.text = _pageTitle;
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(homeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"beijing"]];
}

-(void)setData{
    
    UIImageView *wordsView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, 70, 70)];
    wordsView.image = [UIImage imageNamed:@"banmizige"];
    [self.view addSubview:wordsView];
    
    UILabel *alphabetText = [[UILabel alloc]initWithFrame:CGRectMake(120, 80, 70, 20)];
    alphabetText.textAlignment = NSTextAlignmentLeft;
    alphabetText.font = [UIFont systemFontOfSize:12];
    alphabetText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:alphabetText];
    
    UILabel *zhuyinText = [[UILabel alloc]initWithFrame:CGRectMake(225, 80, 70, 20)];
    zhuyinText.textAlignment = NSTextAlignmentLeft;
    zhuyinText.font = [UIFont systemFontOfSize:12];
    zhuyinText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:zhuyinText];
    
    UILabel *traText = [[UILabel alloc]initWithFrame:CGRectMake(120, 100, 70, 20)];
    traText.textAlignment = NSTextAlignmentLeft;
    traText.font = [UIFont systemFontOfSize:12];
    traText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:traText];
    
    UILabel *freamText = [[UILabel alloc]initWithFrame:CGRectMake(225, 100, 70, 20)];
    freamText.textAlignment = NSTextAlignmentLeft;
    freamText.font = [UIFont systemFontOfSize:12];
    freamText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:freamText];
    
    UILabel *radicalText = [[UILabel alloc]initWithFrame:CGRectMake(120, 120, 70, 20)];
    radicalText.textAlignment = NSTextAlignmentLeft;
    radicalText.font = [UIFont systemFontOfSize:12];
    radicalText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:radicalText];
    
    UILabel *seqText = [[UILabel alloc]initWithFrame:CGRectMake(120, 140, 150, 20)];
    seqText.textAlignment = NSTextAlignmentLeft;
    seqText.font = [UIFont systemFontOfSize:12];
    seqText.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:seqText];
    
    UILabel *wordText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    wordText.textAlignment = NSTextAlignmentCenter;
    wordText.font = [UIFont systemFontOfSize:56];
    [wordsView addSubview:wordText];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(190, 120, 200, 20)];
    label6.font = [UIFont systemFontOfSize:12];
    label6.textAlignment = NSTextAlignmentLeft;
    label6.text = [NSString stringWithFormat:@"部首笔画:%@  笔画:%@",m.radcalNum,m.numberText];
    label6.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:label6];
    
    
    wordText.text = m.wordText;
    alphabetText.text = m.alphabetText;
    radicalText.text = m.radicalText;
    seqText.text = m.seqText;
    zhuyinText.text = m.zhuyinText;
    freamText.text = m.freamText;
    traText.text = m.traText;
    textView.text = m.baseText;
    
}

-(void)setControls{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(85, 80, 35, 20)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"拼音:";
    label1.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:label1];
    
    UIButton *soundButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    soundButton1.frame = CGRectMake(165, 82, 20, 15);
    [soundButton1 setBackgroundImage:[UIImage imageNamed:@"loud"] forState:UIControlStateNormal];
    [self.view addSubview:soundButton1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(190, 80, 35, 20)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"注音:";
    label2.textColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:label2];
    
    UIButton *soundButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    soundButton2.frame = CGRectMake(270, 82, 20, 15);
    [soundButton2 setBackgroundImage:[UIImage imageNamed:@"loud"] forState:UIControlStateNormal];
    [self.view addSubview:soundButton2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(85, 100, 35, 20)];
    label3.font = [UIFont systemFontOfSize:12];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.textColor = COLOR(134, 35, 41, 1);
    label3.text = @"繁体:";
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(190, 100, 35, 20)];
    label4.font = [UIFont systemFontOfSize:12];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.textColor = COLOR(134, 35, 41, 1);
    label4.text = @"结构:";
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(85, 120, 35, 20)];
    label5.font = [UIFont systemFontOfSize:12];
    label5.textAlignment = NSTextAlignmentLeft;
    label5.textColor = COLOR(134, 35, 41, 1);
    label5.text = @"部首:";
    [self.view addSubview:label5];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(85, 140, 35, 20)];
    label7.font = [UIFont systemFontOfSize:12];
    label7.textAlignment = NSTextAlignmentLeft;
    label7.textColor = COLOR(134, 35, 41, 1);
    label7.text = @"笔顺:";
    [self.view addSubview:label7];
    
    _segmented = [[UISegmentedControl alloc]initWithItems:@[@"基本信息",@"汉语字典",@"组词成语",@"英文翻译"]];
    _segmented.selectedSegmentIndex = 0;
    _segmented.tintColor = COLOR(134, 35, 41, 1);
    _segmented.frame = CGRectMake(10, 180, SCREEN_WIDTH-20, 40);
    [_segmented  addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmented];
    
    UIImageView *showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, SCREEN_HEIGHT-300)];
    showImageView.image = [UIImage imageNamed:@"informatianlow"];
    [self.view addSubview:showImageView];
    
    UIImageView *broochImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 225, 38, 70)];
    broochImageView.image = [UIImage imageNamed:@"brooch"];
    [self.view addSubview:broochImageView];
    
    UIImage *image1 = [UIImage imageNamed:@"pen"];
    UIImage *image2 = [UIImage imageNamed:@"document"];
    UIImage *image3 = [UIImage imageNamed:@"star"];
    UIImage *image4 = [UIImage imageNamed:@"share"];
    
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    toolBarView.backgroundColor = COLOR(134, 35, 41, 1);
    [self.view addSubview:toolBarView];
    
    float padding = (SCREEN_WIDTH-4*50)/5;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(padding, 0, 50, 50)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(50+padding*2, 0, 50, 50)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(100+padding*3, 0, 50, 50)];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(150+padding*4, 0, 50, 50)];
    [toolBarView addSubview:view1];
    view1.userInteractionEnabled = YES;
    view2.userInteractionEnabled = YES;
    view3.userInteractionEnabled = YES;
    view4.userInteractionEnabled = YES;
    [toolBarView addSubview:view2];
    [toolBarView addSubview:view3];
    [toolBarView addSubview:view4];
    [self.view addSubview:toolBarView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [imageView1 setImage:image1];
    [view1 addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [imageView2 setImage:image2];
    [view2 addSubview:imageView2];
    imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [imageView3 setImage:image3];
    [view3 addSubview:imageView3];
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [imageView4 setImage:image4];
    [view4 addSubview:imageView4];
    
    imageView1.userInteractionEnabled = YES;
    imageView2.userInteractionEnabled = YES;
    imageView3.userInteractionEnabled = YES;
    imageView4.userInteractionEnabled = YES;
    
    UILabel *toolLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 50, 15)];
    toolLabel1.textAlignment = NSTextAlignmentCenter;
    toolLabel1.textColor = [UIColor whiteColor];
    toolLabel1.font = [UIFont systemFontOfSize:12];
    toolLabel1.text = @"详情";
    [view1 addSubview:toolLabel1];
    UILabel *toolLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 50, 15)];
    toolLabel2.textAlignment = NSTextAlignmentCenter;
    toolLabel2.textColor = [UIColor whiteColor];
    toolLabel2.font = [UIFont systemFontOfSize:12];
    toolLabel2.text = @"复制";
    [view2 addSubview:toolLabel2];
    toolLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 50, 15)];
    toolLabel3.textAlignment = NSTextAlignmentCenter;
    toolLabel3.textColor = [UIColor whiteColor];
    toolLabel3.font = [UIFont systemFontOfSize:12];
    toolLabel3.text = @"收藏";
    [view3 addSubview:toolLabel3];
    UILabel *toolLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 50, 15)];
    toolLabel4.textAlignment = NSTextAlignmentCenter;
    toolLabel4.textColor = [UIColor whiteColor];
    toolLabel4.font = [UIFont systemFontOfSize:12];
    toolLabel4.text = @"分享";
    [view4 addSubview:toolLabel4];
    
    UIButton *toolButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    toolButton1.frame = CGRectMake(0, 0, 30, 30);
    [toolButton1 addTarget:self action:@selector(toolButton1:) forControlEvents:UIControlEventTouchUpInside];
    [imageView1 addSubview:toolButton1];
    
    UIButton *toolButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    toolButton2.frame = CGRectMake(0, 0, 30, 30);
    [toolButton2 addTarget:self action:@selector(toolButton2:) forControlEvents:UIControlEventTouchUpInside];
    [imageView2 addSubview:toolButton2];
    
    _toolButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _toolButton3.frame = CGRectMake(0, 0, 30, 30);
    _toolButton3.tag = 1000;
    [_toolButton3 addTarget:self action:@selector(toolButton3:) forControlEvents:UIControlEventTouchUpInside];
    [imageView3 addSubview:_toolButton3];
    
    UIButton *toolButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    toolButton4.frame = CGRectMake(0, 0, 30, 30);
    [toolButton4 addTarget:self action:@selector(toolButton4:) forControlEvents:UIControlEventTouchUpInside];
    [imageView4 addSubview:toolButton4];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-80, SCREEN_HEIGHT-350)];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.font = [UIFont systemFontOfSize:14];
    textView.backgroundColor = [UIColor clearColor];
    [showImageView addSubview:textView];
    
}

-(void)setDataArray{
    NSArray *array = [NSArray arrayWithArray:[SQLiteManager findALLCollection]];
    for (WordsModel *md in array) {
        if ([md.wordText isEqualToString:_pageTitle]) {
            m = md;
            _toolButton3.tag = 1001;
            [self setData];
            return;
        }
//        break;
    }

    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://www.chazidian.com/service/word/%@",_pageTitle];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dictionary = dic[@"data"];
        m = [WordsModel new];
        m.wordText = dictionary[@"baseinfo"][@"simp"];
        m.alphabetText = dictionary[@"baseinfo"][@"yin"][@"pinyin"];
        m.radicalText = dictionary[@"baseinfo"][@"bushou"];
        m.numberText = dictionary[@"baseinfo"][@"num"];
        m.soundString = dictionary[@"baseinfo"][@"sound"];
        m.zhuyinText = dictionary[@"baseinfo"][@"yin"][@"zhuyin"];
        m.traText = dictionary[@"baseinfo"][@"tra"];
        m.freamText = dictionary[@"baseinfo"][@"frame"];
        m.createText = dictionary[@"baseinfo"][@"create"];
        m.radcalNum = dictionary[@"baseinfo"][@"bsnum"];
        m.seqText = dictionary[@"baseinfo"][@"seq"];
        m.hanyuText = dictionary[@"hanyu"];
        m.englishText = dictionary[@"english"];
        m.baseText = dictionary[@"base"];
        m.idiomText = dictionary[@"idiom"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setData];
        });
    }];
    [dataTask resume];
}

-(void)toolButton1:(UIBarButtonItem *)sender{
    NSLog(@"1");
}
-(void)toolButton2:(UIBarButtonItem *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _pageTitle;
    sender.tintColor = COLOR(252, 240, 134, 1);
    [self showTextWithString:@"复制成功"];
}
-(void)toolButton3:(UIBarButtonItem *)sender{
    if (sender.tag == 1000) {
        sender.tag = 1001;
        [SQLiteManager insertModel:m];
        toolLabel3.text = @"已收藏";
        [self showTextWithString:@"收藏成功"];
    }else{
        sender.tag = 1000;
        [SQLiteManager deleteModel:m];
        toolLabel3.text = @"收藏";
        [self showTextWithString:@"取消收藏"];
    }
}
-(void)toolButton4:(UIBarButtonItem *)sender{
    NSLog(@"4");
}

-(void)segmentedAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        textView.text = m.baseText;
    }else if (sender.selectedSegmentIndex == 1){
        textView.text = m.hanyuText;
    }else if (sender.selectedSegmentIndex == 2){
        textView.text = m.idiomText;
    }else if (sender.selectedSegmentIndex == 3){
        textView.text = m.englishText;
    }
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
