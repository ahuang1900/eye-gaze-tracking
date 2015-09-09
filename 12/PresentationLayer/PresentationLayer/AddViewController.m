//
//  AddViewController.m
//  PresentationLayer
//
//  Created by huangshenghui on 15/9/9.
//  Copyright (c) 2015年 YY Inc. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onclickDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onclickSave:(id)sender
{
    NoteBL *bl =  [[NoteBL alloc] init];
    Note *note = [[Note alloc] init];
    note.date = [[NSDate alloc] init];
    note.content = self.txtView.text;
    NSMutableArray *reslist = [bl createNote:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:reslist userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
