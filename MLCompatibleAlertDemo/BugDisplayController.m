//
//  BugDisplayController.m
//  MLCompatibleAlertDemo
//
//  Created by zml on 15/12/4.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.
//

#import "BugDisplayController.h"
#import "MLCompatibleAlert.h"
@interface BugDisplayController()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end
@implementation BugDisplayController

- (IBAction)stepTwo:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Test" delegate:nil cancelButtonTitle:@"Cancle" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Bad thing",nil];
    [actionSheet showInView:self.view];
}
- (IBAction)compatibleAlert:(id)sender
{
    MLCompatibleAlert *alert = [[MLCompatibleAlert alloc]initWithPreferredStyle:MLAlertStyleActionSheet title:@"Test" message:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Bad thing",nil];
    [alert showAlertWithParent:self];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}
@end
