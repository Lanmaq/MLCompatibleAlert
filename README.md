# MLCompatibleAlert

##introduction

 See UIActionSheet/UIAlertView/UIAlertController Class Reference

```objective-c
UIActionSheet    NS_CLASS_DEPRECATED_IOS(2_0, 8_3, "UIActionSheet is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleActionSheet instead") __TVOS_PROHIBITED

 UIAlerView         NS_CLASS_DEPRECATED_IOS(2_0, 9_0, "UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead") __TVOS_PROHIBITED

 UIAlertController NS_CLASS_AVAILABLE_IOS(8_0)
```

 Apple in iOS8 introduced a brand-new UIAlertController, the old UIAlertView and UIActionSheet gradually abandoned, but if you still support iOS7 system, you will have to write two sets of code. The 'MLCompatibleAlert' solve this problem and support for dynamic create alert's otherTitle button,easy to use!

##Features

Because of (use UIActionSheet in iOS 9.0(higher iOS 8.3) something bad,it will be show in demo)

I create MLCompatibleAlert:

 - Use UIAlertController in iOS 8.0 or high

 - Use UIActionSheet and UIAlertView in IOS(6_0, 8_3)

 - Suppot create any type alert button dynamic and click return index all the same of system UIActionSheet、UIAlertView、UIAlertController.

![sample](https://raw.githubusercontent.com/Lanmaq/MLCompatibleAlert/master/Alert.gif)

For first-hand experience, just open the project and run it.

## Installation (CocoaPods)

```ruby
platform :ios, '6.0'
pod "MLCompatibleAlert", "~> 0.0.1"
```

if it's unable to find

‘pod setup'

'pod search MLCompatibleAlert'

## Requirements

- iOS 6.0+
- ARC
- Note: ARC can be turned on and off on a per file basis.

##Usage

See the code snippet below for an example of how to implement, or example project would be easy to understand.

You can use the property `preferredStyle` to control which the alert  is shown，and add otherButtonTitles by the parameters of the otherButtonTitles

```objective-c
MLCompatibleAlert *alert = [[MLCompatibleAlert alloc]
                                initWithPreferredStyle: MLAlertStyleActionSheet //MLAlertStyleAlert
                                                             title:@"MLAlertStyleActionSheet"
                                                    message:@"It's a actionSheet"
                                                     delegate: self
                                        cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:@"Delete"
                                         otherButtonTitles:@"Send message",@"Send photo",nil];

[alert showAlertWithParent:self];

```

The protocol like system UI

```objective-c
- (void) compatibleAlert:(MLCompatibleAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
    //do something
}

```

To do well ,i don't write wll for using alert with textField 

```objective-c

//  if you use textField iOS 7
alert.alertViewStyle = MLAlertViewStyleLoginAndPasswordInput;
//    Add a text field only if the preferredStyle property is set to MLAlertControllerStyleAlert.
// iOS 8 or higher
[alert addTextFieldsWithConfigurationHandler:^(UITextField *textField) {
textField.placeholder = @"Login in";
}];
[alert addTextFieldsWithConfigurationHandler:^(UITextField *textField) {
textField.placeholder = @"Password";
}];

```

## License (MIT License)
Copyright (c) 2015 Lanmaq

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
I will keep learning improve this code or my other codes,improving the coding ability to do more for code!  talk is cheap，show me the code.