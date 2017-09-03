//
//  RGActivityCouponCell.m
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivityCouponCell.h"
#import "RGActivitySubCouponCell.h"
//#define kCollectionViewH  140
#define kEdgeTop    30
#define kEdgeBottom 30
#define kCouponW    155
#define kCouponH    80
#define kMagin      15

static NSString * const  couponSubCellIdentifier = @"couponSubCellIdentifier";
@interface RGActivityCouponCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong)UICollectionView * couponContentView;


@end

@implementation RGActivityCouponCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.couponCount = 5;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.couponContentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        self.couponContentView.delegate = self;
        self.couponContentView.dataSource = self;
        self.couponContentView.showsHorizontalScrollIndicator = NO;
        
        

        

        self.couponContentView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rg_activityCouponBg"]];
        
        self.couponContentView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [self.couponContentView registerNib:[UINib nibWithNibName:NSStringFromClass([RGActivitySubCouponCell class]) bundle:nil] forCellWithReuseIdentifier:couponSubCellIdentifier];
        [self.contentView addSubview:self.couponContentView];
    
        
    }
    return self;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.couponCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubCouponCell *couponCell = [collectionView dequeueReusableCellWithReuseIdentifier:couponSubCellIdentifier forIndexPath:indexPath];

    return couponCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCouponW, kCouponH);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kEdgeTop, 0, kEdgeBottom, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMagin;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubCouponCell * subCouponCell = (RGActivitySubCouponCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [subCouponCell makeCouponSelected];
    
    if (self.activityCouponCellDelegate && [self.activityCouponCellDelegate respondsToSelector:@selector(rg_activityCouponcell_collectionView:didSelectItemAtIndexPath:)]) {
        [self.activityCouponCellDelegate rg_activityCouponcell_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
