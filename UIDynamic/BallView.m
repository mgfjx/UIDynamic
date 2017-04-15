//
//  BallView.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/18.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "BallView.h"

@implementation BallView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        
    }
    return self;
}

@end
