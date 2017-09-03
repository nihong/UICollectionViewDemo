//
//  RGActivitySubTitleReusableView.m
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivitySubTitleReusableView.h"
#import "Config.pch"
@interface RGActivitySubTitleReusableView ()



@end

@implementation RGActivitySubTitleReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf5f5f4);
        
        _subtitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 32)];
        _subtitleLB.center = self.center;
        _subtitleLB.font = [UIFont systemFontOfSize:14];
        _subtitleLB.textAlignment = NSTextAlignmentCenter;
        _subtitleLB.textColor = HEXCOLOR(0x333333);
//        _subtitleLB.center = self.center;
        [self addSubview:_subtitleLB];

        
    }
    return self;
}

@end
