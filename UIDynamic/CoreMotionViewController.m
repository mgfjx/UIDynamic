//
//  CoreMotionViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/18.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "CoreMotionViewController.h"
#import "BallView.h"

#import <CoreMotion/CoreMotion.h>

@interface CoreMotionViewController ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation CoreMotionViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BallView *ball = [[BallView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    ball.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:ball];
    
    self.motionManager = [[CMMotionManager alloc] init];
    
    BOOL isAvailable = self.motionManager.isGyroAvailable;
    
    /*
    if (isAvailable) {
        NSLog(@"CMMotionManager is GyroAvailable");
        
        if (self.motionManager.isGyroActive == NO) {
            [self.motionManager setGyroUpdateInterval:1/60.0];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
                
//                NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
//                NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
//                NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    CGFloat multiple = 50;
                    CGFloat changeX = gyroData.rotationRate.x * multiple;
                    CGFloat changeY = gyroData.rotationRate.y*multiple;
                    NSLog(@"changX = %f, changeY = %f", changeX, changeY);
                    ball.center = CGPointMake(self.view.bounds.size.width/2 - changeX, self.view.bounds.size.height/2 - changeY);
                    
                });
                
            }];
            
        }
        
    }
     */
    
    if ([self.motionManager isAccelerometerAvailable]){
        NSLog(@"Accelerometer is available.");
        [self.motionManager setGyroUpdateInterval:1/24.0];
     
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData*accelerometerData, NSError *error) {
                                                     
            dispatch_async(dispatch_get_main_queue(), ^{
                
                CGFloat multiple = 1000;
                CGFloat changeX = accelerometerData.acceleration.x * multiple;
                CGFloat changeY = accelerometerData.acceleration.y * multiple;
                NSLog(@"changX = %f, changeY = %f", changeX, changeY);
                ball.center = CGPointMake(self.view.bounds.size.width/2 + changeX, self.view.bounds.size.height/2 - changeY);
                
            });
            
        }];
        
        
        
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.motionManager stopGyroUpdates];
}

@end
