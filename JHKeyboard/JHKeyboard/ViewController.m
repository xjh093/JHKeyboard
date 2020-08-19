//
//  ViewController.m
//  JHKeyboard
//
//  Created by HaoCold on 2020/8/18.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+JHKeyboard.h"
#import "UITextField+JHKeyboard.h"

@interface ViewController ()
@property (nonatomic,  strong) UIView *backView;
@property (nonatomic,  strong) UITextView *textView;
@property (nonatomic,  strong) UITextField *textField;
@property (nonatomic,  assign) CGRect  originRect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.textField];
    [self.backView addSubview:self.textView];
    _originRect = _backView.frame;
    
    __weak typeof(self) wk = self;
    self.textField.jh_keyboard.changeBlock = ^(NSNotificationName  _Nonnull name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
        
        NSLog(@"textField:%@", name);
        
        if ([name isEqualToString:UIKeyboardWillShowNotification]) {
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = wk.backView.frame;
                frame.origin.y = endFrame.origin.y - frame.size.height - 10;
                wk.backView.frame = frame;
            }];
        }else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
            [UIView animateWithDuration:duration animations:^{
                wk.backView.frame = wk.originRect;
            }];
        }
    };
    
    self.textView.jh_keyboard.changeBlock = ^(NSNotificationName  _Nonnull name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
        
        NSLog(@"textView:%@", name);
        
        if ([name isEqualToString:UIKeyboardWillShowNotification]) {
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = wk.backView.frame;
                frame.origin.y = endFrame.origin.y - frame.size.height - 50;
                wk.backView.frame = frame;
            }];
        }else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
            [UIView animateWithDuration:duration animations:^{
                wk.backView.frame = wk.originRect;
            }];
        }
    };
}

- (UIView *)backView{
    if (!_backView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 210, CGRectGetWidth(self.view.frame), 200);
        view.backgroundColor = [UIColor grayColor];
        _backView = view;
    }
    return _backView;
}

- (UITextField *)textField{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(10, 10, CGRectGetWidth(self.view.frame)-20, 30);
        textField.font = [UIFont systemFontOfSize:16];
        textField.placeholder = @"登录密码";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField = textField;
    }
    return _textField;
}

- (UITextView *)textView{
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.frame = CGRectMake(10, 50, CGRectGetWidth(self.view.frame)-20, 100);
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:19];
        textView.textAlignment = NSTextAlignmentLeft;
        textView.showsVerticalScrollIndicator = NO;
        textView.layer.borderWidth = 1;
        textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView = textView;
    }
    return _textView;
}


@end
