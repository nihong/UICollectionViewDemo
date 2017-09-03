//
//  RGActivitySubCouponCell.m
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivitySubCouponCell.h"
#import "Config.pch"
@interface RGActivitySubCouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *couponNumLB;
@property (weak, nonatomic) IBOutlet UILabel *couponRequirementLB;
@property (weak, nonatomic) IBOutlet UILabel *couponValidDate;
@property (weak, nonatomic) IBOutlet UILabel *couponGetLB;

@end
@implementation RGActivitySubCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UIImageView *bgIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rg_activitySubCouponBg"]];
    self.backgroundView  = bgIV;
    
    NSRange moneySignRange = NSMakeRange(0, 1);
    NSMutableAttributedString *couponNumAtt = [[NSMutableAttributedString alloc]initWithString:@"¥ 88"];
    [couponNumAtt setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSBaselineOffsetAttributeName:@(2)} range:moneySignRange];
    self.couponNumLB.attributedText = couponNumAtt;

    self.couponGetLB.layer.cornerRadius = 10.0f;
    self.couponGetLB.layer.masksToBounds = YES;
}

-(void)makeCouponSelected
{
    self.couponNumLB.textColor = HEXCOLOR(0xcccccc);
    self.couponRequirementLB.textColor = HEXCOLOR(0xcccccc);
    self.couponValidDate.textColor = HEXCOLOR(0xcccccc);
    self.couponGetLB.backgroundColor = HEXCOLOR(0xcccccc);
}

@end
