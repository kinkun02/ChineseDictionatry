//
//  SQLiteManager.h
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordsModel.h"

@interface SQLiteManager : NSObject
@property (nonatomic,strong)NSString *alphabetText;
@property (nonatomic,strong)NSString *radicalTitle;
@property (nonatomic,assign)int radicalNumber;
@property (nonatomic,assign)int radicalID;

+(BOOL)insertModel:(WordsModel *)model;
+(BOOL)deleteModel:(WordsModel *)model;
+(NSArray *)findALLCollection;
@end
