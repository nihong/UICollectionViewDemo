//
//  RGActivityCouponCell.h
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGActivityCouponCellDelegate <NSObject>

-(void)rg_activityCouponcell_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


/**
  首页 - 活动 - 全部优惠券 总cell
 */
@interface RGActivityCouponCell : UICollectionViewCell

@property (nonatomic,weak)id <RGActivityCouponCellDelegate> activityCouponCellDelegate;

@property (nonatomic,assign)NSInteger couponCount;
@end
