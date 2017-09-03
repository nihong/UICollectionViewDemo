//
//  RGActivityAllTitleMaskView.h
//  Vmei
//
//  Created by ios-02 on 2017/8/16.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RGActivityAllTitleMaskView;
@class RGActivitySubTitleCell;
@protocol RGActivityAllTitleMaskViewDelegate <NSObject>

-(void)rg_allTitleMaskViewBackgroundClicked:(RGActivityAllTitleMaskView *)mask;
-(void)rg_maskView:(RGActivityAllTitleMaskView *)mask subTitleCellClicked:(RGActivitySubTitleCell *)cell indexpath:(NSIndexPath *)indexpath;
@end

/**
 首页活动页面进入后 - 点击 ⬇️ V -显示的蒙版及所有标题
 */
@interface RGActivityAllTitleMaskView : UIView

@property (nonatomic,strong)NSArray * allSubTitlesArray;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,strong)UICollectionView *allTitlesCollectionView;

@property (nonatomic,weak)id<RGActivityAllTitleMaskViewDelegate>  delegate;
@end
