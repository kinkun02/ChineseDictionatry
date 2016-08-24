//
//  WordsViewController.h
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/29.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsModel.h"

@interface WordsViewController : UIViewController
@property (nonatomic,strong)NSString *pageTitle;
@property (nonatomic,strong)WordsModel *model;
@property (nonatomic,strong)UIButton *toolButton3;
@property (nonatomic,strong)UISegmentedControl *segmented;
@end
