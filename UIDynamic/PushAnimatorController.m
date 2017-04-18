//
//  DynamicAnimator.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "PushAnimatorController.h"

@interface PushAnimatorController ()

@property (nonatomic, strong) UIDynamicAnimator *defaultAnimator;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@property (nonatomic, strong) UIView *itemView;

@end

@implementation PushAnimatorController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.defaultAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"begin" style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarBtn:)];
    self.navigationItem.rightBarButtonItem = barBtn;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor grayColor];
//    self.itemView = view;
//    [self.view addSubview:view];
    
    [self createGestureRecognizer];
    [self createSmallSquareView];
    [self createAnimatorAndBehaviors];
    
}

- (void)clickedRightBarBtn:(id)sender{
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.itemView] mode:UIPushBehaviorModeContinuous];
//    push.pushDirection = CGVectorMake(100, 100);
    [self.defaultAnimator addBehavior:push];
    
}

- (void) createGestureRecognizer{  //侦测视图单击
    UITapGestureRecognizer *tapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (void) handleTap:(UITapGestureRecognizer *)paramTap{
    
    CGPoint tapPoint = [paramTap locationInView:self.view];  //p2
    CGPoint squareViewCenterPoint = self.itemView.center;  //p1
    
    CGFloat deltaX = tapPoint.x - squareViewCenterPoint.x;
    CGFloat deltaY = tapPoint.y - squareViewCenterPoint.y;
    CGFloat angle = atan2(deltaY, deltaX);
    [self.pushBehavior setAngle:angle + M_PI];  //推移的角度
    
    //勾股
    CGFloat distanceBetweenPoints =
    sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) +
         pow(tapPoint.y - squareViewCenterPoint.y, 2.0));
    //double pow(double x, double y）;计算以x为底数的y次幂
    //double sqrt (double);开平方
    
    [self.pushBehavior setMagnitude:distanceBetweenPoints / 100.0f]; //推力的大小（移动速度）
    //每1个magnigude将会引起100/平方秒的加速度，这里分母越大，速度越小
    
}
- (void) createSmallSquareView{
    self.itemView =[[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    
    self.itemView.backgroundColor = [UIColor greenColor];
    self.itemView.center = self.view.center;
    
    [self.view addSubview:self.itemView];
}
- (void) createAnimatorAndBehaviors{
    self.defaultAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    /* Create collision detection */
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]
                                      initWithItems:@[self.itemView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    self.pushBehavior = [[UIPushBehavior alloc]
                         initWithItems:@[self.itemView]
                         mode:UIPushBehaviorModeContinuous];
    
    [self.defaultAnimator addBehavior:collision];
    [self.defaultAnimator addBehavior:self.pushBehavior];
}

@end






















