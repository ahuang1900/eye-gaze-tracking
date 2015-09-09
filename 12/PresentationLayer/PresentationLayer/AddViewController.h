//
//  AddViewController.h
//  PresentationLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

@interface AddViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtView;
- (IBAction)onclickDone:(id)sender;
- (IBAction)onclickSave:(id)sender;


@end
