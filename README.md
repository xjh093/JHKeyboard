# JHKeyboard
A category for keyboard manage.

---

# What
just download and run~

---

# Simple Code
```
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
```


---
