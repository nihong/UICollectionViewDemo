//
//  RGActivityAllTitlesReusableView.m
//  Vmei
//
//  Created by ios-02 on 2017/8/15.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivityAllTitlesReusableView.h"
#import "RGActivitySubTitleCell.h"
#import "Config.pch"

#define kCollectionViewH  140
#define kEdgeTop    30
#define kEdgeBottom 30
#define kTitleCellW    96
#define kTitleCellH    44
#define kMagin      15

static NSString * const  subTitleCellIdentifier = @"subTitleCellIdentifier";
@interface RGActivityAllTitlesReusableView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation RGActivityAllTitlesReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.allTitlesContentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        self.allTitlesContentView.backgroundColor = [UIColor whiteColor];
        self.allTitlesContentView.delegate = self;
        self.allTitlesContentView.dataSource = self;
        self.allTitlesContentView.showsHorizontalScrollIndicator = NO;
        self.allTitlesContentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 44);
        [self.allTitlesContentView registerNib:[UINib nibWithNibName:NSStringFromClass([RGActivitySubTitleCell class]) bundle:nil] forCellWithReuseIdentifier:subTitleCellIdentifier];
        [self addSubview:self.allTitlesContentView];
        
        
        UIButton * showAllTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showAllTitleBtn.frame = CGRectMake(frame.size.width-56, 0, 56, 44);
        [self addSubview:showAllTitleBtn];
        [showAllTitleBtn setImage:[UIImage imageNamed:@"rg_activityAllTitleHeaderShowAllBtn"] forState:UIControlStateNormal];
        [showAllTitleBtn addTarget:self action:@selector(showAllTitleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)showAllTitleBtnClicked{
    if (self.activityAllTitlesReusableViewDelegate && [self.activityAllTitlesReusableViewDelegate respondsToSelector:@selector(rg_activityAllTitlesReusableView_showAllTitleBtnClickedWithSelectedIndex:)]) {
        [self.activityAllTitlesReusableViewDelegate rg_activityAllTitlesReusableView_showAllTitleBtnClickedWithSelectedIndex:self.selectedIndex];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [_allTitlesContentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [_allTitlesContentView reloadData];
}
#pragma mark - UICollectionView Delegate & DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subTitlesArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubTitleCell *subTitleCell = [collectionView dequeueReusableCellWithReuseIdentifier:subTitleCellIdentifier forIndexPath:indexPath];

    subTitleCell.subTitleLB.text  = self.subTitlesArray[indexPath.item];
    if (indexPath.item == _selectedIndex) {
        subTitleCell.subTitleLB.textColor = HEXCOLOR(0xe31436);
        subTitleCell.subTitleBottomLine.hidden = NO;
    }else{
        subTitleCell.subTitleLB.textColor = HEXCOLOR(0x333333);
        subTitleCell.subTitleBottomLine.hidden = YES;
    }
    
    return subTitleCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kTitleCellW, kTitleCellH);
}


//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(kEdgeTop, 0, kEdgeBottom, 0);
//}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMagin;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubTitleCell * preCell = (RGActivitySubTitleCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    preCell.subTitleLB.textColor = HEXCOLOR(0x333333);
    preCell.subTitleBottomLine.hidden = YES;
    
    self.selectedIndex = indexPath.item;
    RGActivitySubTitleCell * currentCell = (RGActivitySubTitleCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    currentCell.subTitleLB.textColor = HEXCOLOR(0xe31436);
    currentCell.subTitleBottomLine.hidden = NO;
    
    if (self.activityAllTitlesReusableViewDelegate && [self.activityAllTitlesReusableViewDelegate respondsToSelector:@selector(rg_activityAllTitlesReusableView_collectionView:didSelectItemAtIndexPath:)]) {
        [self.activityAllTitlesReusableViewDelegate rg_activityAllTitlesReusableView_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}



@end
