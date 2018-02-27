//
//  ViewController.m
//  Demo
//
//  Created by gongren on 15/12/31.
//  Copyright © 2015年 gongren. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#define kScreenWidth     [UIScreen mainScreen].bounds.size.width

#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertAction *secureTextAlertAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(kScreenWidth / 2 - 30, 200, 60, 30);
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = 5;
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (void)handleAction:(UIButton *)sender {
    
    //    [self showAlertAction];
    
    //两个按钮的提示框
    [self showAlertActionController];
    
    //多个按钮的提示框
//    [self showMoreAlertActionController];
    
    //带有输入框的提示框
//    [self showPromptAlertActionController];
    
    //alertview和actionsheet结合
//    [self showOkayCancelActionSheet];
    
//    [self show];
    
}


- (void)showAlertAction{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你好" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"点击了取消");
    }
    NSLog(@"点击了确定");
    
}

//第二种提示框(两个按钮的)
- (void)showAlertActionController {
    NSString *title = NSLocalizedString(@"hahahaha", nil);
    NSString *message = NSLocalizedString(@"heiheihei", nil);
    NSString *cancleButtonTitle = NSLocalizedString(@"cancle", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"ok", nil);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleButtonTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消按钮");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定按钮");
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:otherAction];
    
    [self presentViewController:alert animated:YES completion:nil];

}

//多个按钮的提示框
- (void)showMoreAlertActionController {
    NSString *title = NSLocalizedString(@"提示", nil);
    NSString *message = NSLocalizedString(@"你确定要走嘛？", nil);
    NSString *cancle = NSLocalizedString(@"取消", nil);
    NSString *choice = NSLocalizedString(@"确定", nil);
    NSString *choicetwo = NSLocalizedString(@"不知道", nil);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    
    UIAlertAction *choiceAction = [UIAlertAction actionWithTitle:choice style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定按钮");
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        [self presentViewController:firstVC animated:YES completion:nil];
    }];
    
    UIAlertAction *choiceTwoAction = [UIAlertAction actionWithTitle:choicetwo style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了不知道");
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        [self presentViewController:secondVC animated:YES completion:nil];
    }];
    
    [alertVC addAction:cancleAction];
    [alertVC addAction:choiceAction];
    [alertVC addAction:choiceTwoAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)test {
        NSString *title = NSLocalizedString(@"A Short Title Is Best", nil);
        NSString *message = NSLocalizedString(@"A message should be a short, complete sentence.", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
        // Add the text field for the secure text entry.
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            // Listen for changes to the text field's text so that we can toggle the current
            // action's enabled property based on whether the user has entered a sufficiently
            // secure entry.
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
    
            textField.secureTextEntry = YES;
        }];
    
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Secure Text Entry\" alert's cancel action occured.");
    
            // Stop listening for text changed notifications.
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
        }];
    
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"The \"Secure Text Entry\" alert's other action occured.");
    
            // Stop listening for text changed notifications.
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
        }];
    
        // The text field initially has no text in the text field, so we'll disable it.
        otherAction.enabled = NO;
    
        // Hold onto the secure text alert action to toggle the enabled/disabled state when the text changed.
        self.secureTextAlertAction = otherAction;
    
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    
}

//带有输入框的提示框
- (void)showPromptAlertActionController {
    
    NSString *title = NSLocalizedString(@"温馨提示", nil);
    NSString *message = NSLocalizedString(@"请输入密码", nil);
    NSString *cancleButtonTitle = NSLocalizedString(@"cancle", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"ok", nil);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.backgroundColor = [UIColor orangeColor];
        textField.placeholder= @"请输入保存模板的名称，15内";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
//        textField.secureTextEntry = YES;
        
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleButtonTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消按钮");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alert.textFields.firstObject];
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定按钮");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alert.textFields.firstObject];
        ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
        thirdVC.string = alert.textFields.firstObject.text;
        [self presentViewController:thirdVC animated:YES completion:nil];
    }];
    
    otherAction.enabled = NO;
    self.secureTextAlertAction = otherAction;
    
    [alert addAction:cancleAction];
    [alert addAction:otherAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    
    UITextField *textField = notification.object;
    // Enforce a minimum length of >= 5 characters for secure text alerts.
    self.secureTextAlertAction.enabled = textField.text.length >= 5;
}

//alert和actionsheet结合
- (void)showOkayCancelActionSheet {
    
//    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
//    NSString *destructiveButtonTitle = NSLocalizedString(@"OK", nil);
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注意注意" preferredStyle:UIAlertControllerStyleActionSheet];
//
//
//    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        //修改按钮颜色
//        [action setValue:[UIColor greenColor] forKey:@"titleTextColor"];
//
//
//    }];
//
//    // Create the actions.
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//    }];
//
//
//
//    // Add the actions.
//    [alertController addAction:destructiveAction];
//    [alertController addAction:cancelAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示内容" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"heihei"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    
    //修改按钮的颜色，同上可以使用同样的方法修改内容，样式
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Default" style:UIAlertActionStyleDefault handler:nil];
    [defaultAction setValue:[UIColor blueColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [cancelAction setValue:[UIColor greenColor] forKey:@"_titleTextColor"];
    
    [alertController addAction:defaultAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)show {

    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(60, 100, 200, 100))];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    button.frame = CGRectMake(60, 60, 60, 30);
    [button setTitle:@"移除" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(handleCancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
    [self.view addSubview:view];
}

- (void)handleCancelAction:(UIButton *)sender {

    UIView *view = sender.superview;
    [view removeFromSuperview];
}



@end
