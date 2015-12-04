//
//  MLCompatibleAlert.h
//  Lanmaq
//
//  Created by zml on 15/10/3.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.
/*
 Because of (use UIActionSheet in iOS 9.0 something bad， It will be show in demo)
 ************************************************************************************************
 // UIActionSheet NS_CLASS_DEPRECATED_IOS(2_0, 8_3, "UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead") __TVOS_PROHIBITED
 ************************************************************************************************

 // UIAlerView NS_CLASS_DEPRECATED_IOS(2_0, 9_0, "UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead") __TVOS_PROHIBITED
 ************************************************************************************************
 // UIAlertController NS_CLASS_AVAILABLE_IOS(8_0)
 ************************************************************************************************
 I do this CompatibleAlert!!
 
 1. Use UIAlertController in iOS 8.0 or high
 2. Use UIActionSheet and UIAlertView in IOS(6_0, 8_3)
 3. Suppot create any type alert button dynamic！and click return index all the same of system UI
 */
//https://github.com/Lanmaq/MLCompatibleAlert

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Below iOS 8.0, use UIAlertView or UIActionSheet you can set it's style
typedef NS_ENUM(NSInteger, MLAlertViewStyle) {
    MLAlertViewStyleDefault = 0,
    MLAlertViewStyleSecureTextInput,
    MLAlertViewStylePlainTextInput,
    MLAlertViewStyleLoginAndPasswordInput
};

typedef NS_ENUM(NSInteger, MLActionSheetStyle) {
    MLActionSheetStyleAutomatic        = -1,       // take appearance from toolbar style otherwise uses 'default'
    MLActionSheetStyleDefault,
    MLActionSheetStyleBlackTranslucent,
    MLActionSheetStyleBlackOpaque ,
};

//show sheet or alert
typedef NS_ENUM(NSInteger,MLCompatibleAlertStyle){
    MLAlertStyleActionSheet = 0,
    MLAlertStyleAlert
};

@protocol  MLCompatibleAlertDelegate;
@interface MLCompatibleAlert : NSObject

//I don't do well in this UIAlertView and UIActionSheet style, if you don't use defaultStyle!!! use default you needn't set anything!!
@property(nonatomic, assign)  MLActionSheetStyle actionSheetStyle;
@property(nonatomic, assign)  MLAlertViewStyle alertViewStyle;
@property (nonatomic, assign)NSInteger tag;// add tag

- (instancetype) initWithPreferredStyle:(MLCompatibleAlertStyle)preferredStyle
                                  title:(NSString *)title
                                message:(NSString *)message
                               delegate:(id<MLCompatibleAlertDelegate>)delegate
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void) showAlertWithParent: (UIViewController *)parentVC;

//You can add a text field only if the preferredStyle property is set to MLAlertControllerStyleAlert. Available in iOS 8.0 and later
// Set MLAlertViewStyle for iOS 7
- (void) addTextFieldsWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

// return textfields  on alert
@property (nonatomic, strong,readonly) NSArray<UITextField *> *textFields;

@end

@protocol MLCompatibleAlertDelegate <NSObject>
//buttonIndex is all the same UIActionSheet/UIAlertView/UIAlertController
//you can set alert's tag ，use tag for difference between others alert
- (void) compatibleAlert:(MLCompatibleAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

