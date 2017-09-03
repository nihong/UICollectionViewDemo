//
//  RGActivityMainDescribleCell.m
//  Vmei
//
//  Created by ios-02 on 2017/8/14.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivityMainDescribleCell.h"
#import "Config.pch"
//#import "NSString+YYAdd.h"

@interface RGActivityMainDescribleCell ()

@property (nonatomic,strong)UILabel *titleLB;
@property (nonatomic,strong)UITextView * describleTV;

@end

@implementation RGActivityMainDescribleCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLB = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLB];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.font = [UIFont systemFontOfSize:19];
        self.titleLB.textColor = HEXCOLOR(0x333333);
        self.titleLB.frame = CGRectMake(0, 17.5, 25, frame.size.width);

        self.titleLB.text = @"标题";
        
        self.describleTV = [[UITextView alloc]init];
        [self.contentView addSubview:self.describleTV];
        self.describleTV.frame = CGRectMake(0, 46, frame.size.height-67, frame.size.width);

        self.describleTV.scrollEnabled = NO;
//        self.describleTV.backgroundColor = [UIColor greenColor];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment = NSTextAlignmentCenter;
        style.lineSpacing = 2.0;
        NSMutableAttributedString *describleAttri = [[NSMutableAttributedString alloc]initWithString:@"第一行\n第二行\n第3行\n第4行\n第5ashdfsjflaskfkiashfdfiuashdfasnhfjkdhafkhakjhfajhdfdjafkal第5ashdfsjflaskfkiashfdfiuashdfasnhfjkdhafkhakjhfajhdfdjafkal\n第6行\n第7\n第8行\n第9行\n第10行\n第11行\n第12行\n" attributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        self.describleTV.attributedText = describleAttri;
//        self.describleTV.textAlignment = NSTextAlignmentCenter;
        


        
        
    }

    return self;
}

@end
