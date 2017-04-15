//
//  NewtonsCradleViewController.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/18.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "NewtonsCradleViewController.h"
#import "NewtonsCradleView.h"

@interface NewtonsCradleViewController ()

@property (nonatomic, strong) NewtonsCradleView *newtonsView;

@end

@implementation NewtonsCradleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NewtonsCradleView *view = [[NewtonsCradleView alloc] initWithFrame:self.view.bounds];
    self.newtonsView = view;
    [self.view addSubview:view];
    
}


@end
