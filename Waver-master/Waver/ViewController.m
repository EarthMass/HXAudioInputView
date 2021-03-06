//
//  ViewController.m
//  Waver
//
//  Created by kevinzhow on 14/12/14.
//  Copyright (c) 2014年 Catch Inc. All rights reserved.
//

#import "ViewController.h"

#import <Masonry.h>

#import "HXAudioInputView.h"
#import "UIButton+AudioInputBtn.h"



@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    //按钮
    UIButton * btn = [[UIButton alloc] init];

    [btn setTitle:@"录音" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(50);
    }];
    
    //添加手势
    __weak typeof(btn) weakBtn = btn;
    [btn addGesWithBlk:^(NSTimeInterval time, BOOL isLong) {
        NSLog(@"isLong %d",isLong);
       
//初始化
//        HXAudioInputView * audioInputView = [HXAudioInputView new];
        
        //单例
        HXAudioInputView * audioInputView = [HXAudioInputView shareInstance];
        
        //结束操作 是否隐藏，默认隐藏
        audioInputView.endInputDismiss = NO;
        //显示
        [audioInputView showInController:self];
        
        //是否长按
        [audioInputView beginLisheningWithShowType:!isLong?HXAudioInputViewShowTypeListen:HXAudioInputViewShowTypePressListhen];
        //初始等待状态
//        [audioInputView beginLisheningWithShowType:HXAudioInputViewShowTypeWait];
        if (isLong) {
#warning 把按钮手势传递给 弹窗， 用于长按 手势于 弹窗按钮长按一致
            [weakBtn addGesCombineToInput:audioInputView];
        }
        
        //三种状态回调
        [audioInputView setBeginBlk:^{
            //开始
            NSLog(@"开始");
            
        } endBlk:^{
            //结束
            NSLog(@"结束");
            
        } cancelBlk:^{
            //取消
            NSLog(@"取消");
            
        }];
        
        //空数据
//          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//              [[HXAudioInputView shareInstance] reLisheningFail:YES];
//          });
        
    }];

 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
