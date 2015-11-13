//
//  ViewController.m
//  UIDynamic仿真
//  Created by Tsz on 15/11/12.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *fristLabel;
@property (weak, nonatomic) IBOutlet UIView *nextView;



//设置一个全局的物理仿真器
@property (nonatomic ,strong)UIDynamicAnimator *animator;

//捕捉行为
@property (nonatomic , strong)UISnapBehavior *snap;

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
    //重力行为
//    [self gravityBehaviour];
    
    //碰撞 + 重力
//    [self collisionAndGravity];
    
    if(self.snap == nil){
        CGPoint point = [[touches anyObject] locationInView:self.view];
        
        self.snap = [[UISnapBehavior alloc] initWithItem:self.fristLabel snapToPoint:point];
        
        //设置减震效果
        self.snap.damping = 0.5;
        
        //添加
        [self.animator addBehavior:self.snap];
    }
    
    
}

#pragma mark 碰撞 + 重力
- (void)collisionAndGravity{
    //2、创建仿真行为
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.fristLabel]];
    
    //设置向量
    gravity.gravityDirection = CGVectorMake(5, 1);
    
    gravity.angle = M_PI_2;
    
    //3、碰撞行为
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.fristLabel, self.nextView]];
    
    //变化范围
//    CGPoint fromPoint = CGPointMake(0, [UIScreen mainScreen].bounds.size.height * 0);
//         CGPoint toPoint = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1.0);
//    [collision addBoundaryWithIdentifier:@"collision" fromPoint:fromPoint toPoint:toPoint];
    //设置边界
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [collision addBoundaryWithIdentifier:@"collision" forPath:bezierPath];
    
    //添加
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
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
