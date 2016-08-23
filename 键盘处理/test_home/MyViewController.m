//
//  MyViewController.m
//  test_home
//
//  Created by hc_hzc on 16/8/2.
//  Copyright © 2016年 hc_hzc. All rights reserved.
//

#import "MyViewController.h"
#import "RYNumberKeyboard.h"
#import "UITextField+RYNumberKeyboard.h"

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface MyViewController ()<UITextFieldDelegate>
/***/
@property (nonatomic, weak)UITextField *idCardTF;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

    UITextField *idCardTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 300, 300, 44)];
    idCardTF.backgroundColor = [UIColor grayColor];
    idCardTF.ry_inputAccessoryText = @"请输入身份证号";//键盘上面的输入提示
    idCardTF.ry_inputType = RYIDCardInputType;//自定义键盘  身份证键盘 、浮点数键盘、整数键盘
//    idCardTF.keyboardType =  UIKeyboardTypeNumberPad; //系统键盘
//    idCardTF.ry_interval = 6;//隔多少位空一格;限制字数时无效

    idCardTF.backgroundColor = [UIColor grayColor];
    idCardTF.font= [UIFont systemFontOfSize:13];
    idCardTF.textColor = [UIColor redColor];
    idCardTF.placeholder= @"请输入身份证号";
    [idCardTF setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    idCardTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [idCardTF addTarget:self action:@selector(reTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    idCardTF.delegate = self;
    [self.view addSubview:idCardTF];
    self.idCardTF = idCardTF;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //判断如果是iPhone4系列的就让view往上移动
    if (iPhone4 && textField == _idCardTF) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -85);
        }];
    }
}
- (void)reTextFieldDidChange:(UITextField *)textField{//输入文本时调用
    //解决输入中文时 字母乱码的问题
    UITextRange *selectedRange = [textField markedTextRange];
    NSString * newText = [textField textInRange:selectedRange];
    if(newText.length>0) return;
    //不允许输入空格
//    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //限制联想输入时字数问题
    textField.text = textField.text.length > 18 ? [textField.text substringToIndex:18] : textField.text;
    
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    return  (textField.text.length - range.length + string.length) <= 18;
//}


#pragma mark- 让键盘消失
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{//点击了return键
//    [self KBDisappear];
//    return YES;
//}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [self KBDisappear];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self KBDisappear];
}
- (void)KBDisappear{
    //iPhone4下键盘消失时让view复原
    if (iPhone4) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
    
    [self.idCardTF resignFirstResponder];
    
}



@end
