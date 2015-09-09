//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteDAO : NSObject

+ (NoteDAO*)sharedManager;

- (NSString *)applicationDocumentsDirectoryFile;
- (void)createEditableCopyOfDatabaseIfNeeded;

//插入Note方法
-(int) create:(Note*)model;

//删除Note方法
-(int) remove:(Note*)model;

//修改Note方法
-(int) modify:(Note*)model;

//查询所有数据方法
-(NSMutableArray*) findAll;

//按照主键查询数据方法
-(Note*) findById:(Note*)model;

@end
