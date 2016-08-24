//
//  FontTableViewCell.h
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/28.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UILabel *radicalLabel;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end
