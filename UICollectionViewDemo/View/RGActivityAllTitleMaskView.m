//
//  RGActivityAllTitleMaskView.m
//  Vmei
//
//  Created by ios-02 on 2017/8/16.
//  Copyright © 2017年 com.vmei. All rights reserved.
//

#import "RGActivityAllTitleMaskView.h"
#import "RGActivitySubTitleCell.h"
#import "RGActivityMaskHeaderReusableView.h"
#import "Config.pch"

//// 设置颜色
//#define HEXCOLOR(rgbValue)          [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//
//// 设置颜色与透明度
//#define HEXCOLORAL(rgbValue, al)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]


static NSString * const headerIdentifier_Tip   = @"headerIdentifier_Tip";
static NSString * const  subTitleCellIdentifier = @"subTitleCellIdentifier";
@interface RGActivityAllTitleMaskView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIView *bottomView;

@end
@implementation RGActivityAllTitleMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLORAL(0x000000, 0.7);
        [self addSubview:self.allTitlesCollectionView];
        
        self.bottomView = [[UIView alloc]init];
        [self addSubview:self.bottomView];
        
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewClicked)];
        //        tapGesture.delegate = self;
        [self.bottomView addGestureRecognizer:tapGesture];
        
    }
    return self;
}



-(UICollectionView *)allTitlesCollectionView{
    if (!_allTitlesCollectionView ) {
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenSize.width/4, 39);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 8, 0);
        flowLayout.headerReferenceSize = CGSizeMake(kScreenSize.width, 44);
        _allTitlesCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 0) collectionViewLayout:flowLayout];
        _allTitlesCollectionView.delegate = self;
        _allTitlesCollectionView.dataSource = self;
        [_allTitlesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RGActivitySubTitleCell class]) bundle:nil] forCellWithReuseIdentifier:subTitleCellIdentifier];
        [_allTitlesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RGActivityMaskHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_Tip];
        _allTitlesCollectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _allTitlesCollectionView;
}

-(void)setAllSubTitlesArray:(NSArray *)allSubTitlesArray{
    _allSubTitlesArray = allSubTitlesArray;
    
    if (allSubTitlesArray.count > 0) {
        CGFloat collectionviewH = 44+10+(allSubTitlesArray.count/4+1)*39 + 8;
        self.bottomView.frame = CGRectMake(0, collectionviewH, kScreenSize.width, kScreenSize.height-20-44-collectionviewH);
        [UIView animateWithDuration:0.4 animations:^{
            self.allTitlesCollectionView.frame = CGRectMake(0, 0, kScreenSize.width, collectionviewH);
        }];
    }
}


-(void)maskViewClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_allTitleMaskViewBackgroundClicked:)]) {
        [self.delegate rg_allTitleMaskViewBackgroundClicked:self];
    }
}


#pragma mark
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allSubTitlesArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubTitleCell *subTitleCell = [collectionView dequeueReusableCellWithReuseIdentifier:subTitleCellIdentifier forIndexPath:indexPath];
    
    subTitleCell.subTitleLB.text  = self.allSubTitlesArray[indexPath.item];
    if (indexPath.item == _selectedIndex) {
        subTitleCell.subTitleLB.textColor = HEXCOLOR(0xe31436);
        
    }else{
        subTitleCell.subTitleLB.textColor = HEXCOLOR(0x333333);
        
    }
    subTitleCell.subTitleBottomLine.hidden = YES;
    return subTitleCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RGActivityMaskHeaderReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier_Tip forIndexPath:indexPath];
        header.backgroundColor = HEXCOLOR(0xffffff);
        return header;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RGActivitySubTitleCell * preCell = (RGActivitySubTitleCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    preCell.subTitleLB.textColor = HEXCOLOR(0x333333);
    preCell.subTitleBottomLine.hidden = YES;
    
    self.selectedIndex = indexPath.item;
    RGActivitySubTitleCell * currentCell = (RGActivitySubTitleCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    currentCell.subTitleLB.textColor = HEXCOLOR(0xe31436);
    currentCell.subTitleBottomLine.hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rg_maskView:subTitleCellClicked:indexpath:)]) {
        [self.delegate rg_maskView:self subTitleCellClicked:currentCell indexpath:indexPath];
    }

}

@end
