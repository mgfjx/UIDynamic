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
    
    if (isAvailable) {
        NSLog(@"CMMotionManager is GyroAvailable");
        
        if (self.motionManager.isGyroActive == NO) {
            [self.motionManager setGyroUpdateInterval:0];
            
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
                
//                NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
//                NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
//                NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    ball.center = CGPointMake(self.view.bounds.size.width/2 - gyroData.rotationRate.x * 100, self.view.bounds.size.height/2 - gyroData.rotationRate.y*100);
                    
                });
                
            }];
            
        }
        
    }
    
    if ([self.motionManager isAccelerometerAvailable]){
        NSLog(@"Accelerometer is available.");
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData*accelerometerData, NSError *error) {
                                                     
             NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
                
        }];
        
        
        
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.motionManager stopGyroUpdates];
}

@end
