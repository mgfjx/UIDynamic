//
//  AttachmentBehaviorController.m
//  UIDynamic
//
//  Created by mgfjx on 2017/4/17.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "AttachmentBehaviorController.h"

@interface AttachmentBehaviorController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIView *itemView;


@end

@implementation AttachmentBehaviorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
}

- (void) createSmallSquareView{
    self.itemView =[[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    
    self.itemView.backgroundColor = [UIColor randomColor];
    self.itemView.center = self.view.center;
    
    [self.view addSubview:self.itemView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    self.attachmentBehavior.anchorPoint = point;
//    self.attachmentBehavior.anchorPoint = point;
}

- (void)handlePah:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
//        CGPoint point = CGPointMake(self.itemView.center.x, self.itemView.center.y - 150);
        CGPoint point = [pan locationInView:self.view];
        //吸附
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.itemView attachedToAnchor:point];
        attachment.damping = 0.1;
        [self.animator addBehavior:attachment];
        self.attachmentBehavior = attachment;
    }else if(pan.state == UIGestureRecognizerStateChanged){
        self.attachmentBehavior.anchorPoint = [pan locationInView:self.view];
    }else if(pan.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachmentBehavior];
    }
}

@end
