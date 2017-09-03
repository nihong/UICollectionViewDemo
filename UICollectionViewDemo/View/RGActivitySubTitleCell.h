//
//  RGActivitySubTitleCell.h
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 首页 - 活动 - 悬停的总标题 - 子标题
 */
@interface RGActivitySubTitleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;
@property (weak, nonatomic) IBOutlet UIView *subTitleBottomLine;

@end
