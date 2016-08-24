//
//  SQLiteManager.m
//  ChineseDictionary02
//
//  Created by Ibokan on 16/7/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "SQLiteManager.h"
#import <FMDB.h>

FMDatabase *db = nil;
FMDatabase *collectionDB = nil;
@implementation SQLiteManager

+(BOOL)setDataBase{
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]stringByAppendingPathComponent:@"collection.sqlite"];
    collectionDB = [FMDatabase databaseWithPath:dbPath];
    [collectionDB open];
    BOOL isSuccess = [collectionDB executeUpdate:@"create table if not exists CollectionTable(simp text,pinyin text,zhuyin text,tra text,frame text,bushou text,bsnum text,num text,seq text,base text,hanyu text,idiom text,english text)"];
    return isSuccess;
}

+(BOOL)insertModel:(WordsModel *)model{
    BOOL isSuccess = [self setDataBase];
    if (isSuccess) {
        BOOL insert = [collectionDB executeUpdate:@"insert or replace into CollectionTable(simp,pinyin,zhuyin,tra,frame,bushou,bsnum,num,seq,base,hanyu,idiom,english)values(?,?,?,?,?,?,?,?,?,?,?,?,?)",model.wordText,model.alphabetText,model.zhuyinText,model.traText,model.freamText,model.radicalText,model.radcalNum,model.numberText,model.seqText,model.baseText,model.hanyuText,model.idiomText,model.englishText];
        return insert;
    }
    return NO;
}

+(BOOL)deleteModel:(WordsModel *)model{
    BOOL isSuccess = [self setDataBase];
    if (isSuccess) {
        BOOL delete = [collectionDB executeUpdate:@"delete from CollectionTable where simp = ?",model.wordText];
        return delete;
    }
    return NO;
}

+(NSArray *)findALLCollection{
    NSMutableArray *mArray = [NSMutableArray new];
    BOOL isSuccess = [self setDataBase];
    if (isSuccess) {
        FMResultSet *set = [collectionDB executeQuery:@"select * from CollectionTable"];
        while ([set next]) {
            WordsModel *model = [WordsModel new];
            model.wordText = [set stringForColumn:@"simp"];
            model.alphabetText = [set stringForColumn:@"pinyin"];
            model.zhuyinText = [set stringForColumn:@"zhuyin"];
            model.radicalText = [set stringForColumn:@"bushou"];
            model.radcalNum = [set stringForColumn:@"bsnum"];
            model.traText = [set stringForColumn:@"tra"];
            model.baseText = [set stringForColumn:@"base"];
            model.englishText = [set stringForColumn:@"english"];
            model.freamText = [set stringForColumn:@"frame"];
            model.hanyuText = [set stringForColumn:@"hanyu"];
            model.createText = [set stringForColumn:@"create"];
            model.seqText = [set stringForColumn:@"seq"];
            model.numberText = [set stringForColumn:@"num"];
            [mArray addObject:model];
        }
        return mArray;
    }
    return nil;
}





@end
