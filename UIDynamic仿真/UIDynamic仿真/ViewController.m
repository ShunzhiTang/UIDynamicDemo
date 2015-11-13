//
//  ViewController.m
//  UIDynamic仿真
//  Created by Tsz on 15/11/12.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *fristLabel;

//设置一个全局的物理仿真器
@property (nonatomic ,strong)UIDynamicAnimator *animator;

@end

@implementation ViewController

/**
 * 懒加载
 */
- (UIDynamicAnimator *)animator{
    if (_animator == nil) {
        _animator  = [[UIDynamicAnimator alloc] init];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gravityBehaviour];
}
#pragma mark 实现重力行为
- (void)gravityBehaviour{
    
    //1、创建一个物理仿真器（顺便设置仿真范围）
    
    //2、创建相应的物理仿真行为
    
    /*
     UIGravityBehavior：重力行为
     UICollisionBehavior：碰撞行为
     UISnapBehavior：捕捉行为
     UIPushBehavior：推动行为
     UIAttachmentBehavior：附着行为
     UIDynamicItemBehavior：动力元素行为
     */
    
    UIDynamicBehavior *behavior = [[UIGravityBehavior alloc]initWithItems:@[self.fristLabel]];
    //3、将物理仿真行为添加到物理仿真器中  开始仿真
    
    [self.animator addBehavior:behavior];
}

@end
