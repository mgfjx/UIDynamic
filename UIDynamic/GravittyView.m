//
//  GravittyView.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "GravittyView.h"

@interface GravittyView ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

@end

@implementation GravittyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (self.path) {
        
        [[UIColor redColor] setFill];
        [[UIColor greenColor] setStroke];
        [self.path fill];
        [self.path stroke];
        
    }
    
}
@end
