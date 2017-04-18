//
//  GravityViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "GravityViewController.h"
#import "GravittyView.h"

@interface GravityViewController ()<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;

@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) GravittyView *line;

@end

@implementation GravityViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view = [[GravittyView alloc] initWithFrame:self.view.bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 74, 40, 40);
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (void)clicked:(UIButton *)sender{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    view.backgroundColor = [UIColor grayColor];
    view.transform = CGAffineTransformMakeRotation(rand()%90);
    [self.view addSubview:view];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[view]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionDelegate = self;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, self.view.height - 80, 40, 20) cornerRadius:10];
//    [collision addBoundaryWithIdentifier:@"p1" forPath:path];
    
    GravittyView *gView = (GravittyView *)self.view;
    gView.path = path;
    [gView setNeedsDisplay];
    
    [self.animator addBehavior:collision];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
    gravity.magnitude = 1;
    [self.animator addBehavior:gravity];
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(nonnull id<UIDynamicItem>)item withBoundaryIdentifier:(nullable id<NSCopying>)identifier atPoint:(CGPoint)p{
    UIView *targetItem = (UIView *)item;
    targetItem.backgroundColor = [UIColor redColor];
}

@end
