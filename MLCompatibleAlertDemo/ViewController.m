//
//  ViewController.m
//  MLCompatibleAlertDemo
//
//  Created by zml on 15/12/3.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.
//

#import "ViewController.h"
#import "MLCompatibleAlert.h"

@interface ViewController ()<MLCompatibleAlertDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)alertStyleActionSheetButtonClicked:(id)sender;
- (IBAction)alertStyleAlertButtonClicked:(id)sender;
@property (nonatomic ,strong) MLCompatibleAlert *alert;

@end

@implementation ViewController

- (IBAction)alertStyleActionSheetButtonClicked:(id)sender
{
    MLCompatibleAlert *alert = [[MLCompatibleAlert alloc]
                                initWithPreferredStyle: MLAlertStyleActionSheet //MLAlertStyleAlert
                                title:@"MLAlertStyleActionSheet"
                                message:@"It's a actionSheet"
                                delegate: self
                                cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:@"Delete"
                                otherButtonTitles:@"Send message",@"Send photo",nil];
   alert.tag = 99;
    [alert showAlertWithParent:self];
}

- (IBAction)alertStyleAlertButtonClicked:(id)sender
{
    MLCompatibleAlert *alert = [[MLCompatibleAlert alloc]
                                initWithPreferredStyle: MLAlertStyleAlert //MLAlertStyleActionSheet
                                title:@"MLAlertStyleAlert"
                                message:@"It's a alertView"
                                delegate: self
                                cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"Add friend",@"Do more for code",nil];
    /*
   //  if you use textField i don't write wll for this
    //iOS 7
    alert.alertViewStyle = MLAlertViewStyleLoginAndPasswordInput;
    //    Add a text field only if the preferredStyle property is set to MLAlertControllerStyleAlert.
    // iOS8
    [alert addTextFieldsWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Login in";
    }];
    [alert addTextFieldsWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
    }];
  */
    alert.tag = 999;

    [alert showAlertWithParent:self];
}

#pragma mark - MLCompatibleAlertDelegate
- (void)compatibleAlert:(MLCompatibleAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alert.tag == 99)
    {
        switch (buttonIndex) {
            case 0:
                self.displayLabel.text = [NSString stringWithFormat:@"Send message Clicked ! buttonIndex:%ld",(long)buttonIndex];
                break;
            case 1:
                self.displayLabel.text = [NSString stringWithFormat:@"Send photo Clicked ! buttonIndex:%ld",(long)buttonIndex];
                self.displayLabel.textColor = [UIColor orangeColor];
                break;
            case 2:
                self.displayLabel.text = [NSString stringWithFormat:@"Delete Clicked !buttonIndex:%ld",(long)buttonIndex];
                self.displayLabel.textColor = [UIColor redColor];
                break;
            case 3:
                self.displayLabel.text = [NSString stringWithFormat:@"Cancel Clicked ! buttonIndex:%ld",(long)buttonIndex];
                self.displayLabel.textColor = [UIColor blueColor];
            default:
                break;
        }
    }
    else if(alert.tag == 999)
    {
        NSArray *textFields = alert.textFields;
        UITextField *textField = textFields[0];
        switch (buttonIndex) {
            case 0:
                self.displayLabel.text = [NSString stringWithFormat:@"Cancel Clicked !!! buttonIndex:%ld",(long)buttonIndex];
                self.displayLabel.textColor = [UIColor blackColor];
                break;
            case 1:
                self.displayLabel.text = [NSString stringWithFormat:@"Do more for code Clicked TextField:%@!!! buttonIndex:%ld",textField.text,(long)buttonIndex];
                self.displayLabel.textColor = [UIColor blackColor];
                break;
            case 2:
                self.displayLabel.text = [NSString stringWithFormat:@"Add friend Clicked TextField:%@!!! buttonIndex:%ld",textField.text,(long)buttonIndex];
                self.displayLabel.textColor = [UIColor blackColor];
                break;
            default:
                break;
        }
    }
}

@end
