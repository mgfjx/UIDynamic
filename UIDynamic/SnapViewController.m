//
//  SnapViewController.m
//  UIDynamic
//
//  Created by mgfjx on 2017/4/17.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "SnapViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface SnapViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIView *attachItem;

//添加重力感应
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation SnapViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.motionManager stopGyroUpdates];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self createSmallSquareView];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.itemView snapToPoint:self.itemView.center];
    snap.damping = 0.9;
    [self.animator addBehavior:snap];
    self.snapBehavior = snap;
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.attachItem]];
    gravity.magnitude = 1;
    [self.animator addBehavior:gravity];
    self.gravityBehavior = gravity;
    
    //吸附
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.attachItem offsetFromCenter:UIOffsetMake(0, 0) attachedToItem:self.itemView offsetFromCenter:UIOffsetMake(0, 100)];
    attachment.damping = 0.25;
    [self.animator addBehavior:attachment];
    self.attachmentBehavior = attachment;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.itemView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePah:)];
    [self.view addGestureRecognizer:pan];
    
    //添加重力感应
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.motionManager = manager;
    if (manager.isAccelerometerAvailable) {
        [manager setGyroUpdateInterval:1/24.0];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [manager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                CGFloat changeX = accelerometerData.acceleration.x ;
                CGFloat changeY = accelerometerData.acceleration.y ;
                self.gravityBehavior.gravityDirection = CGVectorMake(changeX, -changeY);
                
            });
        }];
    }
    
}

- (void) createSmallSquareView{
    self.itemView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    
    self.itemView.backgroundColor = [UIColor randomColor];
    self.itemView.center = self.view.center;
    
    [self.view addSubview:self.itemView];
    
    {
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        view.backgroundColor = [UIColor randomColor];
        view.center = self.view.center;
        [self.view addSubview:view];
        self.attachItem = view;
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    self.snapBehavior.snapPoint = point;
}

- (void)handlePah:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [pan locationInView:self.view];
        self.snapBehavior.snapPoint = point;
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGPoint point = [pan locationInView:self.view];
        self.snapBehavior.snapPoint = point;
    }
}

@end
