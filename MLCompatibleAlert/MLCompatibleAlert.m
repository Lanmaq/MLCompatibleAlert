//
//  MLCompatibleAlert.h
//  Lanmaq
//
//  Created by zml on 15/10/3.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.

//  https://github.com/Lanmaq/MLCompatibleAlert

#import "MLCompatibleAlert.h"
#import <objc/runtime.h>

@interface MLCompatibleAlert ()<UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIActionSheet     *actionSheet;
@property (nonatomic, strong) UIAlertView         *alertView;

@property (nonatomic, assign) MLCompatibleAlertStyle  alertControllerStyle;
@property (nonatomic, weak)   id<MLCompatibleAlertDelegate>     delegate;

@end

@implementation MLCompatibleAlert

static void * const AssociatedStorageKey = (void*)&AssociatedStorageKey;

#pragma mark - initialize
- (instancetype) initWithPreferredStyle:(MLCompatibleAlertStyle)preferredStyle
                                  title:(NSString *)title
                                message:(NSString *)message
                               delegate:(id<MLCompatibleAlertDelegate>)delegate
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        objc_setAssociatedObject(self, AssociatedStorageKey, self, OBJC_ASSOCIATION_RETAIN);
        
        _delegate = delegate;
        self.alertControllerStyle = preferredStyle;

        NSMutableArray *titles = [NSMutableArray array];
        va_list argList;
        if (otherButtonTitles)
        {
            [titles addObject: otherButtonTitles];
            id arg;
            va_start(argList, otherButtonTitles);
            while ((arg = va_arg(argList, id)))
            {
                [titles addObject: arg];
            }
            va_end(argList);
        }
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            UIAlertControllerStyle alertControllerStyle;
            
            switch (preferredStyle)
            {
                case MLAlertStyleActionSheet:
                    alertControllerStyle = UIAlertControllerStyleActionSheet;
                    break;
                case MLAlertStyleAlert:
                    alertControllerStyle = UIAlertControllerStyleAlert;
                    break;
                default:
                    alertControllerStyle = UIAlertControllerStyleActionSheet;
                    break;
            }
            _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle];
             NSInteger index = 1;
            if (alertControllerStyle == MLAlertStyleActionSheet)
            {
                index = 0;
            }
            for (NSString *t in titles)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:t style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
                    {
                        [self.delegate compatibleAlert:self clickedButtonAtIndex:index];
                    }
                }];
                [_alertController addAction: action];
                ++index;
            }
            
            if (destructiveButtonTitle != nil)
            {
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
                    {
                        [self.delegate compatibleAlert:self clickedButtonAtIndex:index];
                    }
                }];
                [_alertController addAction: cancel];
                ++index;
            }
            
            if (cancelButtonTitle != nil)
            {
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    if (alertControllerStyle == MLAlertStyleActionSheet)
                    {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
                        {
                            [self.delegate compatibleAlert:self clickedButtonAtIndex:index];
                        }
                    }
                    else
                    {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
                        {
                            [self.delegate compatibleAlert:self clickedButtonAtIndex:0];
                        }
                    }
                }];
                [_alertController addAction: cancel];
            }
        }
        else
        {
            if (preferredStyle == MLAlertStyleActionSheet)
            {
                //default ActionSheetStyle!  I don't write well on it's style
                self.actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                for (NSString *otherTitle in titles)
                {
                     [self.actionSheet addButtonWithTitle:otherTitle];
                }
                if (destructiveButtonTitle)
                {
                    [self.actionSheet addButtonWithTitle:destructiveButtonTitle];
                    self.actionSheet.destructiveButtonIndex = self.actionSheet.numberOfButtons -1;
                }
                if (cancelButtonTitle)
                {
                    [self.actionSheet addButtonWithTitle:cancelButtonTitle];
                    self.actionSheet.cancelButtonIndex = self.actionSheet.numberOfButtons - 1;
                }
            }
            else if(preferredStyle == MLAlertStyleAlert)
            {
                //default Style I don't write well on it's style
                self.alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
                for (NSString *otherTitle in titles)
                {
                        [self.alertView addButtonWithTitle:otherTitle];
                }
            }
            
        }
    }
    return self;
}

#pragma mark - show compatibleAlert

- (void) showAlertWithParent:(UIViewController *)parentVC
{
    if (parentVC)
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            [parentVC presentViewController:self.alertController animated:YES completion:NULL];
        }
        else
        {
            switch (self.alertControllerStyle)
            {
                case MLAlertStyleActionSheet:
                    [self.actionSheet showInView:parentVC.view];
                    break;
                case MLAlertStyleAlert:
                    [self.alertView show];
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate&UIActionSheetDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
    {
        [self.delegate compatibleAlert:self clickedButtonAtIndex:buttonIndex];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.delegate &&  [self.delegate respondsToSelector:@selector(compatibleAlert:clickedButtonAtIndex:)])
    {
        [self.delegate compatibleAlert:self clickedButtonAtIndex:buttonIndex];
    }
}

//It's a final method for actionSheet click action
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    objc_setAssociatedObject(self, AssociatedStorageKey, nil, OBJC_ASSOCIATION_RETAIN);
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    objc_setAssociatedObject(self, AssociatedStorageKey, nil, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - private method addTextFields

- (void)addTextFieldsWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        [self.alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            configurationHandler(textField);
        }];
        self.textFields = self.alertController.textFields;
    }
    else
    {
        NSLog(@"Use MLAlertViewStyle,Set a Style like yourAlert.alertViewStyle = MLAlertViewStylePlainTextInput compate iOS 7,use this mothed for add textFild for iOS8!");
        return;
    }
}

#pragma mark - setTextFields

- (void)setTextFields:(NSArray<UITextField *> *)textFields
{
    _textFields = textFields;
}

#pragma mark - setAlertViewStyle

- (void)setAlertViewStyle:(MLAlertViewStyle)alertViewStyle
{
    _alertViewStyle = alertViewStyle;
    
    switch (_alertViewStyle)
    {
        case MLAlertViewStyleDefault:
            self.alertView.alertViewStyle = UIAlertViewStyleDefault;
            break;
        case MLAlertViewStyleSecureTextInput:
            self.alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            break;
        case MLAlertViewStylePlainTextInput:
            self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            break;
        case MLAlertViewStyleLoginAndPasswordInput:
            self.alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            break;
        default:
            self.alertView.alertViewStyle = UIAlertViewStyleDefault;
            break;
    }
    if (self.alertViewStyle != MLAlertViewStyleDefault)
    {
        if (self.alertViewStyle == MLAlertViewStyleLoginAndPasswordInput)
        {
            UITextField *textFieldOne = [self.alertView textFieldAtIndex:0];
            UITextField *textFieldTwo = [self.alertView textFieldAtIndex:1];
            self.textFields = @[textFieldOne,textFieldTwo];
        }
        else
        {
            UITextField *textFieldOne = [self.alertView textFieldAtIndex:0];
            self.textFields = @[textFieldOne];
        }
    }
}

#pragma mark - setActionSheetStyle

- (void)setActionSheetStyle:(MLActionSheetStyle)actionSheetStyle
{
    _actionSheetStyle = actionSheetStyle;
    
    switch (_actionSheetStyle)
    {
        case MLActionSheetStyleAutomatic:
            self.actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
            break;
        case MLActionSheetStyleDefault:
            self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            break;
        case MLActionSheetStyleBlackOpaque:
            self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            break;
        case MLActionSheetStyleBlackTranslucent:
            self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            break;
        default:
            self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            break;
    }
}
@end

