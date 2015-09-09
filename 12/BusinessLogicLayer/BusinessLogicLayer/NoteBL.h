//
//  NoteBL.h
//  BusinessLogicLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAO.h"

@interface NoteBL : NSObject


//插入Note方法
-(NSMutableArray*) createNote:(Note*)model;

//删除Note方法
-(NSMutableArray*) remove:(Note*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;


@end
