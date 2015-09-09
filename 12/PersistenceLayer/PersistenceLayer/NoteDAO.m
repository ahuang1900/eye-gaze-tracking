//
//  NoteDAO.m
//  PersistenceLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO

static NoteDAO *sharedManager = nil;

+ (NoteDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedManager;
}


- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"错误写入文件：'%@'。", [error localizedDescription]);
        }
    }
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    
    return path;
}


//插入Note方法
-(int) create:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDictionary* dict = [NSDictionary
                          dictionaryWithObjects:@[[dateFormat stringFromDate: model.date],model.content]
                          forKeys:@[@"date",@"content"]];
    
    [array addObject:dict];
    
    [array writeToFile:path atomically:YES];
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        //Note* note = [[Note alloc] init];
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        //note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [array removeObject: dict];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        NSString* content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [dict setValue:content forKey:@"content"];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    //[self.listData removeAllObjects];
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Note* note = [[Note alloc] init];
        note.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        [listData addObject:note];
        
    }
    return listData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Note* note = [[Note alloc] init];
        note.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([note.date isEqualToDate:model.date]){
            return note;
        }
    }
    return nil;
}


@end

