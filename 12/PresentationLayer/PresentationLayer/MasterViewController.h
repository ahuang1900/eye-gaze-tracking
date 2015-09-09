//
//  MasterViewController.h
//  PresentationLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

@class DetailViewController;


@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;

//保存数据列表
@property (nonatomic,strong) NoteBL* bl;

@end
