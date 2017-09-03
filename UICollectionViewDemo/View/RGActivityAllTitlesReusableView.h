//
//  RGActivityAllTitlesReusableView.h
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RGActivityAllTitlesReusableViewDelegate <NSObject>
/**
    第indexPath.item 个副标题被点击
 */
-(void)rg_activityAllTitlesReusableView_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
    右侧显示全部标题的按钮被点击
 */
-(void)rg_activityAllTitlesReusableView_showAllTitleBtnClickedWithSelectedIndex:(NSInteger)index;
@end

/**
  首页 - 活动 - 悬停的总标题
 */
@interface RGActivityAllTitlesReusableView : UICollectionReusableView
@property (nonatomic,weak)id <RGActivityAllTitlesReusableViewDelegate> activityAllTitlesReusableViewDelegate;
@property (nonatomic,strong)UICollectionView * allTitlesContentView;
//@property (nonatomic,assign)NSInteger allTitlesCount;
@property (nonatomic,strong)NSArray *subTitlesArray;
@property (nonatomic,assign)NSInteger selectedIndex;
@end
