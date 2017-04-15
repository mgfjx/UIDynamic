//
//  GravittyView.m
//  UIDynamic
//
//  Created by 谢小龙 on 16/5/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "GravittyView.h"

@implementation GravittyView

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
