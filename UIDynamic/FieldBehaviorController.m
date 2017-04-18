//
//  FieldBehaviorController.m
//  UIDynamic
//
//  Created by mgfjx on 2017/4/17.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "FieldBehaviorController.h"

@interface FieldBehaviorController ()

@property (nonatomic, strong) UIFieldBehavior *fieldBehavior;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *itemView;


@end

@implementation FieldBehaviorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)start{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self createSmallSquareView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePah:)];
    [self.view addGestureRecognizer:pan];
    
    //碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.itemView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    //重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.itemView]];
    gravity.magnitude = 1;
    [self.animator addBehavior:gravity];
    
    //
    UIFieldBehavior *field = [UIFieldBehavior vortexField];
    [field addItem:self.itemView];
    [self.animator addBehavior:field];
    self.fieldBehavior = field;
}

- (void) createSmallSquareView{
    self.itemView =[[UIView alloc] initWithFrame: CGRectMake(150.0f, 84.0f, 40.0f, 40.0f)];
    
    self.itemView.backgroundColor = [UIColor randomColor];
//    self.itemView.center = self.view.center;
    
    [self.view addSubview:self.itemView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    self.fieldBehavior.position = point;
}

- (void)handlePah:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [pan locationInView:self.view];
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
    }
}


@end
